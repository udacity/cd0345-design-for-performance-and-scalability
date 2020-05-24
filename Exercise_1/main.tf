# TODO: Designate a cloud provider, region, and credentials
provider "aws" {
  access_key = <your access key>
  secret_key = <your secret key>
  region = "ap-south-1"
  }

# TODO: provision 4 AWS t2.micro EC2 instances named Udacity T2
resource "aws_instance" "Udacity_T2" {
  count = "4"
  ami = "ami-0470e33cd681b2476"
  instance_type = "t2.micro"
  tags = {
    name = "Udacity T2"
    }
  }

# TODO: provision 2 m4.large EC2 instances named Udacity M4
resource "aws_instance" "Udacity_M4" {
  count = "2"
  ami = "ami-0470e33cd681b2476"
  instance_type = "m4.large"
  tags = {
    name = "Udacity M4"
    }
  }
