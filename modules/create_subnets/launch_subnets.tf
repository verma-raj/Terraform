resource "aws_subnet" "test_subnet" {
   vpc_id = "${var.vpcid}"
   cidr_block = "${var.sub_cidrblock}"
   availability_zone = "${var.sub_azs}"
   map_public_ip_on_launch = true
   tags = {
      Name = "${var.sub_tag_name}"
   }
}

/*output "subnetlist" {
  value = aws_subnet.test_subnet[*].id
}*/

data "aws_subnet" "subnetinfo"{
    filter{
        name = "tag:Name"
        values = ["${var.sub_tag_name}"]
    }
    depends_on = [ aws_subnet.test_subnet ]
}

output "returnsubnetazs" {
    value = data.aws_subnet.subnetinfo.availability_zone
}

output "returnsubnetid" {
    value = data.aws_subnet.subnetinfo.id
}
