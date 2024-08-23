
resource "proxmox_vm_qemu" "vm-202" {
  name                   = "homelab"
  full_clone             = false
  memory                 = 8192
  onboot                 = true
  scsihw                 = "virtio-scsi-single"
  tablet                 = true
  agent                  = 1
  additional_wait        = 5
  automatic_reboot       = true
  clone_wait             = 10
  cores                  = 24
  cpu                    = "host,flags=+aes"
  bios                   = "seabios"
  define_connection_info = false
  startup                = "order=3,up=60"

  disks {
    scsi {
      scsi0 {
        disk {
          backup               = true
          cache                = "writeback"
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
          size                 = "640G"
          storage              = "local-lvm"
        }
      }
    }
  }

  network {
    bridge    = "vmbr1"
    firewall  = true
    link_down = false
    macaddr   = "BC:24:11:8F:B4:06"
    model     = "virtio"
    mtu       = 0
    queues    = 0
    rate      = 0
  }
  network {
    bridge    = "vmbr0"
    firewall  = true
    link_down = false
    macaddr   = "BC:24:11:D3:3F:F6"
    model     = "virtio"
    mtu       = 0
    queues    = 0
    rate      = 0
  }
}
