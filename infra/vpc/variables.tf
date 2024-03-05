variable "name" {
  type = string
}

variable "cidr" {
  type = string
}

variable "tags" {
  type = object({
    Terraform   = string,
    Environment = string
  })
}

variable "azs" {
  type = list(string)
}
