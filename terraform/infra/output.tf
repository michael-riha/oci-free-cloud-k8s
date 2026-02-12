output "k8s_cluster_id" {
  value = oci_containerengine_cluster.k8s_cluster.id
}

output "compartment_id" {
  value = var.compartment_id
}

output "public_subnet_id" {
  value = oci_core_subnet.vcn_public_subnet.id
}

output "node_pool_id" {
  value = oci_containerengine_node_pool.k8s_node_pool.id
}

output "kubernetes_version" {
  value = var.kubernetes_version
}

# Safe conditional outputs for email
output "email_domain_id" {
  value = var.enable_email_delivery ? module.email_delivery[0].email_domain_id : null
}

output "email_smtp_host" {
  value = var.enable_email_delivery ? module.email_delivery[0].smtp_host : null
}

output "email_dkim_record" {
  value = var.enable_email_delivery ? module.email_delivery[0].dkim_record : null
  sensitive = true
}

output "email_dkim_txt_record" {
  value = var.enable_email_delivery ? module.email_delivery[0].generated_dkim_txt_record : null
}

output "email_dkim_cname_record" {
  value = var.enable_email_delivery ? module.email_delivery[0].generated_dkim_cname_record : null
}

output "email_smtp_username" {
  value = var.enable_email_delivery ? module.email_delivery[0].generated_smtp_username : null
}

output "email_smtp_password" {
  value = var.enable_email_delivery ? module.email_delivery[0].generated_smtp_password : null
}
