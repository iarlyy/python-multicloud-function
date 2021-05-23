variable "create" {
  type    = bool
  default = false
}

variable "region" {
  type = string
}

variable "name" {
  type = string
}

variable "runtime" {
  type    = string
  default = "Python|3.8"
}

variable "tags" {
  type    = map(any)
  default = {}
}

variable "dist_file" {
  type    = string
  default = "../build/function.zip"
}
