resource "aws_ecr_repository" "frontend" {
  name                 = "shopsphere/frontend"
  image_tag_mutability = "MUTABLE"
  force_delete         = true

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name        = "shopsphere-frontend"
    Environment = "dev"
    Project     = "shopsphere"
  }
}


resource "aws_ecr_repository" "user_service" {
  name                 = "shopsphere/user-service"
  image_tag_mutability = "MUTABLE"
  force_delete         = true

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name        = "shopsphere-user-service"
    Environment = "dev"
    Project     = "shopsphere"
  }
}


