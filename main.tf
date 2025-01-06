provider "aws" {
region = "ap-south-1"
}

resource "aws_instance" "ec2inst" {
ami = "ami-0fd05997b4dff7aac"
instance_type = "t3.medium"

tags = {
    Name = "miniKube-VM"
}
}
