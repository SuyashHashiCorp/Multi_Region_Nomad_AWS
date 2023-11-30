output "ind_public_ip" {
  value = [module.ind_instance.ind_tag_name, module.ind_instance.ind_public_ip]
}

output "emea_public_ip" {
  value = [module.emea_instance.emea_tag_name, module.emea_instance.emea_public_ip]
}

