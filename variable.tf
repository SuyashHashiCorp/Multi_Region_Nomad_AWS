##AWS instance Key Pair File
variable "key_pair" {
  default = ""
}

variable "key_path" {
  default = ""
}

#EC2
variable "ami" {
  default = ""
}

variable "instance_type" {
  default = ""
}

variable "instance_name" {
  default = ""
}

variable "private_ip" {
  default = ""
}

variable "instance_count" {
  default = ""
}

#VPC
variable "subnet" {
  default = "" #Please make sure this subnet has accessibility to internet. Please use public subnet#
}

variable "sg_id" {
  default = "" ##Please insure this security group has Ports - 4646, 8500, 22 and ICMP enabled#
}

#UserScripts
variable "userscripts" {
  default = ""
}
