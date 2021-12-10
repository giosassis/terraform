variable "amis" {
  type = map(any)
  default = {
    "us-east-1" = "ami-0b0af3577fe5e3532"
    "us-east-2" = "ami-002068ed284fb165b"
  }
}

variable "remote_access" {
  type    = list(string)
  default = ["201.50.93.17/32"]
}

variable "key_name" {
    type = string
    default = "terraform-aws"
}
