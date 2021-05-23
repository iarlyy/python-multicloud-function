variable "create" {
  type    = bool
  default = false
}

variable "name" {
  type = string
}

variable "tags" {
  type    = map(any)
  default = {}
}

variable "runtime" {
  type    = string
  default = "python3.8"
}

variable "handler" {
  type    = string
  default = "aws_handler.handler"
}

variable "memory_size" {
  type    = number
  default = 128
}

variable "timeout" {
  type    = number
  default = 15
}

variable "dist_file" {
  type    = string
  default = "../build/function.zip"
}
