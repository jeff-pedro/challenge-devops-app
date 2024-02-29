terraform {
  backend "s3" {
    bucket = "terraform-states-aluraflix"
    key    = "dev/terraform.tfstate"
    region = "us-east-2"
  }
}
