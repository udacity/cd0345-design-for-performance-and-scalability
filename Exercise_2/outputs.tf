# TODO: Define the output variable for the lambda function.
output "lambda_output" {
  description = "Output for the lambda function"
  value       = aws_lambda_function.lambda_udacity_project
}