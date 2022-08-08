data "aws_caller_identity" "shared" {}

data "aws_caller_identity" "prod" {
  provider = aws.prod
}

