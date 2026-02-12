output "email_domain_id" {
  value = oci_email_email_domain.email_domain.id
}

output "email_domain_name" {
  value = oci_email_email_domain.email_domain.name
}

output "dkim_record" {
  value = {
    cname_record = oci_email_dkim.email_dkim.cname_record_value
    txt_record   = oci_email_dkim.email_dkim.txt_record_value
  }
}

output "approved_senders" {
  value = {
    for sender in oci_email_sender.approved_senders : sender.email_address => sender.id
  }
}

output "smtp_user_id" {
  value = var.generate_smtp_credentials ? oci_identity_user.smtp_user[0].id : null
}

output "generated_smtp_password" {
  depends_on = [oci_identity_smtp_credential.smtp_credential]
  value      = var.generate_smtp_credentials ? oci_identity_smtp_credential.smtp_credential[0].password : null
  sensitive  = false
}

output "generated_smtp_username" {
  depends_on = [oci_identity_smtp_credential.smtp_credential]
  value      = var.generate_smtp_credentials ? oci_identity_smtp_credential.smtp_credential[0].username : null
  sensitive  = false
}

output "generated_dkim_txt_record" {
  # Changed from dkim to email_dkim
  depends_on = [oci_email_dkim.email_dkim]
  value      = var.generate_smtp_credentials ? oci_email_dkim.email_dkim.txt_record_value : null
  sensitive  = false
}

output "generated_dkim_cname_record" {
  # Changed from dkim to email_dkim
  depends_on = [oci_email_dkim.email_dkim]
  value      = var.generate_smtp_credentials ? oci_email_dkim.email_dkim.cname_record_value : "not delivered"
  sensitive  = false
}

output "smtp_host" {
  value = "smtp.email.${var.region}.oci.oraclecloud.com"
}
