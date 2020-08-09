data "aws_caller_identity" "self" {}

resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
  acl    = "private"
  policy = <<EOF
{
  "Version":"2012-10-17",
  "Statement":[
    {
      "Sid":"DeployAccess",
      "Effect":"Allow",
      "Principal": {"AWS":"${data.aws_caller_identity.self.arn}"},
      "Action":[
          "s3:ListBucket",
          "s3:GetObject",
          "s3:GetObjectAcl",
          "s3:PutObject",
          "s3:PutObjectAcl",
          "s3:ReplicateObject",
          "s3:DeleteObject"
          ],
      "Resource":[
          "arn:aws:s3:::${var.bucket_name}",
          "arn:aws:s3:::${var.bucket_name}/*"
          ]
    },
    {
      "Sid":"DomesticRead",
      "Effect":"Allow",
      "Principal": {"AWS":"${aws_iam_role.this.arn}"},
      "Action":[
          "s3:ListBucket",
          "s3:GetObject",
          "s3:GetObjectAcl"
          ],
      "Resource":[
          "arn:aws:s3:::${var.bucket_name}",
          "arn:aws:s3:::${var.bucket_name}/*"
          ]
    }
  ]
}
EOF

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = var.tags
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_object" "env" {
  bucket     = var.bucket_name
  key        = "dotfiles/.env"
  source     = "./assets/dotfiles/.env"
  etag       = filemd5("./assets/dotfiles/.env")
  depends_on = [aws_s3_bucket.this]
}
