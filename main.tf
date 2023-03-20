terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "2.0"
    }
  }
}
provider "digitalocean" {
  token = "dop_v1_6c8434e9f5378868176eae2cdd963e88b56bbc2c6a54610620644588508a9b85"
}

resource "digitalocean_droplet" "web" {
  image    = "ubuntu-20-04-x64"
  name     = "SP-AP-TERRAFORM"
  region   = "nyc1"
  size     = "s-1vcpu-1gb"
  ssh_keys = ["ca:c1:72:d4:b2:28:dc:23:70:5a:16:e5:76:5c:30:71"]
  # Script de inicio para instalar Docker y Docker Compose
  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y docker.io docker-compose
              EOF

  # Bloque de aprovisionamiento para copiar el archivo docker-compose.yml
  provisioner "file" {
    source      = "docker-compose.yml"
    destination = "./docker-compose.yml"
  }

  provisioner "file"{
  	source		="Dockerfile-php"
  	destination	="./Dockerfile-php"
  }
  

  provisioner "remote-exec" {
    inline = [
      "apt-get update",
      "apt-get install -y docker.io git",
      "docker run -d -p ${var.jenkins_port}:8080 --name jenkins jenkins/jenkins:lts",
      "docker exec -t jenkins bash -c 'echo \"jenkins ALL=(ALL) NOPASSWD: ALL\" >> /etc/sudoers'",
    ]
  }
  connection {
    type     = "ssh"
    user     = "root"
    private_key = file("~/.ssh/id_rsa")
    host     = digitalocean_droplet.web.ipv4_address
  }
}
