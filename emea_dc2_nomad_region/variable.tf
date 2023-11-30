variable "key_path" {
  default = "/Users/suyash/Projects/AWS-Keys/mrnc-key.pem"
}

#EC2
variable "ami" {
  default = "ami-0fb653ca2d3203ac1"
}

variable "instance_type" {
  default = "t2.medium"
}

variable "instance_name" {
  type    = list(string)
  default = ["EMEA-Nomad-Consul-Server", "EMEA-Nomad-Consul-Client"]
}

variable "private_ip" {
  type    = list(any)
  default = ["10.0.1.34", "10.0.1.35"]
}

variable "instance_count" {
  type    = number
  default = 2
}

#VPC
variable "subnet" {
  type    = string
  default = "" #Please make sure this subnet has accessibility to internet. Please use public subnet#
}

variable "sg_id" {
  type    = list(any)
  default = [""] ##Please insure this security group has Ports - 4646, 8500, 22 and ICMP enabled#
}

#UserScripts
variable "userscripts" {
  type    = list(any)
  default = ["emea_nomad1_data.sh", "emea_client1_data.sh"]
}
