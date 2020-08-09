variable profile {
  type    = string
  default = "default"
}
variable region {
  type    = string
  default = "ap-northeast-1"
}

variable bucket_name { type = map }
variable cidr_blocks_dev {
  type    = list
  default = ["0.0.0.0/0"]
}
variable path_to_ssh_key_pub { type = string }