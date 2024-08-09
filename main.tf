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

resource "proxmox_lxc" "test_atlantis" {
	vmid						= 109
  hostname        = "test-lxc"
  target_node     = "pve"
  ostemplate      = "local:vztmpl/debian-11-standard_11.0-1_amd64.tar.gz"

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
    ip            = "10.0.1.109/24"
  }

  features {
    nesting       = true
  }
}
