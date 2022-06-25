resource "aws_instance" "web" {
    ami = "ami-0cff7528ff583bf9a"
    instance_type="t2.micro"
    key_name = "trail1"
    for_each = toset(["master", "slave", "ansible_host"])
    tags={
        Name="${each.key}"
    }
    
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"

  dynamic "ingress" {
        for_each = var.web_ingress
        content {
            description = "Ingress "
            from_port = ingress.value.port
            to_port = ingress.value.port
            protocol = ingress.value.protocol
            cidr_blocks = ingress.value.cidr_blocks
        }
    }
  
  
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}