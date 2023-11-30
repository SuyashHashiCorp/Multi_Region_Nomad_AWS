output "apj_public_ip" {
  value = aws_instance.instance[*].public_ip
}

output "apj_tag_name" {
  value = aws_instance.instance[*].tags
}