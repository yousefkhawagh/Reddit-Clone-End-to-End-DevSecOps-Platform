variable "instance_type" {
  type    = string
  default = "t2.large"
}

variable "key_name" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "security_group_id" {
  type = string
}

variable "iam_instance_profile" {
  type = string
}

variable "volume_size" {
  type    = number
  default = 30
}

variable "user_data_path" {
  type = string
}

variable "instance_name" {
  type = string
}
