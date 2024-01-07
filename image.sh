#!/bin/bash
# Thanks to this guide https://github.com/UntouchedWagons/Ubuntu-CloudInit-Docs
# Constants
CLOUD_IMAGE_URL="https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img"
VM_ID=9000
VM_NAME="ubuntu-jammy-cloudinit-template"
MEMORY=2048
CORES=2
BRIDGE="vmbr0"
DISK_NAME="jammy-server-cloudimg-amd64.img"
DISK_FORMAT="local-lvm"
DISK_ID="vm-${VM_ID}-disk-0"
BOOT_DISK="scsi0"
CLOUD_INIT_DISK="local-lvm:cloudinit"

# Download preferred cloud image
wget "$CLOUD_IMAGE_URL"

# Install libguestfs-tools only if not already installed
if ! command -v virt-customize &> /dev/null; then
    sudo apt update -y
    sudo apt install libguestfs-tools -y
fi

# Customize the cloud image
sudo virt-customize -a "$DISK_NAME" --install qemu-guest-agent

# Create VM
sudo qm create "$VM_ID" --name "$VM_NAME" --memory "$MEMORY" --cores "$CORES" --net0 virtio,bridge="$BRIDGE"

# Import disk
sudo qm importdisk "$VM_ID" "$DISK_NAME" "$DISK_FORMAT"

# Set VM configurations
sudo qm set "$VM_ID" --scsihw virtio-scsi-pci --scsi0 "$DISK_FORMAT:$DISK_ID",import-from=$DISK_NAME
sudo qm set "$VM_ID" --boot c --bootdisk "$BOOT_DISK"
sudo qm set "$VM_ID" --ide2 "$CLOUD_INIT_DISK"
sudo qm set "$VM_ID" --serial0 socket --vga serial0
sudo qm set "$VM_ID" --agent enabled=1

# Create VM template
sudo qm template "$VM_ID"
