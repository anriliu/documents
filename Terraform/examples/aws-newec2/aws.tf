##create new ec2
provider "aws" {
  access_key = ""
  secret_key = ""
  region     = "ap-southeast-1"
}

resource "aws_instance" "example" {
  ami           = "ami-8fcc75ec"
  instance_type = "t2.micro"
  subnet_id     = "subnet-dcac1eab"
}


#resource "aws_eip" "ip" {
#  instance = "${aws_instance.example.id}"
#   depends_on = ["aws_instance.example"]
#}
