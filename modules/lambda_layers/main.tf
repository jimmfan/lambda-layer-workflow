resource "aws_s3_bucket" "lambda_layer_bucket" {
  bucket_prefix = var.s3_bucket_name_prefix
}

resource "aws_s3_object" "lambda_layer_object" {
  for_each = { for lib in var.libraries : lib.name => lib }

  bucket = aws_s3_bucket.lambda_layer_bucket.id
  key    = "${each.value.name}.zip"
  source = each.value.zip_path
  etag   = filemd5(each.value.zip_path)
}

resource "aws_lambda_layer_version" "lambda_layer" {
  for_each = { for lib in var.libraries : lib.name => lib }

  layer_name          = each.value.name
  s3_bucket           = aws_s3_bucket.lambda_layer_bucket.id
  s3_key              = "${each.value.name}.zip"
  compatible_runtimes = var.layer_compatible_runtimes

  depends_on = [aws_s3_object.lambda_layer_object]
}