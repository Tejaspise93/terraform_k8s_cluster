variable "name_prefix" {
  type        = string
  description = "Prefix used for naming all resources"
}

variable "common_tags" {
  type        = map(string)
  description = "Common tags applied to all resources"
}

variable "account_id" {
  type        = string
  description = "AWS account ID"
}