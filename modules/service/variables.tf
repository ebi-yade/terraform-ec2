variable tags { type = map }
variable bucket_name { type = string }
variable cidr_blocks_dev { type = list }
variable path_to_ssh_key_pub { type = string }
variable subnets { type = list }
variable vpc_id { type = string }

variable suffix {
  type        = string
  description = "suffix for each env"
}
variable suffix_kebab {
  type        = string
  description = "suffix for each env, which has only "
}