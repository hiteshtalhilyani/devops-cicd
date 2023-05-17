terraform {
  backend "s3" {
    bucket = "terraform-hkt"
    key    = "terraform/backend"
    region = "ap-south-1"

  }
}
