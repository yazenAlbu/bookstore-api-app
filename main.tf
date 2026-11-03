resource "github_repository" "myrepo" {
  name        = "bookstore-api-app"
  visibility  = "private"
  description = "managed by Terraform"
  auto_init   = true

}

resource "github_branch_default" "mydefaultbranch" {
  branch     = "main"
  repository = github_repository.myrepo.name
}

resource "github_repository_file" "app-files" {
  for_each            = toset(var.files)
  file                = each.value
  content             = file(each.value)
  repository          = github_repository.myrepo.name
  branch              = "main"
  commit_message      = "managed by Terraform"
  overwrite_on_create = true
}

resource "aws_security_group" "tf-docker-sg" {
  name = "docker-sec-gr-203-david"
  tags = {
    Name = "project-203-sg-david"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "aws_ami" "al2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "name"
    values = ["al2023-ami-2023*"]
  }
}

resource "aws_instance" "tf-docker-ec2" {
  ami                    = data.aws_ami.al2023.id
  instance_type          = var.instance-type
  key_name               = var.key-name
  vpc_security_group_ids = [aws_security_group.tf-docker-sg.id]

  tags = {
    Name = "David's Web Server of Bookstore"
  }

  user_data = templatefile("user-data.sh", { user-data-git-token = var.git-token, user-data-git-user-name = var.git-user-name })

  depends_on = [github_repository.myrepo, github_repository_file.app-files]
}
