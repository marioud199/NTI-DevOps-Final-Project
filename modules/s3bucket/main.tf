provider "aws" {
  region = "eu-west-1"  
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name 

  tags = {
    Name = var.bucket_name
  }
}

resource "aws_s3_bucket_ownership_controls" "control_bucket" {
  bucket = aws_s3_bucket.my_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "bucket_acl" {
  depends_on = [aws_s3_bucket_ownership_controls.control_bucket]

  bucket = aws_s3_bucket.my_bucket.id
  acl    = "private"
}
resource "aws_s3_bucket_policy" "example_bucket_policy" {
  bucket = aws_s3_bucket.my_bucket.id

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "arn:aws:iam::156460612806:root"
        },
        "Action" : "s3:PutObject",
        "Resource" : "arn:aws:s3:::marioud-bucket/AWSLogs/${var.aws_account_id}/*"
    }
]
})
}

