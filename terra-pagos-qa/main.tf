# Configuración del proveedor AWS
provider "aws" {
  region = "us-east-1"  # Cambia esto a la región deseada
}

# Crear un nuevo grupo de seguridad
resource "aws_security_group" "instance_security_group" {
  name        = "instance_security_group_qa"
  description = "Security group for EC2 instance"

  # Ingresos y egresos para los puertos 22, 443 y 3000
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

# Definición de la instancia EC2
resource "aws_instance" "PAGOS_QA_instance" {
  ami           = "ami-0a3c3a20c09d6f377"  # AMI de Amazon Linux
  instance_type = "t2.micro"               # Tipo de instancia
  key_name      = "PEM_ORG_PAGOS_DEV"      # Nombre de tu key pair existente en AWS

  # Asociar la instancia con el grupo de seguridad recién creado
  vpc_security_group_ids = [aws_security_group.instance_security_group.id]

  # Tag para identificar la instancia
  tags = {
    Name = "ORG-PAGOS-QA"  # Reemplazar por el nombre correcto
  }
}

# Salida para mostrar la IP pública de la instancia EC2 después del despliegue
output "public_ip_QA" {
  value = aws_instance.PAGOS_QA_instance.public_ip
}
