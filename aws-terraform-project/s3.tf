# 1. S3 Bucket for Terraform State
resource "aws_s3_bucket" "terraform_state" {
  bucket        = "muneer-devops-tfstate-0157" # Yeh naam globally unique hona chahiye
  force_destroy = true

  tags = {
    Name        = "Terraform State Bucket"
    Environment = "Production"
  }
}

# 2. Enable Versioning on S3 Bucket (Taake purani state files ka backup rahe)
resource "aws_s3_bucket_versioning" "enabled" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}
