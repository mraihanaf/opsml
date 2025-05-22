resource "aws_glue_catalog_database" "rekognition_db" {
  name        = "rekognition_results_db"
  description = "Database for storing Rekognition results metadata"
  tags = local.commonTags
}

resource "aws_glue_catalog_table" "rekognition_results_table" {
  name          = "rekognition_results_table"
  database_name = aws_glue_catalog_database.rekognition_db.name
  description   = "Table for simplified Rekognition results stored in S3"
  table_type    = "EXTERNAL_TABLE"

  parameters = {
    "classification" = "json"
  }

  storage_descriptor {
    location      = "s3://${aws_s3_bucket.output.bucket}/results"
    input_format  = "org.apache.hadoop.mapred.TextInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat"

    ser_de_info {
      name                  = "json-serde"
      serialization_library = "org.openx.data.jsonserde.JsonSerDe"
      parameters = {
        "serialization.format" = "1"
      }
    }

    columns {
      name = "image_key"
      type = "string"
    }

    columns {
      name = "labels"
      type = "array<struct<Name:string,Confidence:double>>"
    }

  }
}

resource "aws_glue_crawler" "rekognition_crawler" {
  name          = "${var.prefix}-crawler-${var.name}"
  role          = var.labRoleARN
  database_name = aws_glue_catalog_database.rekognition_db.name

  s3_target {
    path = "s3://${aws_s3_bucket.output.bucket}/results"
  }

  table_prefix = "rekognition_"
  tags         = local.commonTags
  schedule     = null
}
