resource "aws_vpc" "testvpc" {
  cidr_block       = "${var.cidr_block}"
  instance_tenancy = "${var.instance_tenancy}"
  tags = {
    Name = "test-vpc"
  }
}

output "returnvpcid" {
    value = aws_vpc.testvpc.id
}



