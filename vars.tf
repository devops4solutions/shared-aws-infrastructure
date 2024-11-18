

variable "vpc_id" {
  type    = string
  default = ""

}

variable "allow_ip" {}
variable "environment"{
    default ="dev"
}
variable "cloudmap_name"{
    default = "corp"
}