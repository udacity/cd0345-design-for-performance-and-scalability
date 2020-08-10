provider "aws" {
  access_key = "<access_key>"
  secret_key = "<secret_key>"
  region = var.aws_region
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

data "archive_file" "lambda_zip_file" {
  type = "zip"
  output_path = "lambda.zip"
  source {
    content = file("lambda.py")
    filename = "lambda.py"
  }
}

resource "aws_lambda_function" "greetings" {
  filename = data.archive_file.lambda_zip_file.output_path
  function_name = "seckinger_project2"
  role = aws_iam_role.iam_for_lambda.arn
  handler = "lambda.lambda_handler"

  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # source_code_hash = "${base64sha256(file("lambda_function_payload.zip"))}"
  source_code_hash = data.archive_file.lambda_zip_file.output_base64sha256

  runtime = "python3.8"
  depends_on = [aws_iam_role_policy_attachment.lambda_logs]
}

resource "aws_cloudwatch_log_group" "udacity_project2" {
  name              = "/aws/lambda/${aws_lambda_function.greetings.function_name}"
  retention_in_days = 14
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