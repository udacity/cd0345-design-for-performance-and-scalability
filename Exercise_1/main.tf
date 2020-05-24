# TODO: Designate a cloud provider, region, and credentials
provider "aws" {
  aws_access_key_id = "AKIAJC6SZH3TNIMKBIPQ"
  aws_secret_access_key = "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"
  region = "ap-south-1"
  }

# TODO: provision 4 AWS t2.micro EC2 instances named Udacity T2
resource "aws_instance" "Udacity T2" {
  count = "4"
  ami = "ami-0470e33cd681b2476"
  instance_type = "t2.micro"
  }

# TODO: provision 2 m4.large EC2 instances named Udacity M4
resource "aws_instance" "Udacity M4" {
  count = "2"
  ami = "ami-0470e33cd681b2476"
  instance_type = "m4.large"
  }
