# Récupération automatique de la dernière image Ubuntu 22.04 LTS
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Clé SSH (la paire de clés sera générée en local ou devra être fournie)
resource "tls_private_key" "devops_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "devops_key_pair" {
  key_name   = "devops_ssh_key"
  public_key = tls_private_key.devops_key.public_key_openssh
}

# Sauvegarde de la clé privée localement pour qu'Ansible puisse l'utiliser
resource "local_file" "private_key" {
  content         = tls_private_key.devops_key.private_key_pem
  filename        = "${path.module}/devops_key.pem"
  file_permission = "0400"
}

# Node Master K3s
resource "aws_instance" "master_node" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name      = aws_key_pair.devops_key_pair.key_name
  subnet_id     = aws_subnet.devops_subnet_public.id
  vpc_security_group_ids = [aws_security_group.devops_sg.id]

  # Allocation de 20 Go (par défaut sur Ubuntu c'est souvent 8Go, et K8s est gourmand en disque)
  root_block_device {
    volume_size = 20
    volume_type = "gp2"
  }

  tags = {
    Name = "DevOps_Master_Node"
    Role = "master"
  }
}

# Node Worker K3s
resource "aws_instance" "worker_node" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name      = aws_key_pair.devops_key_pair.key_name
  subnet_id     = aws_subnet.devops_subnet_public.id
  vpc_security_group_ids = [aws_security_group.devops_sg.id]

  root_block_device {
    volume_size = 20
    volume_type = "gp2"
  }

  tags = {
    Name = "DevOps_Worker_Node"
    Role = "worker"
  }
}
