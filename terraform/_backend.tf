terraform {
  backend "s3" {
    encrypt = true
    region = "ap-southeast-2"
  }
}
