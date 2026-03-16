resource "aws_security_group" "devops_sg" {
  name        = "devops_security_group"
  description = "Autorise trafic SSH, HTTP/HTTPS et Kubernetes"
  vpc_id      = aws_vpc.devops_vpc.id

  # Accès SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Accès HTTP (Application Flask exposée)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Accès Kubernetes API (Master node)
  ingress {
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Open NodePort range for standard K8s services (30000-32767)
  ingress {
    from_port   = 30000
    to_port     = 32767
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Trafic interne entre les nœuds (tous ports en UDP/TCP pour K3s : Flannel, etc.)
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
  }

  # Accès à internet pour sortir
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "DevOps_SG"
  }
}
