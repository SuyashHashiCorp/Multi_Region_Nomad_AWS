output "usa_public_ip" {
  value = aws_instance.instance[*].public_ip
}

output "usa_tag_name" {
  value = aws_instance.instance[*].tags
}