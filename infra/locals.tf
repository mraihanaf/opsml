locals {
	s3InputBucketName = lower("${var.prefix}input-${var.city}-${var.name}")
	s3OutputBucketName = lower("${var.prefix}output-${var.city}-${var.name}")
	commonTags = {
		Environment = var.environment
		Author = var.name
		Project = "opsml"		
	}

	lambdaEnvironmentVariables = {
		SNS_TOPIC_ARN = aws_sns_topic.topic.arn
	#	KINESIS_STREAM_NAME = 
		DEST_BUCKET = aws_s3_bucket.output.bucket
		TOKEN_TABLE = aws_dynamodb_table.tokens.name
	}
}
