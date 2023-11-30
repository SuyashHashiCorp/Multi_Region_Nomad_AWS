output "apj_public_ip" {
  value = [module.apj_instance.apj_tag_name, module.apj_instance.apj_public_ip]
}

output "usa_public_ip" {
  value = [module.usa_instance.usa_tag_name, module.usa_instance.usa_public_ip]
}

