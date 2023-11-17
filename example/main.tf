module "lambda_layers" {
  source = "../modules/lambda_layers"

  s3_bucket_name_prefix     = "lambda-layer-bucket"
  libraries                 = var.libraries
  layer_compatible_runtimes = ["python3.10"]
}
