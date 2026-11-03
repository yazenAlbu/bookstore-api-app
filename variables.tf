variable "files" {
  default = [
    "bookstore-api.py",
    "Dockerfile",
    "compose.yaml",
    "requirements.txt"
  ]
}

variable "git-token" {
  type      = string
  sensitive = true
}

variable "git-user-name" {
  default = "yazenAlbu"
}

variable "key-name" {
  default = "linuspass"
}

variable "instance-type" {
  default = "t3.small"
}