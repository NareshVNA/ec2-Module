provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "miniKube_VM" {
  ami                    = "ami-0fd05997b4dff7aac"
  instance_type          = "t3.medium"
  key_name               = "miniKubeKey"
  vpc_security_group_ids = [aws_security_group.miniKubeSG.id]

  tags = {
    Name = "miniKube-VM"
  }

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    private_key = file(var.miniKubeKey)
    agent       = false
  }

  provisioner "remote-exec" {
      inline = [
        "echo _________creting_the_folder________",
        "mkdir remoteFiles",
      ]
  }
  provisioner "file" {
    source      = "ConfigScripts"
    destination = "remoteFiles"
  }
  provisioner "file" {
    source      = "CDconfig.sh"
    destination = "CDconfig.sh"
  }

}

resource "aws_security_group" "miniKubeSG" {
  name        = "miniKubeSG"
  description = "Allow TLS inbound traffic and all outbound traffic"

  tags = {
    Name = "MiniKubeSG"
  }
}
resource "aws_vpc_security_group_ingress_rule" "miniKube_ingress" {
  security_group_id = aws_security_group.miniKubeSG.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22

}

resource "aws_vpc_security_group_egress_rule" "miniKube_egress" {
  security_group_id = aws_security_group.miniKubeSG.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
