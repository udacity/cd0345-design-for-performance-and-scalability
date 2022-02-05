# Lambda Function
output "lambda_function_arn" {
  description = "The ARN of the Lambda Function"
  value       = try(aws_lambda_function.test_lambda.arn, "")
}

output "lambda_function_invoke_arn" {
  description = "The Invoke ARN of the Lambda Function"
  value       = try(aws_lambda_function.test_lambda.invoke_arn, "")
}

output "lambda_function_name" {
  description = "The name of the Lambda Function"
  value       = try(aws_lambda_function.test_lambda.function_name, "")
}

output "lambda_function_qualified_arn" {
  description = "The ARN identifying your Lambda Function Version"
  value       = try(aws_lambda_function.test_lambda.qualified_arn, "")
}

output "lambda_function_version" {
  description = "Latest published version of Lambda Function"
  value       = try(aws_lambda_function.test_lambda.version, "")
}

output "lambda_function_last_modified" {
  description = "The date Lambda Function resource was last modified"
  value       = try(aws_lambda_function.test_lambda.last_modified, "")
}

output "lambda_function_kms_key_arn" {
  description = "The ARN for the KMS encryption key of Lambda Function"
  value       = try(aws_lambda_function.test_lambda.kms_key_arn, "")
}

output "lambda_function_source_code_hash" {
  description = "Base64-encoded representation of raw SHA-256 sum of the zip file"
  value       = try(aws_lambda_function.test_lambda.source_code_hash, "")
}

output "lambda_function_source_code_size" {
  description = "The size in bytes of the function .zip file"
  value       = try(aws_lambda_function.test_lambda.source_code_size, "")
}


#
## IAM Role
#output "lambda_role_arn" {
#  description = "The ARN of the IAM role created for the Lambda Function"
#  value       = try(aws_iam_role.iam_for_lambda_tf_02.arn, "")
#}
#
#output "lambda_role_name" {
#  description = "The name of the IAM role created for the Lambda Function"
#  value       = try(aws_iam_role.iam_for_lambda_tf_02.name, "")
#}
#
#output "lambda_role_unique_id" {
#  description = "The unique id of the IAM role created for the Lambda Function"
#  value       = try(aws_iam_role.iam_for_lambda_tf_02.unique_id, "")
#}
#
#
