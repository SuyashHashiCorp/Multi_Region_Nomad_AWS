resource "aws_instance" "instance" {
  count                  = var.instance_count
  ami                    = var.ami
  instance_type          = var.instance_type
  private_ip             = var.private_ip[count.index]
  key_name               = "mrnc-key.pem"
  subnet_id              = var.subnet
  vpc_security_group_ids = var.sg_id[*]
  tags = {
    Name = var.instance_name[count.index]
  }

  provisioner "file" {
    source      = "/Users/suyash/Projects/Multi_Region_Nomad_AWS/emea_dc2_nomad_region/scripts/${var.userscripts[count.index]}"
    destination = "/tmp/${var.userscripts[count.index]}"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/${var.userscripts[count.index]}",
      "sudo sh /tmp/${var.userscripts[count.index]}",
    ]
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    password    = ""
    private_key = file(var.key_path)
    host        = self.public_ip
  }
}
