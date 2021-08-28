# Designate a cloud provider, region, and credentials
provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region = var.zones["virgninia"]
}

resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

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
resource "aws_iam_policy" "lambda_logging" {
  name        = "lambda_logging"
  path        = "/"
  description = "IAM policy for logging from a lambda"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.lambda_logging.arn
}

# provision a Lambda
data "archive_file" "lambda_archive"{
  type        = "zip"
  source_file = "greet_lambda.py"
  output_path = "greet_lambda.zip"
}

resource "aws_lambda_function" "ucadity_lambda" {
   function_name = "greet_lambda"
   filename = "greet_lambda.zip"
   handler = "greet_lambda.lambda_handler"
   runtime = "python3.8"
   role = aws_iam_role.iam_for_lambda.arn
   environment {
    variables = {
      greeting = "Hello Lambda from terraform"
    }
  }
  depends_on = [
    aws_iam_role_policy_attachment.lambda_logs,
  ]
}