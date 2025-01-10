provider "aws" {
region = "ap-south-1"
}

resource "aws_instance" "miniKube_VM" {
ami = "ami-0fd05997b4dff7aac"
instance_type = "t3.medium"
key_name = "miniKube"
vpc_security_group_ids = [aws_security_group.miniKubeSG.id]

tags = {
    Name = "miniKube-VM"
}

user_data = file("DesiredConfig.sh")
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
  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22

}

resource "aws_vpc_security_group_egress_rule" "miniKube_egress" {
   security_group_id = aws_security_group.miniKubeSG.id
   cidr_ipv4   = "0.0.0.0/0"
   ip_protocol = "-1"
}
