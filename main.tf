provider "aws" {
region = "ap-south-1"
}

resource "aws_instance" "ec2inst" {
ami = "ami-0614680123427b75e"
instance_type = "t2.micro"

tags = {
    Name = "Ec2_Instance"
}
}
