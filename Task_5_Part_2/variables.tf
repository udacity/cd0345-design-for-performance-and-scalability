variable "aws_region" {
  description = "Variable for aws_region"
  type        = string
  default     = "us-east-1"
}

variable "zip_package" {
  description = "Name of zip package"
  type        = string
  default     = "lambda.zip"
}

variable "handler" {
  default = "greet_lambda.lambda_handler"
}

variable "runtime" {
  default = "python3.6"
}

variable "function_name" {
  default = "udacity_project_terraform"
}