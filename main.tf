terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  // Change if you want to use a different AWS region
  region = "us-west-1"
}

## Create an S3 bucket

resource "aws_s3_bucket" "cjd-learn" {
  bucket = "cjd-tf-test-bucket"

  tags = {
    Name        = "CJD bucket"
    Environment = "Dev"
  }
}


## Create an S3 object to upload "./build/libs/sample.txt"

resource "aws_s3_object" "object" {
  bucket = "cjd-tf-test-bucket"
  key    = "sample.txt"
  source = "build/libs/sample.txt"

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5("build/libs/sample.txt")
}