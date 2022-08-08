### PROD ACCOUNT ###

resource "aws_iam_role" "prod_all_ecr" {
  name = "ecr-all-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Action    = "sts:AssumeRole",
        Principal = { "AWS" : "arn:aws:iam::${data.aws_caller_identity.shared.account_id}:root" }
    }]
  })
  provider = aws.prod
}

resource "aws_iam_policy" "ecr_all" {
  name        = "ecr-all"
  description = "allows all ECR actions"
  policy      = file("ecr_role_permissions_policy.json")

  provider = aws.prod
}

resource "aws_iam_policy_attachment" "ecr_all" {
  name       = "all ECR actions policy to role"
  roles      = ["${aws_iam_role.prod_all_ecr.name}"]
  policy_arn = aws_iam_policy.ecr_all.arn
  provider   = aws.prod
}

### Shared ACCOUNT ###

resource "aws_iam_role" "shared_role" {
  name = "shared_role"

  tags = {
    name = "shared-role"
  }
}

resource "aws_iam_policy" "prod_ecr" {
  name        = "prod_ecr"
  description = "allow assuming prod_ecr role"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = "sts:AssumeRole",
        Resource = "arn:aws:iam::${data.aws_caller_identity.prod.account_id}:role/${aws_iam_role.prod_all_ecr.name}"
    }]
  })
}
