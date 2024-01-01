# Proxmox Terraform Ansible Kubernetes
Setting up a Kubernetes cluster in Proxmox using Ansible

Version Check
- Proxmox 8.1.3
- Terraform v1.6.5
- Ansible [core 2.16.1]

A. Scripts to create ubuntu image 
 Download and create Ubuntu VM template [image.sh](./image.sh)

* Telmate/terraform-provider-proxmox Bug ([#869][bug])
Proxmox 8.1.3 API update is still not fixed in the Telmate/terraform-provider-proxmox, Workaround is to use a [fork](https://registry.terraform.io/providers/TheGameProfi/proxmox/latest)

[bug]: https://github.com/Telmate/terraform-provider-proxmox/issues/869
