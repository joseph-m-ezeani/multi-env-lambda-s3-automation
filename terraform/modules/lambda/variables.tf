variable "function" {
  type    = string
  default = "s3-object-reader"
}

variable "env" {
  type    = string
  default = ""
}

variable "timeout" {
  type    = number
  default = 300
}

variable "runtime" {
  type    = string
  default = "python3.9"
}

variable "bucket" {
  type    = string
  default = ""
}

variable "bucket_arn" {
  type    = string
  default = ""
}


variable "access_key" {
  type    = string
  default = ""
}

variable "secret_key" {
  type    = string
  default = ""
}
