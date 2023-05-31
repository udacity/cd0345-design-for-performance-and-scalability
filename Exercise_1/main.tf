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
  access_key = "ASIAW3Z7LJULSDXHZQMQ"
  secret_key = "xJZ+RIZxt6zvZL1zn+yXfy+fhlRI/Pd3gBf6Trdd"
  token      = "FwoGZXIvYXdzEID//////////wEaDAbAYxODdKDcT3RvHyLVAfksJ3v2IVNA1VoEhcSMbr8PxZrZb89EtwhvEuwK16kkNaXQjQW7NkxnT7snRST/sY4AyxXSbGHPuXuteU9cDjFshMZN4qCxoIEcRY1Mno4izlGxG6Oqic7/zUR9l+mfdMhWeemsEKgV/PfZkFoyKLEii8ErA+H3igFX1c4g8LwnFJD0IKAUlc8ugGxViUAK7RL6G8Kk/D82gVX4O+wb8gWQQ5FqiL/9rJaxzB9OBfu3WmhHksFxwQ7BzQ6MDy5b44s4iuwmQXxqGvj33YVFNCbbd4B/aCiAud2jBjIt4Tzqtm0vdQg0ElquqEycf+jQgcqkasXL2UEIU0ALWoQFa88/fCuFqlYrOo9D"
  region     = "us-east-1"
}

# TODO: provision 4 AWS t2.micro EC2 instances named Udacity T2
resource "aws_instance" "Udacity_T2" {
  ami           = "ami-0715c1897453cabd1"
  subnet_id     = "subnet-046ada3ce794ac81f"
  count         = 4
  instance_type = "t2.micro"
  tags          = {
    Name = "Udacity T2"
  }
}

# TODO: provision 2 m4.large EC2 instances named Udacity M4
resource "aws_instance" "Udacity_M4" {
  ami           = "ami-0715c1897453cabd1"
  subnet_id     = "subnet-046ada3ce794ac81f"
  count         = 2
  instance_type = "m4.large"
  tags          = {
    Name = "Udacity M4"
  }
}