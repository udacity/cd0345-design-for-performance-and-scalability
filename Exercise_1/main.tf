# Designate a cloud provider, region, and credentials
provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region = var.zones["virgninia"]
}

# provision 4 AWS t2.micro EC2 instances named Udacity T2

resource "aws_instance" "Udacity_T2" {
  count = 4
  ami           = "ami-0742b4e673072066f"
  instance_type = "t2.micro"
  tags = {
    project = "udacity-project"
  }
}

# provision 2 m4.large EC2 instances named Udacity M4
resource "aws_instance" "Udacity_M4" {
  count = 2
  ami           = "ami-0742b4e673072066f"
  instance_type = "m4.large"
  tags = {
    project = "udacity-project"
  }
}