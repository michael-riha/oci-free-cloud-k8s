# ============================================================
# Email Delivery Service (Optional)
# Completely isolated from main OKE configuration
# ============================================================

# This entire file is ignored when enable_email_delivery = false
# because count = 0 destroys all resources and variables are not evaluated

module "email_delivery" {
  count = var.enable_email_delivery ? 1 : 0

  source = "./modules/email-delivery"

  tenancy_id     = var.compartment_id
  compartment_id = var.compartment_id
  region           = var.region
  
  # Only accessed when enabled, so null check not strictly needed
  # but good for defensive programming
  email_domain           = var.email_delivery_config.domain
  approved_senders       = var.email_delivery_config.approved_senders
  generate_smtp_credentials = var.email_delivery_config.generate_smtp_credentials
  smtp_user_name         = var.email_delivery_config.smtp_user_name
  smtp_user_email         = var.email_delivery_config.smtp_user_email
  suppressed_recipients  = var.email_delivery_config.suppressed_recipients
  
  tags = {
    # Environment = var.environment
    Environment = "OKE Cluster"
    ManagedBy   = "terraform"
  }
}

# Optional: Local outputs for email only
locals {
  email_outputs = var.enable_email_delivery ? {
    domain_id    = module.email_delivery[0].email_domain_id
    smtp_host    = module.email_delivery[0].smtp_host
    dkim_record  = module.email_delivery[0].dkim_record
  } : {
    domain_id    = null
    smtp_host    = null
    dkim_record  = {
      cname_record = null
      txt_record   = null
    }
  }
}
