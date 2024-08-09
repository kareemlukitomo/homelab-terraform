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

resource "proxmox_lxc" "test-lxc" {
	vmid						= 109
  hostname        = "test-lxc"
  target_node     = "pve"
  ostemplate      = "local:vztmpl/debian-12-standard_12.2-1_amd64.tar.zst"

  rootfs {
    storage     	= "local-lvm"
    size          = "4G"
  }

  cores           = 2
  memory          = 512
  swap            = 512

  network {
    name          = "eth0"
    bridge        = "vmbr0"
    ip            = "dhcp"
  }

  network {
    name          = "eth1"
    bridge        = "vmbr1"
    ip            = "10.0.1.111/24"
  }

  features {
    nesting       = true
  }
}
resource "proxmox_lxc" "test-lxc-2" {
	vmid						= 109
  hostname        = "test-lxc-2"
  target_node     = "pve"
  ostemplate      = "local:vztmpl/debian-12-standard_12.2-1_amd64.tar.zst"

  rootfs {
    storage     	= "local-lvm"
    size          = "4G"
  }

  cores           = 2
  memory          = 512
  swap            = 512

  network {
    name          = "eth0"
    bridge        = "vmbr0"
    ip            = "dhcp"
  }

  network {
    name          = "eth1"
    bridge        = "vmbr1"
    ip            = "10.0.1.110/24"
  }

  features {
    nesting       = true
  }
}
