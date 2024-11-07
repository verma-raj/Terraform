terraform {
  required_version = ">= 1.9.8"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.70.0"

    }

  }
}

provider "aws" {
      access_key = "${var.AWS_ACCESS_KEY}"
      secret_key = "${var.AWS_SECRET_KEY}"
      region = "${var.AWS_REGION}"

}
