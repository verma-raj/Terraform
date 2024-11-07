
variable "vpcid" {
  type = string
}

variable "security_grp_id" {
  type = string
}

variable "subnetid" {
  type = list(string)
}

variable "instance_id" {
  type = list(string)
}

variable "instance_count" {
  type = number
}