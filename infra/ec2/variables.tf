variable "tags" {
  type = object({
    Terraform   = string,
    Environment = string
  })
}

variable "name" {
  type = string
}

variable "key" {
  type = string
}

variable "sg_allow_http" {
  type = string
}

variable "sg_default" {
  type = string
}

variable "subnet1" {
  type = string
}

variable "subnet2" {
  type = string
}

variable "vpc_id" {
  type = string
}
