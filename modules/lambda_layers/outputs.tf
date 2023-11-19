output "lambda_layer_arns" {
  value = { for lib in local.libraries : lib.name => aws_lambda_layer_version.lambda_layer[lib.name].arn }
}
