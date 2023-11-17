output "lambda_layer_arns" {
  value = [for layer in aws_lambda_layer_version.lambda_layer : layer.arn]
}