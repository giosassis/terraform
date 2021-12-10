//Security Group
resource "aws_security_group" "allow_tls_ssh" {
  name        = "allow_tls_ssh"
  description = "Allow TLS inbound traffic"

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.remote_access
  }

  tags = {
    Name = "allow_tls"
  }
}

//Security Group EAST-2
resource "aws_security_group" "allow_tls_ssh_east2" {
  provider    = aws.us-east-2
  name        = "allow_tls_ssh_east2"
  description = "Allow TLS inbound traffic"

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.remote_access
  }

  tags = {
    Name = "allow_tls"
  }
}
