resource "aws_s3_bucket" "bucket" {
  bucket = "${var.project_name}-${terraform.workspace}-${var.bucket_name}"
  
  tags = merge({ Environment = "${terraform.workspace}" }, var.common_tags)
}


# Resource to avoid error "AccessControlListNotSupported: The bucket does not allow ACLs"
resource "aws_s3_bucket_ownership_controls" "s3_bucket_acl_ownership" {
  bucket = aws_s3_bucket.bucket.id
  rule {
    object_ownership = "ObjectWriter"
  }
}

resource "aws_s3_bucket_acl" "bucket_acl" {
  bucket = aws_s3_bucket.bucket.id
  acl    = "private"

  depends_on = [aws_s3_bucket_ownership_controls.s3_bucket_acl_ownership]
}


resource "aws_s3_bucket_versioning" "bucket_versioning" {
  bucket = aws_s3_bucket.bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_object" "object" {
  bucket = aws_s3_bucket.bucket.id 
  key    = "data-sources/netflix-movies/netflix_titles.csv" 
  source = "./datasets/netflix_titles.csv"
  acl    = "private"
}

resource "aws_s3_object" "object1" {
  bucket = aws_s3_bucket.bucket.id 
  key    = "scripts/script.py" 
  source = "./scripts/script.py" 
  acl    = "private"
}

resource "aws_s3_object" "folder" {
  bucket = aws_s3_bucket.bucket.id 
  key    = "temp-dir/"
  acl    = "private"  
}