
output "dlm_lifecycle_role_arn" {
  value       = join("", aws_iam_role.dlm_lifecycle_role.*.arn)
  description = "Amazon Resource Name (ARN) of the DLM Lifecycle Policy."
}

