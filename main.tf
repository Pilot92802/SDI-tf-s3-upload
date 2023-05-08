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
  region = "us-east-1"
}

## Create an S3 bucket

resource "aws_s3_bucket" "example" {
  bucket = "akash-my-tf-test-bucket"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_object" "object" {
  bucket = "akash-my-tf-test-bucket"
  key    = "sample.txt"
  source = "build/libs/sample.txt"
  

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5("build/libs/sample.txt")
}



## Create an S3 Object referencing the file at "./build/libs/sample.txt"