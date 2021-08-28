# Define the variable for aws_region
variable "access_key" {
  type = string
  default = "AKIAWJ27X3YZGM4Y7XME"
}

variable "secret_key" {
  type = string
  default = "CwZE/gOXKLCDc9dBdGvL6AKqsgwUT+sztWIRUHlc"
}

variable "zones" {
  type = map
  default ={
      "virgninia" = "us-east-1"
  } 
}