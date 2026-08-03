variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "project_name" {
  description = "Prefix used for naming/tagging all resources"
  type        = string
  default     = "url-shortener"
}


variable "primary_public_key" {
  description = "Primary SSH public key, registered as the AWS EC2 key pair"
  type        = string
}

variable "additional_public_keys" {
  description = "Extra SSH public keys (e.g. teammate) added via cloud-init"
  type        = list(string)
  default     = []
}

variable "ami_id" {
  description = "ami ID of the EC2 instance"
  type = string
}