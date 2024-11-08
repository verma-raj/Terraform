module "aws-vpc" {
  source           = ".\\modules\\create_vpc"
  cidr_block       = var.vpc_CIDR_BLOCK
  instance_tenancy = var.INSTANCE_TENANCY
}

module "aws-subnet" {
  source        = ".\\modules\\create_subnets"
  vpcid         = module.aws-vpc.returnvpcid
  count         = length(var.subnet_AZS)
  sub_cidrblock = element(var.subnet_CIDR_BLOCK, count.index)
  sub_azs       = element(var.subnet_AZS, count.index)
  sub_tag_name  = "pubsubnet-${count.index + 1}"

  depends_on = [
    module.aws-vpc
  ]
}

module "aws-routetable" {
  source   = ".\\modules\\create_routetable"
  vpcid    = module.aws-vpc.returnvpcid
  subnetid = module.aws-subnet[*].returnsubnetid
  igw_id   = module.IGW.returnigwinfo

  depends_on = [
    module.aws-subnet
  ]
}

module "IGW" {
  source = ".\\modules\\create_igw"
  vpcid  = module.aws-vpc.returnvpcid
  name   = "test_IGW"

  depends_on = [
    module.aws-vpc
  ]
}

module "security_grp" {
  source = ".\\modules\\create_SG"
  vpcid  = module.aws-vpc.returnvpcid

}

module "aws_ec2_instance" {
  source                      = ".\\modules\\create_ec2"
  ami                         = var.AMI
  subnetid                    = module.aws-subnet[*].returnsubnetid
  security_grp_id             = module.security_grp.security_grp_info
  associate_public_ip_address = true
  instance_type               = var.INSTANCE_TYPE
  name                        = var.INSTANCE_NAME
  # instance_count = var.INSTANCE_COUNT
  # count = var.INSTANCE_COUNT
  # ec2_tag_name = "VM-${count.index+1}"
  instance_count = 2

  depends_on = [
    module.security_grp
  ]

}


module "loadbalancer" {
  source = ".\\modules\\create_ELB"
  vpcid = module.aws-vpc.returnvpcid
  security_grp_id = module.security_grp.security_grp_info
  subnetid = module.aws-subnet[*].returnsubnetid
  instance_id = flatten(module.aws_ec2_instance[*].returnec2id)
  instance_count = var.INSTANCE_COUNT

}


output "security_ID" {
  value = module.security_grp.security_grp_info
}

output "subnet_ID" {
  value = module.aws-subnet[*].returnsubnetid
}

output "ec2_ID" {
  # value = module.aws_ec2_instance[*].returnec2id
  value = module.aws_ec2_instance.returnec2id
}


output "ec2_az" {
  value = module.aws_ec2_instance.returnec2az
}


output "ec2_privIP" {
  value = module.aws_ec2_instance.returnec2privIP
}


