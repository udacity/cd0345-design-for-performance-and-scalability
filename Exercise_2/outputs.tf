# TODO: Define the output variable for the lambda function.
output "lambda_function_arn" {
  value = aws_lambda_function.greet_lambda.arn
}
