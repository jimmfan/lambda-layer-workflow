module "lambda_layers" {
  source = "../modules/lambda_layers"

  s3_bucket_name_prefix     = "lambda-layers"
  library_json_path         = "../libraries.json"
  layer_compatible_runtimes = ["python3.10"]
}