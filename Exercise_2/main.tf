provider "aws" {
  region  = var.region
  profile = var.profile
}

terraform {
  required_providers {
    aws = {
      version = "~> 2.0"
    }
  }
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "greet_lambda.py"
  output_path = "greet_lambda.zip"
}


resource "aws_lambda_function" "test_lambda" {
  filename         = "greet_lambda.zip"
  function_name    = "greet_lambda"
  role             = aws_iam_role.iam_for_lambda_tf[0].arn
  handler          = "greet_lambda.lambda_handler"
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  runtime          = "python3.8"
}

resource "aws_iam_role" "iam_for_lambda_tf" {
  name = "iam_for_lambda_tf_03"
  count = 1   # trying to work around permission limitations that does not allow to modify or delete IAM roles
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}