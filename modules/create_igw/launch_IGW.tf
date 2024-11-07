resource "aws_internet_gateway" "gw" {
  vpc_id = var.vpcid

  tags = {
    Name = var.name
  }
}

data "aws_internet_gateway" "IGWinfo"{
    filter{
        name = "tag:Name"
        values = ["${var.name}"]
    }
    depends_on = [ aws_internet_gateway.gw ]
}

output returnigwinfo {
    value = data.aws_internet_gateway.IGWinfo.id
}

