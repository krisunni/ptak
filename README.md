# Proxmox Terraform Ansible Kubernetes
Setting up a Kubernetes cluster in Proxmox using Ansible

`git clone --recurse-submodules -j8 git@github.com:krisunni/ptak.git`

Version Check
- Proxmox 8.1.3
- Terraform v1.6.5
- Ansible [core 2.16.1]

1. Scripts to create ubuntu image 
 Download and create Ubuntu VM template [image.sh](./image.sh)

1. Create hosts using Terraform on Proxmox.
    - As of writing, Proxmox 8.1.3 API update is still not fixed in the Telmate/terraform-provider-proxmox [#869](https://github.com/Telmate/terraform-provider-proxmox/issues/869).
    - I am using a [forked provider](https://github.com/your-username/terraform-provider-proxmox) that is added as a submodule.
    - Build Proxmox Terraform lib as workaround
        - Version Check
            - GNU Make 3.81
            - go version go1.21.1
        - Run this command to build the file. 
        `export VERSION=2.9.14 && cd ./terraform/.terraform/providers/terraform.local/frostyfab && make`
1. Update Host IP and Gateway for your network in [var](./terraform/var.tf)
   ```
        variable "ip" {
        default = "192.168.0"
        }
        variable "gateway" {
        default = "192.168.0.1"
        }
   ```
1. Apply Terrafrom to create hosts
    ```
    cd terraform
    terraform init
    terraform apply
    ```
1. 
