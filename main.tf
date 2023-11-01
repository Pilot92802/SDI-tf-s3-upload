terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  backend "http" {
  }
}


# Configure the AWS Provider
provider "aws" {
  // Change if you want to use a different AWS region
  region = var.region
}

## Create an S3 bucket

resource "aws_s3_bucket" "cjd-learn" {
  bucket = var.bucket_name
  bucket_prefix = "cjd"

  tags = {
    Name        = "CJD bucket"
    Environment = "Dev"
  }
}


## Create an S3 object to upload "./build/libs/sample.txt"

resource "aws_s3_object" "object" {
  bucket = var.bucket_name
  key    = "sample.txt"
  source = var.file_name

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5(var.file_name)
}