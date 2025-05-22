resource "aws_api_gateway_rest_api" "rest_api" {
  name        = "${var.prefix}-API-${var.name}"
  description = ""
  endpoint_configuration {
    types = ["REGIONAL"]
  }

  tags = merge({
    Name = "${var.prefix}-API-${var.name}"
  }, local.commonTags)
}


resource "aws_api_gateway_resource" "validate_token" {
  parent_id   = aws_api_gateway_rest_api.rest_api.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  path_part   = "validate-token"
  
}

resource "aws_api_gateway_method" "validate_token_get" {
  rest_api_id   = aws_api_gateway_rest_api.rest_api.id
  resource_id   = aws_api_gateway_resource.validate_token.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "validate_token_get" {
  rest_api_id             = aws_api_gateway_rest_api.rest_api.id
  resource_id             = aws_api_gateway_resource.validate_token.id
  integration_http_method = "POST"
  http_method             = aws_api_gateway_method.validate_token_get.http_method
  type                    = "AWS_PROXY"
  credentials             = var.labRoleARN
  uri                     = aws_lambda_function.get.invoke_arn
}

resource "aws_api_gateway_resource" "generate_token" {
  parent_id   = aws_api_gateway_rest_api.rest_api.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  path_part   = "generate-token"
}

resource "aws_api_gateway_method" "generate_token_post" {
  rest_api_id   = aws_api_gateway_rest_api.rest_api.id
  resource_id   = aws_api_gateway_resource.generate_token.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "generate_token_post" {
  rest_api_id             = aws_api_gateway_rest_api.rest_api.id
  resource_id             = aws_api_gateway_resource.generate_token.id
  integration_http_method = "POST"
  http_method             = aws_api_gateway_method.generate_token_post.http_method
  type                    = "AWS_PROXY"
  credentials             = var.labRoleARN
  uri                     = aws_lambda_function.post.invoke_arn
}

resource "aws_api_gateway_stage" "production" {
  stage_name    = "production"
  rest_api_id   = aws_api_gateway_rest_api.rest_api.id
  deployment_id = aws_api_gateway_deployment.api_deployment.id
}

resource "aws_api_gateway_deployment" "api_deployment" {
  depends_on = [
    aws_api_gateway_integration.generate_token_post,
    aws_api_gateway_integration.validate_token_get
  ]
  rest_api_id = aws_api_gateway_rest_api.rest_api.id

}


