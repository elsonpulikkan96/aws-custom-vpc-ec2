# variables.tf

variable "aws_region" {
  description = "AWS region"
}

variable "aws_access_key" {
  description = "AWS access key"
}

variable "aws_secret_key" {
  description = "AWS secret key"
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
}

variable "public_subnet_cidr_block" {
  description = "CIDR block for the public subnet"
}

variable "private_subnet_1_cidr_block" {
  description = "CIDR block for the first private subnet"
}

variable "private_subnet_2_cidr_block" {
  description = "CIDR block for the second private subnet"
}

variable "preferred_availability_zone" {
  description = "Preferred availability zone for public subnet"
}

variable "another_availability_zone" {
  description = "Another availability zone for the second private subnet"
}

variable "ami_id" {
  description = "AMI ID for instances"
}

variable "key_pair_name" {
  description = "Name of the EC2 key pair"
}

variable "project_name" {
  type        = string
  description = "Name of the project"
  default     = "wp"
}

variable "project_owner" {
  type        = string
  description = "Owner of the project"
  default     = "elson"
}
