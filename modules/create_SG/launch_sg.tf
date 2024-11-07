locals {
  ingress_rules = [{
       port             = 22
       protocol         = "tcp"
       description      = "For SSH"
       cidr_blocks = ["0.0.0.0/0"]
  },
  {
       port             = 3000
       protocol         = "tcp"
       description = "For HTTP"
       cidr_blocks = ["0.0.0.0/0"]
  }
  
  ]
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = var.vpcid

  dynamic "ingress"{
   for_each = local.ingress_rules
   content {
      description      = ingress.value.description
      from_port        = ingress.value.port
      to_port          = ingress.value.port
      protocol         = ingress.value.protocol
      cidr_blocks      = ingress.value.cidr_blocks
      //ipv6_cidr_blocks = ingress.value.ipv6_cidr_blocks
    }
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    //ipv4_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}

output "security_grp_info"{
    value = aws_security_group.allow_tls.id
}

