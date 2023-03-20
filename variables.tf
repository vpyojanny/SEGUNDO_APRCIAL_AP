variable "do_token" {
  default = "dop_v1_e593723b8c508c2076090ba80a54b8bef5d615a2a0397d8c9eb6904bc033b105"
  description = "DigitalOcean API token"
}

variable "ssh_key" {
  default = "ca:c1:72:d4:b2:28:dc:23:70:5a:16:e5:76:5c:30:71"
  description = "SSH key ID for DigitalOcean droplet"
}

variable "droplet_size" {
  default     = "s-1vcpu-1gb"
  description = "Droplet size"
}

variable "droplet_region" {
  default     = "nyc1"
  description = "Droplet region"
}

variable "jenkins_port" {
  default     = "8080"
  description = "Jenkins port"
}
