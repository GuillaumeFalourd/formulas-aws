package tpl

const (
	Maintf = `variable "region" {
  default = ""
}
provider "aws" {
  region  = var.region
}

terraform {
  required_version = "0.13.5"
  required_providers {
    aws        = "3.3.0"
  }

  backend "s3" {
  }
}
	`
)
