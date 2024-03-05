variable "name" {
  type = string
}

variable "image" {
  type = string
}

variable "container_name" {
  type = string
}


variable "asg_arn" {
  type = string
}

variable "lb_target_group" {
  type = string
}

variable "subnets" {
  default = null
}

variable "cluster_name" {
  type = string
}
