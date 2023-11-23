resource "aws_instance" "ec2_instance" {
  ami           = "ami-0c42696027a8ede58" # Amazon Linux 2 AMI ID
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnet.id
  key_name      = "tf_ec2_vpc" # Update with the key pair name

  vpc_security_group_ids = [aws_security_group.instance_sg.id]

  tags = {
    Name = "TerraformEC2Instance"
  }
  user_data = filebase64("${path.module}/userdata.sh")
}
