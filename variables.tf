variable "do_token" {
  default = "dop_v1_6c8434e9f5378868176eae2cdd963e88b56bbc2c6a54610620644588508a9b85"
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
