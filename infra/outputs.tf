output "S3_BUCKET_INPUT_NAME" {
	value = aws_s3_bucket.input.bucket
}

output "S3_BUCKET_OUTPUT_NAME" {
	value = aws_s3_bucket.output.bucket
}

output "API_GATEWAY_URL" {
	value = aws_api_gateway_stage.production.invoke_url
}

output "ECR_REPOSITORY_URL" {
	value = aws_ecr_repository.ecr.repository_url
}

output "SNS_TOPIC_ARN" {
	value = aws_sns_topic.topic.arn
}

output "ATHENA_DB_NAME" {
	value = aws_glue_catalog_database.rekognition_db.name
}

output "ATHENA_SCHEMA_NAME" {
	value = aws_glue_catalog_database.rekognition_db.name
}

output "EKS_CLUSTER_NAME" {
	value = aws_eks_cluster.cluster.name
}
