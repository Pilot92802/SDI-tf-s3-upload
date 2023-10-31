variable "bucket_name" {
  description = "name of my s3 bucket"
  type        = string
  default     = "cjd-tf-test-bucket"
}

variable "file_name" {
  description = "name of my upload file"
  type        = string
  default     = "build/libs/sample.txt"
}

variable "region" {
  description = "region name"
  type        = string
  default     = "us-west-1"
}
