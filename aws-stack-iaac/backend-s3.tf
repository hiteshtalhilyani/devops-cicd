terraform {
  backend "s3" {
    bucket = "terraform-hkt"
    key    = "terraform/backend-webapp"
    region = "ap-south-1"

  }
}
