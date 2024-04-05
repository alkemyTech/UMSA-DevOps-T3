
provider "aws" {
  region = "us-east-1" 
}

# Crear un nuevo grupo de seguridad
resource "aws_security_group" "instance_security_group" {
  name        = "instance_security_group"
  description = "Security group for EC2 instance"

  # Reglas de ingreso
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

  # Reglas de egreso
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


#instancia EC2
resource "aws_instance" "PAGOS_dev_instance" {
  ami           = "ami-0a3c3a20c09d6f377"  # AMI de Amazon Linux
  instance_type = "t2.micro"               # Tipo de instancia
   key_name      = "PEM_ORG_PAGOS_DEV"    

  #Asociar la instancia con el grupo de seguridad 
  vpc_security_group_ids = [aws_security_group.instance_security_group.id]

  #Tag identificar instancia
  tags = {
    Name = "ORG-PAGOS-DEV"  
  }
}

output "public_ip_dev" {
  value = aws_instance.PAGOS_dev_instance.public_ip
}


