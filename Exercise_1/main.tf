# TODO: Designate a cloud provider, region, and credentials


# TODO: provision 4 AWS t2.micro EC2 instances named Udacity T2


# TODO: provision 2 m4.large EC2 instances named Udacity M4
# TODO: Designate a cloud provider, region, and credentials

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-1"
}

data "aws_subnets" "selected_subnets" {
  filter {
    name   = "vpc-id"
    values = ["vpc-0d82d7c18f1918c96"]
  }
}

data "aws_ssm_parameter" "latest_amazon_linux_ami" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

resource "aws_security_group" "ssh_group" {
  name_prefix = "ssh-group-"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allowing SSH from any IP.
  }
}

resource "aws_instance" "udacity_instance_t2_micro" {
  count                  = 4
  ami                    = data.aws_ssm_parameter.latest_amazon_linux_ami.value
  instance_type          = "t2.micro"
  key_name               = "ec2_default"
  subnet_id              = element(data.aws_subnets.selected_subnets.ids, count.index)
  vpc_security_group_ids = [aws_security_group.ssh_group.id]
  tags = {
    Name      = "Udacity T2"
    ManagedBy = "terraform"
  }
}

# # TODO: provision 2 m4.large EC2 instances named Udacity M4

# resource "aws_instance" "udacity_instance_m4_large" {
#   count                  = 2
#   ami                    = data.aws_ssm_parameter.latest_amazon_linux_ami.value
#   instance_type          = "m4.large"
#   key_name               = "ec2_default"
#   subnet_id              = element(data.aws_subnets.selected_subnets.ids, count.index)
#   vpc_security_group_ids = [aws_security_group.ssh_group.id]
#   tags = {
#     Name      = "Udacity M4"
#     ManagedBy = "terraform"
#   }
# }



