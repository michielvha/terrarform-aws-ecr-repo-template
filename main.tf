# default settings (AES256 encryption, no extra tagging, etc.),
resource "aws_ecr_repository_creation_template" "ecr_repository_creation_template" {
  prefix               = "ROOT"
  description          = "Main Proxy template"
  image_tag_mutability = "IMMUTABLE"

  applied_for = [
    "PULL_THROUGH_CACHE",
  ]

  encryption_configuration {
    encryption_type = "AES256"
  }

  lifecycle_policy = <<EOT
{
  "rules": [
    {
      "rulePriority": 1,
      "description": "Expire images older than 14 days",
      "selection": {
        "tagStatus": "untagged",
        "countType": "sinceImagePushed",
        "countUnit": "days",
        "countNumber": 14
      },
      "action": {
        "type": "expire"
      }
    }
  ]
}
EOT
}