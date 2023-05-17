terraform {
  backend "s3" {
    bucket = "terraform-hkt"
    key    = "terraform/backend_exercise6"
    region = "ap-south-1"

  }
}
