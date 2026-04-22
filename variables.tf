
# DCDN Domain variables
variable "create_domain" {
  description = "Whether to create a new DCDN domain. If true, the domain_name is required."
  type        = string
  default     = ""
}

variable "domain_name" {
  description = "The name DCDN domain. If it not existed, please set create_domain to true to create a new one."
  type        = string
  default     = ""
}

variable "check_url" {
  description = "The URL that is used to test the accessibility of the origin."
  type        = string
  default     = ""
}

variable "resource_group_id" {
  description = "The ID of the resource group."
  type        = string
  default     = ""
}

variable "scope" {
  description = "The acceleration region. Valid values: overseas, domestic, global."
  type        = string
  default     = "domestic"
}

variable "sources" {
  description = "The origin information."
  type        = map(string)
  default     = {}
}

variable "status" {
  description = "The domain status. Valid values: online, offline."
  type        = string
  default     = "online"
}

# DCDN Domain config variables
variable "domain_configs" {
  description = "The domain configs."
  type = list(object({
    function_name = string
    function_args = list(object({
      arg_name  = string
      arg_value = string
    }))
  }))
  default = []
}