terraform {
  backend "s3" {
    bucket = "reddit-clone-bucket-1"
    key    = "Jenkins/terraform.tfstate"
    region = "us-east-1"
  }
}
