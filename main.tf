# Utils account containing users
provider "aws" {
  version = "~> 4.25"
  profile = "shared"
  region  = var.region_shared
}

# Prod account
provider "aws" {
  version = "~> 4.25"
  profile = "prod"
  region  = var.region_prod
  alias   = "prod"
}
