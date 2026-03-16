# Création du VPC
resource "aws_vpc" "devops_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "DevOps_VPC"
  }
}

# Création de l'Internet Gateway pour l'accès public
resource "aws_internet_gateway" "devops_igw" {
  vpc_id = aws_vpc.devops_vpc.id

  tags = {
    Name = "DevOps_IGW"
  }
}

# Création d'un sous-réseau public
resource "aws_subnet" "devops_subnet_public" {
  vpc_id                  = aws_vpc.devops_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true # Assigne une IP publique aux instances

  tags = {
    Name = "DevOps_Public_Subnet"
  }
}

# Table de routage pour l'accès vers l'extérieur
resource "aws_route_table" "devops_rt" {
  vpc_id = aws_vpc.devops_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.devops_igw.id
  }

  tags = {
    Name = "DevOps_RouteTable"
  }
}

# Association de la table de routage au sous-réseau
resource "aws_route_table_association" "devops_rta" {
  subnet_id      = aws_subnet.devops_subnet_public.id
  route_table_id = aws_route_table.devops_rt.id
}
