# //////////////////////////////
# BACKEND
# //////////////////////////////
terraform {
  backend "s3" {
    bucket          = "red30-tfstates"
    key             = "red30/ecommerceapp/app.state"
    region          = "us-east-2"
    encrypt         = true
    dynamodb_table  = "red30-tfstatelock"
    access_key      = "AKIA46ODCWVOUMPHSOMU"
    secret_key      = "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"
  }
}

# //////////////////////////////
# VARIABLES
# //////////////////////////////
variable "aws_access_key" {}

variable "aws_secret_key" {}

variable "region" {
  default = "us-east-2"
}

variable "vpc_cidr" {
  default = "172.16.0.0/16"
}

variable "subnet1_cidr" {
  default = "172.16.0.0/24"
}

# //////////////////////////////
# PROVIDERS
# //////////////////////////////
provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.region
}


# //////////////////////////////
# MODULES
# //////////////////////////////
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "vpc-module-example"

  cidr = "10.0.0.0/16"

  azs             = ["us-east-2a", "us-east-2b", "us-east-2c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true
}