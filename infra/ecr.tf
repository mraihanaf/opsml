resource "aws_ecr_repository" "ecr" {
	name = "${var.prefix}-ecr-${var.city}-${var.name}"
	image_tag_mutability = "IMMUTABLE"

	image_scanning_configuration {
		scan_on_push = true
	}

	tags = merge({
		Name = "${var.prefix}-ecr-${var.city}-${var.name}"
	}, local.commonTags)
} 
