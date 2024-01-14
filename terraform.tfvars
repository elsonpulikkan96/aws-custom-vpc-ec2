# terraform.tfvars

aws_region     = "ap-south-1"
aws_access_key = "AKIASIXO46V7IS67JHFU"
aws_secret_key = "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"

vpc_cidr_block              = "10.0.0.0/16"
public_subnet_cidr_block    = "10.0.1.0/24"
private_subnet_1_cidr_block = "10.0.2.0/24"
private_subnet_2_cidr_block = "10.0.3.0/24"

preferred_availability_zone = "ap-south-1a"
another_availability_zone   = "ap-south-1b"

ami_id        = "ami-0a0f1259dd1c90938"
key_pair_name = "elsonbombay"
