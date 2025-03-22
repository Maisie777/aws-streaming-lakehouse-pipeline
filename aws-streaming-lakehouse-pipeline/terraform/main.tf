# Terraform AWS provider
provider "aws" {
  region = var.region
}

# Create an S3 bucket for your Data Lake
resource "aws_s3_bucket" "data_lake_bucket" {
  bucket = var.bucket_name

  tags = {
    Name        = "Streaming-Lakehouse-Demo"
    Environment = "Demo"
  }
}

# IAM role allowing Kinesis Firehose to access AWS services (like S3)
resource "aws_iam_role" "firehose_role" {
  name = var.firehose_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = { Service = "firehose.amazonaws.com" },
      Action = "sts:AssumeRole"
    }]
  })
}

# Attach a policy giving Firehose access to S3
resource "aws_iam_role_policy_attachment" "firehose_policy_attachment" {
  role       = var.firehose_role_name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

# Kinesis Data Firehose delivery stream to send data into S3
resource "aws_kinesis_firehose_delivery_stream" "demo_firehose" {
  name        = var.firehose_stream_name
  destination = "extended_s3"

  extended_s3_configuration {
    bucket_arn          = aws_s3_bucket.data_lake_bucket.arn
    role_arn            = aws_iam_role.firehose_role.arn
    buffering_size      = 1    # 5 MB
    buffering_interval  = 60  # 5 minutes
    compression_format  = "UNCOMPRESSED"
  }

  # IAM Role for AWS Glue
  resource "aws_iam_role" "glue_role" {
    name = var.glue_role_name

    assume_role_policy = jsonencode({
      Version = "2012-10-17",
      Statement = [{
        Effect = "Allow",
        Principal = { Service = "glue.amazonaws.com" },
        Action = "sts:AssumeRole"
      }]
    })
  }

  # Attach AWSGlueServiceRole (managed policy)
  resource "aws_iam_role_policy_attachment" "glue_service_policy" {
    role       = var.glue_role_name
    policy_arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
  }

  # Add S3 access to Glue Role
  resource "aws_iam_role_policy_attachment" "glue_s3_policy" {
    role       = var.glue_role_name
    policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  }

}
