data "archive_file" "lambda_get" {
	type = "zip"
	source_file = "../lambda/lambda_get.py"
	output_path = "./lambda/lambda_get.zip"
}

data "archive_file" "lambda_post" {
	type = "zip"
	source_file = "../lambda/lambda_post.py"
	output_path = "./lambda/lambda_post.zip"
}

data "archive_file" "lambda_s3" {
	type = "zip"
	source_file = "../lambda/lambda_s3.py"
	output_path = "./lambda/lambda_s3.zip"
}

resource "aws_lambda_function" "get" {
	function_name = "${var.prefix}-lambda-get"
	timeout = 120
	role = var.labRoleARN
	runtime = "python3.13"
	environment {
		variables = local.lambdaEnvironmentVariables
	}
	filename = data.archive_file.lambda_get.output_path
	source_code_hash = data.archive_file.lambda_get.output_base64sha256
	handler = "lambda_get.lambda_handler"
	description = "GET Function for opsml Project"

	tags = merge({
		Name = "${var.prefix}-lambda-get"
	}, local.commonTags)
}

resource "aws_lambda_function" "post" {
	function_name = "${var.prefix}-lambda-post"
	timeout = 60
	role = var.labRoleARN
	runtime = "python3.13"
	environment {
		variables = local.lambdaEnvironmentVariables
	}
	filename = data.archive_file.lambda_post.output_path
	source_code_hash = data.archive_file.lambda_post.output_base64sha256
	handler = "lambda_post.lambda_handler"
	description = "POST Function for opsml Project"

	tags = merge({
		Name = "${var.prefix}-lambda-post"
	}, local.commonTags)
}

resource "aws_lambda_function" "s3" {
	function_name = "${var.prefix}-lambda-s3"
	timeout = 60
	role = var.labRoleARN
	runtime = "python3.13"
	environment {
		variables = local.lambdaEnvironmentVariables
	}
	filename = data.archive_file.lambda_s3.output_path
	source_code_hash = data.archive_file.lambda_s3.output_base64sha256
	handler = "lambda_s3.lambda_handler"
	description = "S3 Function for opsml Project"

	tags = merge({
		Name = "${var.prefix}-lambda-s3"	
	}, local.commonTags)
}
