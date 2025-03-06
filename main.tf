# Specify the AWS provider and region
provider "aws" {
  region = "eu-west-1"  # Change this to your preferred AWS region
}

# Create a Security Group
resource "aws_security_group" "web_sg" {
  name        = "web_sg"
  description = "Allow inbound traffic for SSH and HTTP"

  # Allow SSH access (port 22)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow HTTP access (port 80)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create an AWS EC2 Instance
resource "aws_instance" "web_server" {
  ami                    = "ami-0a89fa9a6d8c7ad98"  # Amazon Linux 2 AMI (Change based on your region)
  instance_type          = "t2.micro"
  key_name               = "tfkey"  # Replace with your SSH key name
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  tags = {
    Name = "Terraform-Web-Server"
  }
}