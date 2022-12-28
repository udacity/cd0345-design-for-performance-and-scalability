provider "aws" {
  region = "us-east-1"
}

locals {
  serverconfig = [
    for srv in var.configuration : [
      for i in range(1, srv.no_of_instances+1) : {
        instance_name = "${srv.app_name}-${i}"
        instance_type = srv.instance_type
        subnet_id   = srv.subnet_id
        ami = srv.ami
      }
    ]
  ]
}

locals {
  instances = flatten(local.serverconfig)
}

resource "aws_instance" "ec2_instance" {
    for_each = {for server in local.instances: server.instance_name =>  server}
    ami           = each.value.ami
    instance_type = each.value.instance_type
    subnet_id = each.value.subnet_id
    tags = {
      Name = "${each.value.instance_name}"
    }
}