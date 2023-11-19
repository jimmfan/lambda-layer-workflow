variable "s3_bucket_name_prefix" {
  type = string
}

variable "layer_compatible_runtimes" {
  type = list(string)
}

variable "library_json_path" {
  type    = string
  default = "../libraries.json"
}