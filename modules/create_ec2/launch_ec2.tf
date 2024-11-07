
resource "aws_instance" "ec2" {
  ami = var.ami
  instance_type = var.instance_type
  associate_public_ip_address = var.associate_public_ip_address
  # count = "${length(var.subnetid)}"
  # count = 2
  count = var.instance_count
  subnet_id = "${element(var.subnetid, count.index)}"
  security_groups = var.security_grp_id[*]
  key_name = "demo-key"
    tags = {
    Name = "${var.name}-${count.index+1}"
  
  }
}

resource "aws_key_pair" "key-pair" {
  key_name   = "demo-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDdYKRahevyqwNtoXtPLgFluarsV2rXir+03+EOrOinarzETiz1aUk2vXAoa7mQFlPfn//Wqkm13c2k/Bmzg9wNmMXEaB6m5UhuQi5xqedPcOHEuwhrqdOreDz+XBXR6cH/3w8z3Ttsx9cBmIDl6146EGuqy6nTcYFkP8GXnpWApoL7Hd70+l/mmK0/bQoOGfHxs6mlCIZiFil3T3Zpx8xvLhI6lDhAcqYECYHTXpKtGR1zFvoXh7zro/85fU5qoyQzQ9enaNcLij9DJAi9RD+3fYT/dvP8CsUWwHrj9JOwge+Ix2RPm59OGUcwVSPUNM1d1iJpiBK1P5N//p0BeluT rajiv verma@DESKTOP-IHSAFHU"
}


data "aws_instance" "instanceinfo"{
    count = "${var.instance_count}"
    filter {
        name = "tag:Name"
        values = ["${var.name}-${count.index+1}"]

    }

    depends_on = [ aws_instance.ec2 ]
}

output "returninstanceid" {
    value = data.aws_instance.instanceinfo[*].id
}



