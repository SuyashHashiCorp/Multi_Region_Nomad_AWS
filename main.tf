provider "aws" {
  region = "us-east-2"
}

module "apj_instance" {
  source = "/Users/suyash/Projects/Multi_Region_Nomad_AWS/ind_dc1_nomad_region"
}

module "usa_instance" {
  source = "/Users/suyash/Projects/Multi_Region_Nomad_AWS/emea_dc2_nomad_region"
}
