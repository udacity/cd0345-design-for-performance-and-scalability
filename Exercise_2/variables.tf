# TODO: Define the variable for aws_region
variable "aws_region" {
  default = "us-east-1"
}

variable "aws_access_key" {
  default = "xxxxxxxxxxxx"
}
variable "aws_secret_key" {
  default = "xxxxxxxxxxxx"
}
variable "lambda_name" {
  default = "lambda"
}

variable "lambda_output_path" {
  default = "output.zip"
}
