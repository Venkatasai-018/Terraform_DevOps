# key-pair

resource "aws_key_pair" "my_key" {
    
    key_name = "mykey"
    public_key = file("mykey.pub")

}

#VPC& security

resource "aws_default_vpc" "default" {
  
}

resource "aws_security_group" "my_security_group" {
    
    
      name="automate_sg"
      description = "Automation Security Group"
      vpc_id = aws_default_vpc.default.id # interpolation reference to above 
      ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "SSH Open"
      }
      
      ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "HTTP Open"

      }
      ingress {
        from_port = 8000
        to_port = 8000
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Notes APP"
        

      }

      egress{
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
         description = "all access"
      }


    tags = {
     Name = "allow_tls"
    }
}


resource "aws_instance" "instance1" {
  for_each = tomap({
        Dev="t2.micro"
        Qa="t2.micro"
    })
  key_name=aws_key_pair.my_key.key_name
  security_groups = [aws_security_group.my_security_group.name]
  instance_type = each.value
  ami=var.ec2_ami_id
  
  user_data = file("ngnix.sh")
  root_block_device {
    volume_size = var.ec2_root_storage_size
    volume_type = var.ec2_root_volume_type
  }
  tags = {
    Name=each.key

  }
}




