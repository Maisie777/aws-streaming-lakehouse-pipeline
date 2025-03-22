variable "region" {
  description = "AWS region"
  default     = "eu-central-1"
}

variable "bucket_name" {
  description = "Globally unique S3 bucket name"
  default     = "streaming-lakehouse-demo-maisie"
}

variable "glue_role_name" {
  description = "IAM Role name for AWS Glue ETL jobs"
  default     = "glue_etl_role_demo"
}

variable "firehose_role_name" {
  description = "IAM Role name for Kinesis Firehose"
  default     = "firehose_delivery_role_demo"
}

variable "firehose_stream_name" {
  description = "Name of Kinesis Firehose delivery stream"
  default     = "streaming-demo-firehose"
}