source "proxmox-iso" "home" {
    proxmox_url = var.proxmox_url
    username    = var.proxmox_username
    password    = var.proxmox_password
    node        = var.proxmox_node

    vm_name    = var.proxmox_vm_name
    vm_id      = var.proxmox_vm_id

    template_name = var.proxmox_template
    template_description = var.proxmox_template_description

    bios = var.proxmox_bios
    cpu_type = var.proxmox_cpu_type
    cores = var.proxmox_cpu_cores
    sockets = var.proxmox_cpu_sockets
    memory = var.proxmox_memory

    cloud_init = var.proxmox_cloud_init
    cloud_init_storage_pool = var.proxmox_cloud_init_storage_pool

    boot_iso {
        iso_url = var.proxmox_boot_iso.iso_url
        iso_target_path = var.proxmox_boot_iso.iso_target_path
        iso_checksum = var.proxmox_boot_iso.iso_checksum
        iso_storage_pool = var.proxmox_boot_iso.iso_storage_pool
        iso_file = var.proxmox_boot_iso.iso_file
        iso_download_pve = var.proxmox_boot_iso.iso_download_pve
        unmount = var.proxmox_boot_iso.unmount_iso
        keep_cdrom_device = var.proxmox_boot_iso.keep_cdrom_device
    }

    dynamic "disks" {
        for_each = var.proxmox_disks
        content {
            type = disks.value.type
            disk_size = disks.value.disk_size
            storage_pool = disks.value.storage_pool
        }
    }

    dynamic "network_adapters" {
        for_each = var.proxmox_networks
        content {
            bridge = network_adapters.value.bridge
        }
    }

    http_content = {
        "/ks.cfg" = templatefile("${path.cwd}/packer/base/http/ks.cfg", {
            "ssh_public_key" = var.proxmox_ssh_public_key
            "root_password" = var.proxmox_root_password
            "user_name" = var.proxmox_build_username
            "user_password" = var.proxmox_build_password
        })
    }

    boot_command = var.proxmox_boot_command
    boot_wait = var.proxmox_boot_wait

    communicator = var.proxmox_communicator

    ssh_username = var.proxmox_communicator == "ssh" ? var.proxmox_ssh_username : null
    ssh_password = var.proxmox_communicator == "ssh" ? var.proxmox_ssh_password : null
    ssh_timeout = var.proxmox_communicator == "ssh" ? var.proxmox_ssh_timeout : null

    
}