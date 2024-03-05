variable "name" {
  type = string
}

variable "image_name" {
  type = string
}

variable "image_version" {
  type = string
}

variable "asg_arn" {
  type = string
}

variable "lb_target_group" {
  type = string
}

variable "subnets" {
  type = list(string)
}
