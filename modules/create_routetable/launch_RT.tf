resource "aws_route_table" "testRT"{
    vpc_id = var.vpcid
    route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
  }
    tags = {
      Name = "pubRT"
   }
}

output route_table_id {
    value = aws_route_table.testRT.id
}


resource "aws_route_table_association" "route_association" {
    count = "${length(var.subnetid )}"
   subnet_id      = "${element(var.subnetid, count.index)}"
   route_table_id = aws_route_table.testRT.id
}



