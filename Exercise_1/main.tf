provider "aws" {
  access_key = "AKIAJCMFJWC4L6AE6QWA"
  secret_key = "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"
  region = "us-east-1"
}

variable "vpc" {
  type = string
  default = "Udacity-VPC"
}
variable "ami" {
  type = string
  default = "ami-02354e95b39ca8dec"
}

resource "aws_instance" "UdacityT2" {
  count = "4"
  ami = var.ami
  instance_type = "t2.micro"
  tags = {
    name = "Udacity Terraform"
  }
}

resource "aws_instance" "UdacityM4" {
  count = "2"
  ami =  var.ami
  instance_type = "m4.large"
  tags = {
    name = "Udacity Terraform"
  }
}