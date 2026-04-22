data "alicloud_resource_manager_resource_groups" "default" {
}

module "dcdn" {
  source = "../.."

  #alicloud_dcdn_domain
  create_domain     = true
  domain_name       = "168.com"
  resource_group_id = data.alicloud_resource_manager_resource_groups.default.groups[0].id
  scope             = var.scope
  sources           = var.sources
  status            = var.status

  #alicloud_dcdn_domain_config
  domain_configs = [
    {
      function_name = "ip_allow_list_set"
      function_args = var.function_args
    }
  ]

}