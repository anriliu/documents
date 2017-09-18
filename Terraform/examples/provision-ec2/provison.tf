provider "aws" {
  access_key = ""
  secret_key = ""
  region     = "ap-southeast-1"
}
resource "aws_instance" "example" {
  ami           = "ami-8fcc75ec"
  instance_type = "t2.micro"
  subnet_id     = "subnet-dcac1eab"
  provisioner "local-exec" {
    command = "echo ${aws_instance.example.public_ip} > ip_address.txt"
  }
}
