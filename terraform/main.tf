resource "aws_instance" "webserver" {
  ami           = var.debian-ami
  instance_type = var.instance_type

  tags = {
    Name        = "webserver"
    Description = "An Node Exporter server"
  }

  key_name               = aws_key_pair.aws_ec2_key.id
  vpc_security_group_ids = [aws_security_group.ssh_grafana_access.id]
}

resource "aws_security_group" "ssh_grafana_access" {
  name        = "ssh-grafana-access"
  description = "Allow SSH (22) and Grafana (3000)"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Grafana"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "certbot"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ssh-grafana-access"
  }
}


resource "aws_key_pair" "aws_ec2_key" {
  public_key = file(var.ec2_ssh_pubkey_path)
  key_name   = "aws_ec2"
}


resource "local_file" "ansible_inventory" {
  content  = <<EOF
[webserver]
ec2_instance ansible_host=${aws_instance.webserver.public_ip}

[webserver:vars]
ansible_user=admin
ansible_private_key_file=${var.ec2_ssh_private_path}
EOF
  filename = "../${path.module}/ansible/inventory"
}

resource "null_resource" "run_ansible" {

  depends_on = [
    aws_instance.webserver,
    local_file.ansible_inventory
  ]

  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    working_dir = "../ansible"
    command     = <<EOT
      sleep 30
      ansible-playbook -i inventory playbook.yaml
    EOT
  }
}


output "ansible_inventory" {

  depends_on = [
    null_resource.run_ansible
  ]
  value = <<EOF
TO ACCESS THE GRAFANA DASHBOARD, CLICK ON THE LINK BELOW

https://${aws_instance.webserver.public_ip}:3000/
EOF
}
