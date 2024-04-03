provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "auditoria_dev_security_group" {
  name        = "auditoria_dev_security_group"
  description = "Security group for EC2 instance (ms-auditoria-dev)"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "AUDITORIA_dev_instance" {
  ami           = "ami-0c101f26f147fa7fd" 
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.auditoria_dev_security_group.id]
  key_name      = "key-auditoria-dev"
  tags = {
    Name = "MS-AUDITORIA-DEV"
  }
}

output "public_ip_dev" {
  value = aws_instance.AUDITORIA_dev_instance.public_ip
}