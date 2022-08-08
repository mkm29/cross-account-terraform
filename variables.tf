# AWS account region for user accounts
variable "region_shared" {
  type    = string
  default = "us-gov-east-1"
}

# AWS account region for prod account
variable "region_prod" {
  type    = string
  default = "us-gov-east-1"
}
