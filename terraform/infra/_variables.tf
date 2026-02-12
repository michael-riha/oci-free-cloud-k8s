variable "compartment_id" {
  type        = string
  description = "The compartment to create the resources in"
}

variable "region" {
  description = "OCI region"
  type        = string

  default = "eu-frankfurt-1"
}

variable "ssh_public_key_path" {
  description = "SSH Public Key Path used to access all instances"
  type        = string

  default = "~/.oci/oci_api_key_public.pub"
}

variable "kubernetes_version" {
  # https://docs.oracle.com/en-us/iaas/Content/ContEng/Concepts/contengaboutk8sversions.htm
  description = "Version of Kubernetes"
  type        = string

  default = "v1.33.1"
}

variable "kubernetes_worker_nodes" {
  description = "Worker node count"
  type        = number

  default = 2
}

# Email Delivery Feature Flag
variable "enable_email_delivery" {
  description = "Enable OCI Email Delivery service. When false, ed.tf is effectively ignored."
  type        = bool
  default     = false
}

# Email Delivery Configuration (null when disabled)
variable "email_delivery_config" {
  description = "Email Delivery configuration. Only used if enable_email_delivery = true."
  type = object({
    domain                    = string
    approved_senders          = list(string)
    generate_smtp_credentials = optional(bool, true)
    smtp_user_name           = optional(string, "email-smtp-user")
    smtp_user_email          = optional(string, null)
    suppressed_recipients    = optional(list(string), [])
  })
  default = null
}
