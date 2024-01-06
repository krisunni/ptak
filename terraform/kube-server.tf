resource "proxmox_vm_qemu" "kube-server" {
  count                  = 1
  name                   = "kube-server-0${count.index + 1}"
  vmid                   = "40${count.index + 1}"
  ipconfig0              = "ip=${var.ip}.11${count.index + 1}/24,gw=${var.gateway}"
  agent                  = 1
  balloon                = 1
  sockets                = 4
  cores                  = 1
  memory                 = 6044
  clone                  = var.template_name
  bios                   = "seabios"
  boot                   = "order=ide2;scsi0;net0"
  cpu                    = "x86-64-v2-AES"
  define_connection_info = true
  force_create           = false
  full_clone             = true
  hotplug                = "network,disk,usb"
  sshkeys                = <<EOF
  ${var.ssh_key}
  EOF
  kvm                    = true
  nameserver             = var.gateway
  numa                   = false
  onboot                 = true
  oncreate               = true
  qemu_os                = "l26"
  scsihw                 = "virtio-scsi-single"
  searchdomain           = "Home"
  tablet                 = true
  target_node            = "ultron"
  vcpus                  = 0
  disk {
    size    = var.storage_size
    storage = var.storage
    type    = "scsi"
  }
  network {
    model     = "virtio"
    bridge    = "vmbr0"
    firewall  = true
    link_down = false
  }

}
