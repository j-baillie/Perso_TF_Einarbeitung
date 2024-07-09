output "ec2_assume_role" {
  value = data.aws_iam_policy_document.ec2_assume_role
}

output "s3_read_acess" {
  value = data.aws_iam_policy_document.s3_read_access
}

