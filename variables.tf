variable "hosts" {
  type = number
  #default = 3
  default = 1
}

variable "interface" {
  type = string
  default = "ens01"
}

variable "memory" {
  type = string
  default = "3072"
}

variable "vcpu" {
  type = number
  default = 2
}

variable "distros" {
  type = list
  # default = ["ubuntu", "centos", "opensuse"]
  default = ["Gitlab"]
}

variable "ips" {
  type = list
  default = ["192.169.142.11"]
}

variable "macs" {
  type = list
  default = ["52:54:00:50:99:c5"]
}
