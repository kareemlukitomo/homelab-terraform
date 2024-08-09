terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "3.0.1-rc3"
    }
  }
}

provider "proxmox" {
  pm_api_url      = var.proxmox_api_url
  pm_user         = var.proxmox_username
  pm_password     = var.proxmox_password
  pm_tls_insecure = true
}

resource "proxmox_vm_qemu" "vm-106" {
  # target_node      = "pve"
  # vmid             = 106
  # additional_wait  = 5
  # # clone_wa         = 10
  name                   = "vm-106"
  balloon                = 1024
  automatic_reboot       = true
  cores                  = 24
  memory                 = 4096
  define_connection_info = true
  scsihw                 = "virtio-scsi-single"
  boot                   = "order=scsi0;ide2;net0"
  full_clone             = false
  hotplug                = "network,disk,usb"
  bios                   = "seabios"
  cpu                    = "host"
  onboot                 = true
  agent                  = 1
  kvm                    = true
  sockets                = 1
  tablet                 = true
  protection             = false
  vm_state               = "running"

  disks {
    ide {
      ide2 {
        cdrom {
          iso = "local:iso/debian-live-12.5.0-amd64-gnome.iso"
        }
      }
    }
    scsi {
      scsi0 {
        disk {
          backup               = true
          discard              = false
          emulatessd           = true
          format               = "raw"
          iops_r_burst         = 0
          iops_r_burst_length  = 0
          iops_r_concurrent    = 0
          iops_wr_burst        = 0
          iops_wr_burst_length = 0
          iops_wr_concurrent   = 0
          iothread             = true
          mbps_r_burst         = 0
          mbps_r_concurrent    = 0
          mbps_wr_burst        = 0
          mbps_wr_concurrent   = 0
          readonly             = false
          replicate            = true
          size                 = "16G"
          storage              = "local-lvm"
        }
      }
    }
  }

  network {
    bridge   = "vmbr0"
    firewall = true
    macaddr  = "BC:24:11:B8:FC:0A"
    model    = "virtio"
  }

  smbios {
    uuid = "2d30fc97-55b7-42f4-9573-c856a43a2a07"
  }

}


resource "proxmox_lxc" "test_atlantis" {
  vmid        = 109
  hostname    = "test-lxc"
  target_node = "pve"
  ostemplate  = "local:vztmpl/debian-12-standard_12.2-1_amd64.tar.zst"

  rootfs {
    storage = "local-lvm"
    size    = "4G"
  }

  cores  = 2
  memory = 512
  swap   = 512

  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = "dhcp"
  }

  network {
    name   = "eth1"
    bridge = "vmbr1"
    ip     = "10.0.1.111/24"
  }

  features {
    nesting = true
  }
}
resource "proxmox_lxc" "test-lxc-2" {
  vmid        = 110
  hostname    = "test-lxc-2"
  target_node = "pve"
  ostemplate  = "local:vztmpl/debian-12-standard_12.2-1_amd64.tar.zst"

  rootfs {
    storage = "local-lvm"
    size    = "4G"
  }

  cores  = 2
  memory = 512
  swap   = 512

  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = "dhcp"
  }

  network {
    name   = "eth1"
    bridge = "vmbr1"
    ip     = "10.0.1.110/24"
  }

  features {
    nesting = true
  }
}
