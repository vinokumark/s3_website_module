resource "aws_s3_bucket" "static_website" {
    bucket = var.s3_static
}

resource "aws_s3_bucket_acl" "static_website_acl" {
    bucket = aws_s3_bucket.static_website.id
    acl = var.s3_static_acl
}

resource "aws_s3_bucket_website_configuration" "static_website_file" {
    bucket = aws_s3_bucket.static_website.bucket
    index_document {
      suffix = "index.html"
    }

    error_document {
      key= "error.html"
    }
    
}

resource "aws_s3_bucket_cors_configuration" "example" {
  bucket = aws_s3_bucket.static_website.id

  cors_rule {
    allowed_methods = ["GET"]
    allowed_origins = ["*"]
  }
}

resource "aws_s3_bucket_policy" "permission" {
  bucket = aws_s3_bucket.static_website.id
  policy = data.aws_iam_policy_document.policyfors3public.json
}

data "aws_iam_policy_document" "policyfors3public" {

    statement {
            sid = "PublicReadGetObject"
            effect = "Allow"
 
            actions= [
                "s3:GetObject"
            ]

            principals {
              type = "*"
              identifiers = ["*"]
            }
            resources = [
                aws_s3_bucket.static_website.arn,
                "${aws_s3_bucket.static_website.arn}/*",
            ]
        }
}

