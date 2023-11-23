resource "aws_eip" "example" {
  instance = aws_instance.ec2_instance.id
}
