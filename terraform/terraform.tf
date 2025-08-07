terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
      version = "0.80.0"
    }
  }
}

provider "proxmox" {
  endpoint = "https://10.0.0.19:8006/"
  username = var.proxmox_username
  password = var.proxmox_password
  insecure = true
}