# Output the private key content from the S3 object
output "private_key_content" {
  value = data.aws_s3_bucket_object.key_pair_object.body
}
