# Default values for deployment credentials
# Access profile in your IDE env or pipeline the IAM user to use for deployment."
# Don forget export env var --- export TF_VAR_env=dev
profile = {
  default = {
    profile = "labvel-dev"
    region  = "#{backend_region}#"
  }
  "#{environment}#" = {
    profile = "labvel-dev"
    region  = "#{backend_region}#"
  }
}

# Project Variable
project = "#{project}#"

# Project default tags
required_tags = {
  Project   = "#{project}#"
  ManagedBy = "Terragrunt"
  Initiative = "BlogsAmbassador"
}
