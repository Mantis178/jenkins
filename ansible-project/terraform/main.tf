provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "flask_app" {
  ami           = "ami-0c55b159cbfafe1f0" # Example AMI for Ubuntu
  instance_type = "t2.micro"
  key_name      = var.key_name

  tags = {
    Name = "FlaskApp"
  }

  # Output the public IP of the instance
  provisioner "local-exec" {
    command = "echo ${self.public_ip} > public_ip.txt"
  }
}

output "ec2_public_ip" {
  value = aws_instance.flask_app.public_ip
}
