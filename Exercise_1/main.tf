provider "aws" {
  access_key = "<access_key>"
  secret_key = "<secret_key>"
  region = "us-east-1"
}

variable "vpc" {
  type = string
  default = "seckinger_udacity"
}
variable "ami" {
  type = string
  default = "ami-0c6b1d09930fac512"
}

data "aws_vpc" "selected" {
  tags = {
    Name = var.vpc
  }
}

data "aws_subnet_ids" "public" {
  vpc_id = data.aws_vpc.selected.id
  tags = {
    Name = "Public subnet"
  }
}

resource "aws_instance" "Udacity_T2" {
  count = 4
  ami = var.ami
  instance_type = "t2.micro"
  subnet_id = element(sort(data.aws_subnet_ids.public.ids), count.index)

  tags = {
    Name = "Udacity T2"
  }
}

resource "aws_instance" "Udacity_M4" {
  count = 2
  ami = var.ami
  instance_type = "m4.large"
  subnet_id = element(sort(data.aws_subnet_ids.public.ids), count.index)

  tags = {
    Name = "Udacity M4"
  }
}
