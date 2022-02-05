variable "region" {
  description = "The region in which to create the resources"
  type        = string
  default     = "us-east-1"
}

# https://dowjones.github.io/hammer/deployment_terraform.html#2-configure-aws-cli-access-credentials
variable "profile" {
  description = "The profile to use for AWS CLI access"
  type        = string
  default     = "ucloud"
}