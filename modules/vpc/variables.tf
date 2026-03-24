variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "name_prefix" {
  type        = string
  description = "Prefix used for naming all resources"
}

variable "availability_zones" {
  type        = list(string)
  description = "List of availability zones to deploy subnets into"
}

variable "common_tags" {
  type        = map(string)
  description = "Common tags applied to all resources"
}