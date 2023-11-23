# Data source to retrieve the key pair from S3
data "aws_s3_bucket_object" "key_pair_object" {
  bucket = "test-terraform-tf-state" # Replace with your S3 bucket name
  key    = "tf_ec2_vpc.pem"          # Replace with the key name in the S3 bucket
}
