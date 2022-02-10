# TODO: Designate a cloud provider, region, and credentials
provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

# Provision 4 AWS t2.micro EC2 instances named Udacity T2
resource "aws_instance" "Udacity_T2" {
  ami           = "ami-033b95fb8079dc481" // Amazon Linux 2
  instance_type = "t2.micro"
  count         = 4
  subnet_id     = "subnet-0af813fd84c880467"
  tags = {
    Name = "Udacity_T2"
  }
}

# Provision 2 m4.large EC2 instances named Udacity M4
resource "aws_instance" "Udacity_M4" {
  ami           = "ami-033b95fb8079dc481" // Amazon Linux 2
  instance_type = "m4.large"
  count         = 2
  subnet_id     = "subnet-0af813fd84c880467"
  tags = {
    Name = "Udacity_M4"
  }
}