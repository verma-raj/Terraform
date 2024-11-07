/*variable "vpcid" {
  type = string
}*/

variable "ami" {
  type = string
}

variable "subnetid" {
  type = list(string)
}

variable "instance_count" {
  type = number
}

variable "security_grp_id" {
  type = string
}

variable "associate_public_ip_address" {
  type = bool
}

variable "instance_type" {
  type = string
}

variable "name" {
  type = string
}


# variable "ec2_tag_name" {
#   type = string
# }
