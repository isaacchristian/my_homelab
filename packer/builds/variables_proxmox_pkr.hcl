variable "proxmox_url" {
    type = string
    description = "Proxmox URL"
    default = "https://10.0.0.19:8006" # env("PROXMOX_URL")
}

variable "proxmox_username" {
    type = string
    description = "Proxmox Username"
    default = "root@pam"
}

variable "proxmox_password" {
    type = string
    description = "Proxmox Password"
    default = env("PROXMOX_PASSWORD")
    sensitive = true
}

variable "proxmox_node" {
    type = string
    description = "Proxmox Node"
    default = "vm1"
}

# Enable TLS verification for Proxmox
# Add vault agent script to inject certificate
variable "proxmox_insecure_skip_tls_verify" {
    type = bool
    description = "Skip TLS verification for Proxmox"
    default = true
}

variable "proxmox_vm_name" {
    type = string
    description = "Name of the Proxmox VM"
    default = "packer-vm"
}

variable "proxmox_vm_id" {
    type = number
    description = "ID of the Proxmox VM"
    default = 105
}

variable "proxmox_template" {
    type = string
    description = "Proxmox Template"
    default = "packer-base-template"
}

variable "proxmox_template_description" {
    type = string
    description = "Description for the Proxmox Template"
    default = "Packer VM"
}

variable "proxmox_bios" {
    type = string
    description = "BIOS type for the Proxmox VM"
    default = "seabios"
}

variable "proxmox_cpu_type" {
    type = string
    description = "CPU type for the Proxmox VM"
    default = "host"
}

variable "proxmox_cpu_cores" {
    type = number
    description = "Number of CPU cores for the Proxmox VM"
    default = 2
}

variable "proxmox_cpu_sockets" {
    type = number
    description = "Number of CPU sockets for the Proxmox VM"
    default = 1
}

variable "proxmox_memory" {
    type = number
    description = "Memory size for the Proxmox VM in MB"
    default = 4096
}

variable "proxmox_boot_iso" {
    type = object({
        iso_download_pve = bool
        iso_url = string
        iso_target_path = string
        iso_checksum = string
        iso_storage_pool = string
        iso_file = string
        unmount = bool
        keep_cdrom_device = bool
    })
    default = {
        iso_download_pve = false
        iso_url = "https://mirror.stream.centos.org/10-stream/BaseOS/x86_64/iso/CentOS-Stream-10-20250728.1-x86_64-boot.iso"
        iso_target_path = "CentOS-Stream-10-20250728.1-x86_64-boot.iso"
        iso_checksum = "sha256:0e632a0289f5de2f4cf2269314173278d789459525cc25ec8559294042f86fe7"
        iso_storage_pool = "cephfs"
        iso_file = "cephfs:iso/CentOS-Stream-10-20250728.1-x86_64-boot.iso"
        unmount = true
        keep_cdrom_device = false
    }
}

variable "proxmox_cloud_init" {
    type = bool
    description = "Proxmox Cloud Init enabled"
    default = true
}

variable "proxmox_cloud_init_storage_pool" {
    type = string
    description = "Storage pool for Proxmox Cloud Init"
    default = "cephfs"
}

variable "proxmox_disks" {
    description = "List of disks for the Proxmox VM"
    type = map(object({
        type = string
        disk_size = string
        storage_pool = string
    }))
    default = {
        0 = {
            type = "scsi"
            disk_size = "10G"
            storage_pool = "cephfs"
        }
    }
}

variable "proxmox_networks" {
    description = "Proxmox Networks"
    type = map(object({
        bridge = string
    }))
    default = {
        0 = {
            bridge = "vmbr0"
        }
    }
}

variable "proxmox_root_username" {
    type = string
    description = "Root username for Proxmox VM"
    default = "root"
}

variable "proxmox_root_password" {
    type = string
    description = "Root password for Proxmox VM"
    default = env("PROXMOX_ROOT_PASSWORD")
    sensitive = true
}

variable "proxmox_build_username" {
    type = string
    description = "Username for the build user in Proxmox VM"
    default = "packer"
}

variable "proxmox_build_password" {
    type = string
    description = "Password for the build user in Proxmox VM"
    default = env("PROXMOX_BUILD_PASSWORD")
    sensitive = true
}

variable "proxmox_communicator" {
    type = string
    description = "Communicator type for Proxmox VM"
    default = "ssh"
}

variable "proxmox_ssh_public_key" {
    type = string
    description = "Public SSH key for Proxmox VM"
    sensitive = true
    default = # ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC3z5Z7+8f5j4k9
}

variable "proxmox_ssh_username" {
    type = string
    description = "SSH username for Proxmox VM"
    default = "root"
}

variable "proxmox_ssh_password" {
    type = string
    description = "SSH password for Proxmox VM"
    default = env("PROXMOX_SSH_PASSWORD")
    sensitive = true
}

variable "proxmox_ssh_port" {
    type = number
    description = "SSH port for Proxmox VM"
    default = 22
}

variable "proxmox_ssh_timeout" {
    type = string
    description = "SSH timeout for Proxmox VM"
    default = "30m"
}

variable "proxmox_boot_command" {
    type = list(string)
    description = "Boot command for Proxmox VM"
    default = [
        "<wait10>",
        "<enter>",
        "linux ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg",
        "<enter>",
}

variable "proxmox_boot_wait" {
    type = string
    description = "Boot wait time for Proxmox VM"
    default = "15s"
}