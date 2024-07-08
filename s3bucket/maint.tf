resource "aws_s3_bucket" "todeploybucket" {
  bucket        = var.bucket_name
  force_destroy = var.force_destroy
}

/*
resource "aws_s3_bucket_policy" "" {
  bucket = var.bucket_name
  policy = data.
}

*/

