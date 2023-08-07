

include "root" {
  path = find_in_parent_folders()
  expose = true
}

locals {

  env = {
    default = {
      create           = false
      cluster_name     = "${include.root.locals.environment.locals.workspace}-${include.root.locals.common_vars.locals.project}-ecs"

      cluster_settings = {
        "name" : "containerInsights",
        "value" : "enabled"
      }
      fargate_capacity_providers = {
        FARGATE = {
          default_capacity_provider_strategy = {
            weight = 50
          }
        }
        FARGATE_SPOT = {
          default_capacity_provider_strategy = {
            weight = 50
          }
        }
      }

      tags = {
        Environment = include.root.locals.environment.locals.workspace
        Layer       = "Application"
      }
    }
    "#{environment}#" = {
      create = true


    }

  }
  environment_vars = contains(keys(local.env), include.root.locals.environment.locals.workspace) ? include.root.locals.environment.locals.workspace : "default"
  workspace        = merge(local.env["default"], local.env[local.environment_vars])
}


terraform {
  source = "tfr:///terraform-aws-modules/ecs/aws?version=5.2.0"

}

inputs = {
   create           = local.workspace["create"]
  cluster_name     = local.workspace["cluster_name"]
  cluster_settings = local.workspace["cluster_settings"]

  fargate_capacity_providers  = local.workspace["fargate_capacity_providers"]


  tags = local.workspace["tags"]

}