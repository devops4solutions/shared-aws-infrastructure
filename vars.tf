variable "public_subnets" {
  type = list(any)
}

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