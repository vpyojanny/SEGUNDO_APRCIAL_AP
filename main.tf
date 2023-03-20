provider "google" {
  credentials = file("./GC_Credentials.json")
  project = "pelagic-firefly-342817"
  region  = "us-east1"
  zone    = "us-east1-b"
}

resource "google_compute_instance" "vm_instance" {
  name         = "trf-serv-sp-ap"
  machine_type = "n1-standard-1"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    network = "default"

    access_config {
    }
  }

  metadata = {
    ssh-keys = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDYFdktT9P/WCPHQRwhSxYf3DkouZqm0K6fv5SKrkhha6g8fDSqKQGb2fZyeXI7qQQQ08QMTIQV6tw+QuKnIe3DyNQblI3/GeoowC2VXG9Swpok0Ru7HR5AWUI8WfIj87Ug5DAoV1gsU1lMEJeGoBtNhgoafGXxsu6oaFSoFohjx0q8b5y2l1jUEipQpWBLHiPLbYrfLGPDUn1uQfk4QDsoUeBFsa2+gd/SQmzOs8AWENSdrCFh7eB1qbjlHHCn1Ll7eDxiaItnSwD8af0aBS1X5kDVjR9BDsliVWC97W61X5JkUNTcifukw6eo1z2zAVni73pF7M11Voexnx/rGL2qZlZGS2XLKvvEZDfJ7i5JXdfX0UxnQOzM/eQBX3aQV3HtnSHm0MlVm8IOmjIeLu+u+ZjVv6XDCUxARNqOLaKEnCR01nKKQhx0Te/Moz+rLG6qzP9wiiz5+h9irJPCG6oYFNvGUfanhT8qBTHstFqxtlO7uNXFTP36R2DzT0HbQ0c= yojan@ENDYPC"
  }

  metadata_startup_script = "sudo apt-get update && sudo apt-get install -y docker.io git openjdk-8-jdk && wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add - && echo deb https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list && sudo apt-get update && sudo apt-get install -y jenkins && sudo systemctl start jenkins && sudo systemctl enable jenkins && sudo chmod 777 /var/run/docker.sock && sudo usermod -aG docker jenkins && sudo systemctl restart jenkins"
}

resource "google_compute_firewall" "allow_http" {
name = "allow-http"
network = "default"

allow {
protocol = "tcp"
ports = ["80"]
}

source_ranges = ["0.0.0.0/0"]
}

output "jenkins_url" {
value = "http://${google_compute_instance.vm_instance.network_interface.0.access_config.0.nat_ip}:8080"
}
