include "root" {
  path = find_in_parent_folders()
  expose = true
}


locals {
  env = {
    default = {

      create_resource_group = false
      enable_app_insights   = false
      description           = "Resource group for ${include.root.locals.common_vars.locals.project}  Resources for ${include.root.locals.environment.locals.workspace}"
      resource_group_name   = "${include.root.locals.common_vars.locals.project}-${include.root.locals.environment.locals.workspace}"
      resource_tags_filters = {
        ResourceTypeFilters = ["AWS::AllSupported"],
        TagFilters          = [
          {
            Key    = "Project",
            Values = [include.root.locals.common_vars.locals.project]
          }
        ]
      }
      tags = {
        Environment = include.root.locals.environment.locals.workspace
        Layer       = "Transversal"
        Protected   = true
        Owner       = "Lead Platform"
        Contact     = "Platform Architects"
      }
    }

    "#{environment}#" = {
      create_resource_group = true

    }

  }
  environment_vars = contains(keys(local.env), include.root.locals.environment.locals.workspace) ? include.root.locals.environment.locals.workspace : "default"
  # Allows to take values from the "default" container in case they are not created
  workspace        = merge(local.env["default"], local.env[local.environment_vars])

}

terraform {
  source = "../../../modules/Resource_Groups"

}

inputs ={
  create_resource_group = local.workspace["create_resource_group"]
  enable_app_insights   = local.workspace["enable_app_insights"]
  description           = local.workspace["description"]
  resource_group_name   = local.workspace["resource_group_name"]
  resource_tags_filters = local.workspace["resource_tags_filters"]

  tags = local.workspace["tags"]
  
}