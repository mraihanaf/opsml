resource "aws_sns_topic" "topic" {
	name = "${var.prefix}-sns-${var.city}-${var.name}"
	tags = merge({
		Name = "${var.prefix}-sns-${var.city}-${var.name}"
	}, local.commonTags)
}

resource "aws_sns_topic_subscription" "notification" {
	topic_arn = aws_sns_topic.topic.arn
	protocol = "email"
	endpoint = var.adminEmail
}
