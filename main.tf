provider "aws" {
  region  = "us-east-1"
}

provider "aws" {
  alias = "us-east-2"
  region  = "us-east-2"
}

resource "aws_instance" "dev" {
  count         = 3
  ami           = "ami-0b0af3577fe5e3532"
  instance_type = "t2.micro"
  key_name      = var.key_name
  tags = {
    Name = "dev${count.index}"
  }

  vpc_security_group_ids = ["${aws_security_group.allow_tls_ssh.id}"]
}

resource "aws_instance" "dev4" {
  ami           = var.amis["us-east-1"]
  instance_type = "t2.micro"
  key_name      = var.key_name
  tags = {
    Name = "dev4"
  }

  vpc_security_group_ids = ["${aws_security_group.allow_tls_ssh.id}"] 
  depends_on             = [aws_s3_bucket.dev4]
}

resource "aws_instance" "dev5" {
  ami           = "ami-0b0af3577fe5e3532"
  instance_type = "t2.micro"
  key_name      = var.key_name
  tags = {
    Name = "dev5"
  }

  vpc_security_group_ids = ["${aws_security_group.allow_tls_ssh.id}"] 
}

//Instance EAST-2
resource "aws_instance" "dev6" {
  provider = "aws.us-east-2"
  ami           = var.amis["us-east-2"]
  instance_type = "t2.micro"
  key_name      = var.key_name
  tags = {
    Name = "dev6"
  }

  vpc_security_group_ids = ["${aws_security_group.allow_tls_ssh_east2.id}"] 
  depends_on = ["aws_dynamodb_table.dynamodb-homologacao"]

}

resource "aws_instance" "dev7" {
  provider = "aws.us-east-2"
  ami           = var.amis["us-east-2"]
  instance_type = "t2.micro"
  key_name      = var.key_name
  tags = {
    Name = "dev7"
  }

  vpc_security_group_ids = ["${aws_security_group.allow_tls_ssh_east2.id}"] 

}

//Creating s3bucket 
resource "aws_s3_bucket" "dev4" {
  bucket = "terraformlabs-dev4"
  acl    = "private"

  tags = {
    Name = "terraformlabs-dev4"
  }
}

//Database 
resource "aws_dynamodb_table" "dynamodb-homologacao" {
  provider    = "aws.us-east-2"
  name           = "GameScores"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "UserId"
  range_key      = "GameTitle"

  attribute {
    name = "UserId"
    type = "S"
  }

  attribute {
    name = "GameTitle"
    type = "S"
  }
}
