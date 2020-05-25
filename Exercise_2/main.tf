provider "aws" {
  region = var.aws_region
}

resource "aws_lambda_function" "lambda" {
  function_name = "greet_lambda"

  filename         = data.archive_file.zip.output_path
  source_code_hash = data.archive_file.zip.output_base64sha256

  role    = aws_iam_role.iamlambda.arn
  handler = "greet_lambda.lambda_handler"
  runtime = "python3.6"

  environment {
    variables = {
      greeting = "Welcome"
    }
  }
}

provider "archive" {}

data "archive_file" "zip" {
  type        = "zip"
  source_file = "greet_lambda.py"
  output_path = "greet_lambda.zip"
}

data "aws_iam_policy_document" "policy" {
  statement {
    sid    = ""
    effect = "Allow"

    principals {
      identifiers = ["lambda.amazonaws.com"]
      type        = "Service"
    }

    actions = [
        "sts:AssumeRole"
    ]
  }
}


resource "aws_iam_role" "iamlambda" {
  name               = "iamlambda"
  assume_role_policy = data.aws_iam_policy_document.policy.json
}

resource "aws_cloudwatch_log_group" "cloudwatch" {
  name              = "/aws/lambda/greet_lambda"
  retention_in_days = 14
}

resource "aws_iam_policy" "lambdalogs" {
  name        = "lambdalogs"
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

resource "aws_iam_role_policy_attachment" "logs" {
  role       = aws_iam_role.iamlambda.name
  policy_arn = aws_iam_policy.lambdalogs.arn
}
