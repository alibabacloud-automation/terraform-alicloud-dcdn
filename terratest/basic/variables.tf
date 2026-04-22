# DCDN Domain variables
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
variable "sources" {
  description = "The origin information."
  type        = map(string)
  default     = null
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
