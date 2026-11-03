variable "files" {
  default = ["bookstore-api.py", "Dockerfile", "compose.yaml", "requirements.txt"]
}

variable "git-token" {
  default = "xxxxxxxxxxxxxxxxxxxxxxxxxx" # Update with your token!!!!!!!!!!!!!!!!!!  
}

variable "git-user-name" {
  default = "davidinst" # Update with your github username !!!!!!!!!!!!!!!!!!
}

variable "key-name" {
  default = "davidskey" # Update with your key name !!!!!!!!!!!!!!!!!!

}

variable "instance-type" {
  default = "t3.small"  # update with a free tier eligible instance type
}


