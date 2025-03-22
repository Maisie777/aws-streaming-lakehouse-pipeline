output "s3_bucket_name" {
  description = "Name of my Data Lake bucket"
  value       = aws_s3_bucket.data_lake_bucket.bucket
}

output "firehose_stream_name" {
  description = "Name of my Kinesis Firehose stream"
  value       = aws_kinesis_firehose_delivery_stream.demo_firehose.name
}
