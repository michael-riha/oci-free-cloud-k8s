terraform {
  required_providers {
    oci = {
      source = "oracle/oci"
    }
  }
}

data "oci_identity_tenancy" "tenancy" {
  tenancy_id = var.tenancy_id
}

data "oci_identity_regions" "home-region" {
  filter {
    name   = "key"
    values = [data.oci_identity_tenancy.tenancy.home_region_key]
  }
}

data "oci_identity_regions" "current-region" {
  filter {
    name   = "name"
    values = [var.region]
  }
}

data "oci_identity_compartment" "compartment" {
  id = var.compartment_id
}

# Email Domain
resource "oci_email_email_domain" "email_domain" {
  compartment_id = var.compartment_id
  name           = var.email_domain
  freeform_tags  = var.tags
}

# DKIM
resource "oci_email_dkim" "email_dkim" {
  email_domain_id = oci_email_email_domain.email_domain.id
  freeform_tags   = var.tags
}

# Approved Senders
resource "oci_email_sender" "approved_senders" {
  for_each = toset(var.approved_senders)

  compartment_id = var.compartment_id
  email_address  = each.value
  freeform_tags  = var.tags
}

# https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/identity_smtp_credential#user_id-1
# SMTP Credentials (optional)

# Or use the first approved sender as default:
#locals {
#  smtp_email = var.smtp_user_email != null ? var.smtp_user_email : var.approved_senders[0]
#}

resource "oci_identity_user" "smtp_user" {
  count = var.generate_smtp_credentials ? 1 : 0

  compartment_id = var.tenancy_id
  description    = "User for Email Delivery SMTP authentication"
  name           = var.smtp_user_name

  # ADD THIS - Required by OCI
  email = var.smtp_user_email  # Required variable
  # email = local.smtp_email

  freeform_tags  = var.tags
}

resource "oci_identity_group" "smtp_group" {
  count = var.generate_smtp_credentials ? 1 : 0

  compartment_id = var.tenancy_id
  description    = "Group for Email Delivery users"
  name           = "${var.smtp_user_name}-group"
  freeform_tags  = var.tags
}

resource "oci_identity_smtp_credential" "smtp_credential" {
    count = var.generate_smtp_credentials ? 1 : 0

    description = "pure credentials of the smtp user"
    user_id = oci_identity_user.smtp_user[0].id
}

resource "oci_identity_user_group_membership" "smtp_user_group_membership" {
  count = var.generate_smtp_credentials ? 1 : 0

  group_id = oci_identity_group.smtp_group[0].id
  user_id  = oci_identity_user.smtp_user[0].id
}

resource "oci_identity_policy" "smtp_policy" {
  count = var.generate_smtp_credentials ? 1 : 0

  compartment_id = var.tenancy_id
  description    = "Policy for Email Delivery"
  name           = "${var.smtp_user_name}-policy"
  statements = [
    "Allow group ${oci_identity_group.smtp_group[0].name} to use email-family in compartment id ${var.compartment_id}"
  ]
  freeform_tags = var.tags
}

# Suppression List
resource "oci_email_suppression" "suppressions" {
  for_each = toset(var.suppressed_recipients)
  compartment_id = var.compartment_id
  email_address  = each.value
}
