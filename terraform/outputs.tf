output "master_public_ip" {
  description = "IP publique du Master Node"
  value       = aws_instance.master_node.public_ip
}

output "worker_public_ip" {
  description = "IP publique du Worker Node"
  value       = aws_instance.worker_node.public_ip
}

output "ssh_command" {
  value = "Pour vous connecter au master : ssh -i devops_key.pem ubuntu@${aws_instance.master_node.public_ip}"
}
