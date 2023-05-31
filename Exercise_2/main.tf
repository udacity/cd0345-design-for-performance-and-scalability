terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  token      = var.token
  region     = var.region
}

resource "aws_iam_role" "iam_assume_role" {
  name               = "iam_assume_role"
  assume_role_policy = jsonencode({
    Version   = "2012-10-17",
    Statement = [
      {
        Sid       = "VisualEditor0",
        Effect    = "Allow",
        Action    = "sts:AssumeRole",
        Principal = {
          Service = ["lambda.amazonaws.com"]
        }
      }
    ]
  })
}

resource "aws_iam_policy" "lambda_log" {
  name        = "lambda_log"
  path        = "/"
  description = "IAM policy for lambda log"
  policy      = jsonencode({
    Version   = "2012-10-17",
    Statement = [
      {
        Sid    = "VisualEditor0",
        Effect = "Allow",
        Action = [
          "logs:CreateLogStream",
          "logs:CreateLogGroup"
        ],
        Resource = "arn:aws:logs:*:472042392855:log-group:*"
      },
      {
        Sid      = "VisualEditor1",
        Effect   = "Allow",
        Action   = "logs:PutLogEvents",
        Resource = "arn:aws:logs:*:472042392855:log-group:*:log-stream:*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_log_policy" {
  role       = aws_iam_role.iam_assume_role.name
  policy_arn = aws_iam_policy.lambda_log.arn

}

resource "aws_cloudwatch_log_group" "udacity_log_group" {
  name              = "/aws/lambda/lambda_udacity_project"
  retention_in_days = 14
}

data "archive_file" "python_lambda_zip" {
  type        = "zip"
  source_file = "./greet_lambda.py"
  output_path = "greet_lambda.zip"
}

resource "aws_lambda_function" "lambda_udacity_project" {
  function_name    = "lambda_udacity_project"
  filename         = "greet_lambda.zip"
  role             = aws_iam_role.iam_assume_role.arn
  handler          = "greet_lambda.lambda_handler"
  source_code_hash = data.archive_file.python_lambda_zip.output_base64sha256
  runtime          = "python3.8"
  depends_on       = [
    aws_iam_role_policy_attachment.lambda_log_policy,
    aws_cloudwatch_log_group.udacity_log_group,
  ]

  environment {
    variables = {
      greeting = "Udacity"
    }
  }
}
