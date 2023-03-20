terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "2.0"
    }
  }
}
provider "digitalocean" {
  token = var.do_token
}

resource "digitalocean_droplet" "web" {
  image    = "ubuntu-20-04-x64"
  name     = "SP-AP-TERRAFORM"
  region   = var.droplet_region
  size     = var.droplet_size
  ssh_keys = [var.ssh_key]
  # Script de inicio para instalar Docker y Docker Compose
  # Bloque de aprovisionamiento para copiar el archivo docker-compose.yml
  #provisioner "file" {
  #  source      = "./docker-compose.yaml"
  # destination = "./docker-compose.yaml"
  #}

  #provisioner "file"{
  #	source		="./Dockerfile-php"
  #	destination	="./Dockerfile-php"
  #}
  

  provisioner "remote-exec" {
    inline = [
      "apt-get update",
      "apt-get install -y docker.io git",
      #"docker run -d -p ${var.jenkins_port}:8080 --name jenkins jenkins/jenkins:lts",
      #"sudo docker exec -t jenkins bash -c 'echo \"jenkins ALL=(ALL) NOPASSWD: ALL\" >> /etc/sudoers'",
      "apt-get install -y git docker-compose",
      "git clone https://github.com/vpyojanny/SEGUNDO_PARCIAL_AP.git GITHUB_DIR",
      "cd GITHUB_DIR",
      "docker-compose build",
      "docker-compose up -d"
    ]
  }
  connection {
    type     = "ssh"
    user     = "root"
    private_key = file("~/.ssh/id_rsa")
    host     = digitalocean_droplet.web.ipv4_address
  }
}
