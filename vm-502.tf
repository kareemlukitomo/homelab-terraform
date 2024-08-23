
resource "proxmox_vm_qemu" "vm-502" {
  name                   = "alpha-2"
  tags                   = "k3s"
  full_clone             = false
  memory                 = 10240
  onboot                 = true
  scsihw                 = "virtio-scsi-pci"
  tablet                 = false
  agent                  = 1
  additional_wait        = 5
  automatic_reboot       = true
  bios                   = "ovmf"
  clone_wait             = 10
  cores                  = 10
  define_connection_info = false
  desc                   = <<-EOT
            <div align='center'><a href='https://Helper-Scripts.com'><img src='https://raw.githubusercontent.com/tteck/Proxmox/main/misc/images/logo-81x112.png'/></a>
            
              # Debian 12 VM
            
              <a href='https://ko-fi.com/D1D7EP4GF'><img src='https://img.shields.io/badge/&#x2615;-Buy me a coffee-blue' /></a>
              </div>
        EOT

  disks {
    scsi {
      scsi0 {
        disk {
          backup               = true
          cache                = "writethrough"
          discard              = true
          emulatessd           = true
          format               = "raw"
          iops_r_burst         = 0
          iops_r_burst_length  = 0
          iops_r_concurrent    = 0
          iops_wr_burst        = 0
          iops_wr_burst_length = 0
          iops_wr_concurrent   = 0
          iothread             = false
          mbps_r_burst         = 0
          mbps_r_concurrent    = 0
          mbps_wr_burst        = 0
          mbps_wr_concurrent   = 0
          readonly             = false
          replicate            = true
          size                 = "192G"
          storage              = "local-lvm"
        }
      }
    }
  }

  network {
    bridge    = "vmbr5"
    firewall  = false
    link_down = false
    macaddr   = "BC:24:11:B6:C8:E1"
    model     = "virtio"
    mtu       = 0
    queues    = 0
    rate      = 0
  }
  network {
    bridge    = "vmbr0"
    firewall  = true
    link_down = false
    macaddr   = "BC:24:11:C7:10:B2"
    model     = "virtio"
    mtu       = 0
    queues    = 0
    rate      = 0
  }
  network {
    bridge    = "vmbr1"
    firewall  = true
    link_down = false
    macaddr   = "BC:24:11:7A:CA:AA"
    model     = "virtio"
    mtu       = 0
    queues    = 0
    rate      = 0
  }
}
