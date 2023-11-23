resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.example.id
  cidr_block              = "10.0.0.0/24" # Replace with your desired subnet CIDR
  availability_zone       = "ap-south-1a" # Replace with your desired AZ
  map_public_ip_on_launch = true

  tags = {
    Name = "Public Subnet"
  }
}

# Create a route table for public subnet(s)
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.example.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.example.id
  }
}

# Associate the public route table with the public subnet(s)
resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}
