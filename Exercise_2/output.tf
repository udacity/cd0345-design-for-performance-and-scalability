# TODO: Define the output variable for the lambda function.
locals {
  lambda_zip_location = "outputs/lambda-demo.zip"
}

data "archive_file" "lambda-demo" {
  type        = "zip"
  source_file = "lambda.py"
  output_path = local.lambda_zip_location
}

resource "aws_lambda_function" "terraform_lambda_function" {
  filename      = local.lambda_zip_location
  function_name = "lambda"
  role          = aws_iam_role.lambda_role.arn
  handler       = "lambda.hello"

  # source_code_hash = filebase64sha256(local.lambda_zip_location)

  runtime = "python3.8"

}
