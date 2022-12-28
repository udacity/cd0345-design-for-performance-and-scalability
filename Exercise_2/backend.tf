terraform {
  backend "s3" {
    bucket = "terra-udacity-bucket"
    key    = "Users/sandeepkesarwani/Desktop/work/udacity/terraform/terraform.tfstate"
    region = "us-east-1"
  }
}
