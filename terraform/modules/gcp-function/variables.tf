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

variable "labels" {
  type    = map(any)
  default = {}
}

variable "runtime" {
  type    = string
  default = "python38"
}

variable "entry_point" {
  type    = string
  default = "handler"
}

variable "available_memory_mb" {
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
