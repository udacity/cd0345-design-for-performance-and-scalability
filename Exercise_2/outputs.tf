# Invoking the Lambda function. Our function doesn't require any input however.
data "aws_lambda_invocation" "test" {
  function_name = aws_lambda_function.lambda.function_name
  input = <<JSON
{
  "irrelevant": "sample",
  "input": "values"
}
JSON
}

# Collecting the output inside a variable which will be printed out during Terraform Apply phase.
output "Lambda-Execution-Result" {
  description = "Greeting output"
  value       = data.aws_lambda_invocation.test.result
}