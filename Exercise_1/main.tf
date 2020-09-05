# Designate a cloud provider, region, and credentials
provider "aws" {
  profile = "sandbox-xander-guzman"
  region = "us-west-2"
}

# Provision 4 AWS t2.micro EC2 instances named Udacity T2
resource "aws_instance" "Udacity-T2" {
  ami = "ami-01ce4793a2f45922e"
  instance_type = "t2.micro"  
  count = 4
  vpc_security_group_ids = [ "sg-0d148b571175eb3b0" ]
  subnet_id = "subnet-031ad15eb841926f4"

  tags = {
    Name = "Udacity-T2 ${count.index}"
  }
}


# Provision 2 m4.large EC2 instances named Udacity M4
resource "aws_instance" "Udacity-M4" {
  ami = "ami-01ce4793a2f45922e"
  instance_type = "m4.large"  
  count = 2
  vpc_security_group_ids = [ "sg-0d148b571175eb3b0" ]
  subnet_id = "subnet-031ad15eb841926f4"

  tags = {
    Name = "Udacity-M4 ${count.index}"
  }
}
