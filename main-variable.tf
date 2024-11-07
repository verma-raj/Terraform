variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {}

variable "vpc_CIDR_BLOCK" {  // VPC CIDR
  type    = string
  default = "10.0.0.0/16"
}

variable "subnet_CIDR_BLOCK" {  // Subnet CIDR
  type    = list
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "subnet_AZS"{
  type = list
  default = ["us-east-1a", "us-east-1b"]
}

# variable "instance_type"{    // EC2  instance type
#   type = string
#   default = "t2.micro"
# }

variable "INSTANCE_TENANCY" {
  default = "default"
}

variable "AMI" {
  default = "default"
}

variable "INSTANCE_TYPE" {  
  description = "EC2 instance type "
  type = string
  default = "t2.micro"
}

variable "INSTANCE_COUNT" {
  type = number
  default = "2"
}

variable "INSTANCE_NAME" {
  type = string
  default = "VM"
}



