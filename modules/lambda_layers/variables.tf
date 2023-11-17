variable "libraries" {
  type = list(object({
    name : string
    zip_path : string
  }))
}

variable "s3_bucket_name_prefix" {
  type = string
}

variable "layer_compatible_runtimes" {
  type = list(string)
}
