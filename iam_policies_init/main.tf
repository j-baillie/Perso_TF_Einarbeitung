data aws_iam_policy_document "ec2_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

data aws_iam_policy_document "s3_read_access" {
  statement {
    actions   = ["s3:Get*", "s3:List*"]
    resources = ["arn:aws:s3:::*"]
  }
  #using these data resources, we are able to GENERATE policy config documents with the actions/permissions on the resources we define
}

