# TODO: Designate a cloud provider, region, and credentials
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.50.0"
    }
  }
}

provider "aws" {
  region = "eu-west-1"
}
variable "subnet_cidr_block" {
  description = "Subnet cidr block"
}

data "aws_vpc" "ud_existing_vpc" {
  default = true
}

resource "aws_subnet" "udacity-lab-subnet-2" {
  vpc_id            = data.aws_vpc.ud_existing_vpc.id
  cidr_block        = var.subnet_cidr_block
  availability_zone = "eu-west-1c"

  tags = {
    "Name" = "cloud-lab-subnet"
  }
}
# TODO: provision 4 AWS t2.micro EC2 instances named Udacity T2
resource "aws_instance" "udacity-t2dev" {
  count         = 4 # create four similar EC2 instances
  ami           = "ami-058b1b7fe545997ae"
  instance_type = "t2.micro"

  tags = {
    "Name"      = "Udacity T2"
    Terraform   = "true"
    Environment = "dev"
  }
}

# TODO: provision 2 m4.large EC2 instances named Udacity M4
resource "aws_instance" "udacity-m4dev" {
  count         = 2 # create two similar EC2 instances
  ami           = "ami-058b1b7fe545997ae"
  instance_type = "m4.large"

  tags = {
    "Name" = "Udacity M4"
  }
}
