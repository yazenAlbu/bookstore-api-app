output "website-url" {
  value = "http://${aws_instance.tf-docker-ec2.public_ip}"
}