

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
variable "aws_access_key" {
    default =""
}
variable "aws_secret_access_key" {
    default =""
}