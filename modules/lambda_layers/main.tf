resource "aws_s3_bucket" "lambda_layer_storage" {
  bucket_prefix = var.s3_bucket_name_prefix
  force_destroy = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "lambda_layer_storage" {
  bucket = aws_s3_bucket.lambda_layer_storage.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

locals {
  libraries = jsondecode(file(var.library_json_path)).include
}

resource "aws_s3_object" "lambda_layer_object" {
  for_each = {
    for lib in local.libraries : "${lib.name}" => "${lib.name}-${lib.version}.zip"
  }

  bucket = aws_s3_bucket.lambda_layer_storage.id
  key    = each.value
  source = each.value
  # etag   = filemd5("../${each.value}")
}

resource "aws_lambda_layer_version" "lambda_layer" {
  for_each = {
    for lib in local.libraries : "${lib.name}" => "${lib.name}-${lib.version}.zip"
  }

  layer_name          = each.key
  s3_bucket           = aws_s3_bucket.lambda_layer_storage.id
  s3_key              = each.value
  compatible_runtimes = var.layer_compatible_runtimes

  depends_on = [aws_s3_object.lambda_layer_object]
}