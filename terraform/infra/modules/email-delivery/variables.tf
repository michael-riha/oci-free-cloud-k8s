variable "tenancy_id" {
  type = string
}

variable "compartment_id" {
  type = string
}

variable "region" {
  type = string
}

variable "email_domain" {
  type = string
}

variable "approved_senders" {
  type    = list(string)
  default = []
}

variable "generate_smtp_credentials" {
  type    = bool
  default = true
}

variable "smtp_user_name" {
  type    = string
  default = "email-smtp-user"
}

variable "smtp_user_email" {
  description = "Email address for the SMTP user (required by OCI Identity)"
  type        = string
  default     = null  # Make optional, but validate in module
}

variable "suppressed_recipients" {
  type    = list(string)
  default = []
}

variable "tags" {
  type    = map(string)
  default = {}
}
