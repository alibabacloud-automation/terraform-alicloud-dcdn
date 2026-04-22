output "this_domain_name" {
  description = "The domain name."
  value       = local.domain_name
}

output "this_domain_status" {
  description = "The domain status."
  value       = concat(alicloud_dcdn_domain.this[*].status, [""])[0]
}

output "this_domain_config_ids" {
  description = "The id of list of domain configs."
  value       = concat(alicloud_dcdn_domain_config.this[*].config_id)
}