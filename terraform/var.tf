
variable "target_node" {
  type    = string
  default = "heimdall"
}
variable "ssh_key" {
  default = "FIX ME"
}
variable "ip" {
  default = "192.168.0"
}
variable "gateway" {
  default = "192.168.0.1"
}
variable "template_name" {
  default = "ubuntu-20.04-cloudimg"
}
variable "storage" {
  default = "local-lvm"
}
variable "storage_type" {
  default = "local-lvm"
}
variable "storage_size" {
  default = "32G"

}
