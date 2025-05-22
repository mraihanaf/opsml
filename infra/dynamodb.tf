resource "aws_dynamodb_table" "tokens" {
	name = "Tokens"
	billing_mode = "PAY_PER_REQUEST"

	hash_key = "token"

	attribute {
		name = "token"
		type = "S"
	}

	stream_enabled = true
	stream_view_type = "NEW_AND_OLD_IMAGES"

	tags = local.commonTags
}

resource "aws_kinesis_stream" "stream" {
    name = "${var.prefix}-kinesis-${var.name}"
    shard_count = 1
    retention_period = 24

    shard_level_metrics = [
        "IncomingBytes",
        "OutgoingBytes"
    ]

    stream_mode_details {
        stream_mode = "PROVISIONED"
    }

    tags = merge({
        Name = "${var.prefix}-kinesis-${var.name}"
    }, local.commonTags)
}

resource "aws_dynamodb_kinesis_streaming_destination" "tokens_to_kinesis" {
  stream_arn = aws_kinesis_stream.stream.arn
  table_name = aws_dynamodb_table.tokens.name
  depends_on = [aws_kinesis_stream.stream]
}