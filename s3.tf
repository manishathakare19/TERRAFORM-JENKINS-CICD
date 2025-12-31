# Create S3 bucket
resource "aws_s3_bucket" "mybucket" {
  bucket        = var.bucketname
  force_destroy = true
}

# Enable website hosting
resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.mybucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

  depends_on = [
    aws_s3_bucket.mybucket
  ]
}

# Public read bucket policy
resource "aws_s3_bucket_policy" "public_read" {
  bucket = aws_s3_bucket.mybucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = "*"
        Action    = ["s3:GetObject"]
        Resource  = "${aws_s3_bucket.mybucket.arn}/*"
      }
    ]
  })

  depends_on = [
    aws_s3_bucket.mybucket,
    aws_s3_bucket_website_configuration.website
  ]
}

# Upload website files
resource "aws_s3_object" "index" {
  bucket       = aws_s3_bucket.mybucket.id
  key          = "index.html"
  source       = "index.html"
  content_type = "text/html"
  acl          = "public-read"

  depends_on = [
    aws_s3_bucket_policy.public_read
  ]
}

resource "aws_s3_object" "error" {
  bucket       = aws_s3_bucket.mybucket.id
  key          = "error.html"
  source       = "error.html"
  content_type = "text/html"
  acl          = "public-read"

  depends_on = [
    aws_s3_bucket_policy.public_read
  ]
}

resource "aws_s3_object" "style" {
  bucket       = aws_s3_bucket.mybucket.id
  key          = "style.css"
  source       = "style.css"
  content_type = "text/css"
  acl          = "public-read"

  depends_on = [
    aws_s3_bucket_policy.public_read
  ]
}

resource "aws_s3_object" "script" {
  bucket       = aws_s3_bucket.mybucket.id
  key          = "script.js"
  source       = "script.js"
  content_type = "text/javascript"
  acl          = "public-read"

  depends_on = [
    aws_s3_bucket_policy.public_read
  ]
}

