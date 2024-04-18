terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "us-east-1"
  profile = "MPerez"
}

// Primer grupo de seguridad
resource "aws_security_group" "instance_security_group_1" {
  name        = "instance_security_group_1"
  description = "Security group for EC2 instance 1"

   // Reglas de entrada para el grupo de seguridad 1
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

  ingress {
    from_port   = 8 // Permitir ping (ICMP) desde cualquier origen
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // Reglas de salida para el grupo de seguridad 1
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] // Permitir todas las conexiones salientes
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

// Segundo grupo de seguridad
resource "aws_security_group" "instance_security_group_2" {
  name        = "instance_security_group_2"
  description = "Security group for EC2 instance 2"

   // Reglas de entrada para el grupo de seguridad 2
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

  ingress {
    from_port   = 8 // Permitir ping (ICMP) desde cualquier origen
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // Reglas de salida para el grupo de seguridad 2
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] // Permitir todas las conexiones salientes
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

// Primera instancia
resource "aws_instance" "ORG_COBRANZAS_DEV_instance" {
  ami           = "ami-051f8a213df8bc089"
  instance_type = "t2.micro"
  key_name      = "PEM_ORG_COBRANZAS_DEV"

  vpc_security_group_ids = [aws_security_group.instance_security_group_1.id]

  associate_public_ip_address = true

  tags = {
    Name = "ORG-COBRANZAS-DEV"
  }
}

// Segunda instancia
resource "aws_instance" "VENTAS_DEV_instance" {
  ami           = "ami-051f8a213df8bc089"  // Cambia el ID de la AMI según tus necesidades
  instance_type = "t2.micro"
  key_name      = "PEM_VENTAS_DEV"

  vpc_security_group_ids = [aws_security_group.instance_security_group_2.id]

  associate_public_ip_address = true

  tags = {
    Name = "ORG-VENTAS-DEV"
  }
}

output "public_ip_dev_1" {
  value = aws_instance.ORG_COBRANZAS_DEV_instance.public_ip
}

output "public_ip_dev_2" {
  value = aws_instance.VENTAS_DEV_instance.public_ip
}
