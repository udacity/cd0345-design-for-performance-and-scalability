data "aws_lambda_invocation" "example" {
  function_name = aws_lambda_function.lambda.function_name
  input = <<JSON
{
  "irrelevant": "sample",
  "input": "values"
}
JSON
}

output "Lambda-Execution-Result" {
  description = "String result of Lambda execution"
  value       = data.aws_lambda_invocation.example.result
}