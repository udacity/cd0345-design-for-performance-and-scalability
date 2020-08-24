provider "aws" {
  access_key = ""
  secret_key = ""
  region = "us-east-1"
}


resource "aws_lambda_function" "UdacityLambda" {
  function_name = "greet_lambda"
  handler = "greet_lambda.lambda_handler"
  role = "arn:aws:iam::408612950575:role/aws.aruns.lambda"
  runtime = "python3.8"
  filename = "greet_lambda.py.zip"
}