# Load variables in locals
locals {
  # Default values for variables
  project  = "#{project}#"

  # Backend Configuration
  backend_profile       = "labvel-devsecops"
  backend_region        = "#{backend_region}#"
  backend_bucket_name   = "#{backend_bucket}#"
  backend_key           = "terraform.tfstate"
  backend_dynamodb_lock = "#{dynamodb_backend}#"
  backend_encrypt       = true
  project_folder = "${local.project}"
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
variable "profile" {
  description = "Variable for credentials management."
  type        = map(map(string))
}

variable "env" {
  description = "Environment Value"
  type = string
  default = "default"
}

variable "project" {
  description = "Project name"
  type        = string
}

variable "required_tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
}

provider "aws" {
  region  = var.profile[var.env]["region"]
  profile = var.profile[var.env]["profile"]

  default_tags {
    tags = var.required_tags
  }
}
EOF
}
