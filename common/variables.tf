# General variables

# tflint-ignore: terraform_unused_declarations
variable "profile" {
  description = "Variable for credentials management."
  type        = map(map(string))
  default = {
    default = {
      profile = "deploy_account"
      region  = "us-east-1"
    }
    dev = {
      profile = "deploy_account"
      region  = "us-east-1"
    }
  }
}

# tflint-ignore: terraform_unused_declarations
variable "project" {
  description = "Project name"
  type        = string
  default     = "project_name"
}

# tflint-ignore: terraform_unused_declarations
variable "required_tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default = {
    Project   = "project_name"
    Owner     = "owner_name"
    ManagedBy = "Terraform-Terragrunt"
  }
}
# tflint-ignore: terraform_unused_declarations
variable "env" {
  description = "Environment Value"
  type = string
  default = "default"
}