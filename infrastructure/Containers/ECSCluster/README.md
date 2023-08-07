<!-- BEGIN_TF_DOCS -->

 # ECS Cluster
 * This file creates a custom Cluster for IaC at scale series using terragrunt based on **terraform-aws-modules/ecs/aws**
 ## Source Module info
 - **version**: = "5.2.0"
 - **Link**:  [terraform-aws-modules/ecs/aws](github.com/terraform-aws-modules/ecs/aws)

## Code Dependencies Graph
<center>

![Graph](./graph.svg)

##### **Dependency Graph**

</center>

---

## Example parameter options for each environment

```hcl


include "root" {
  path = find_in_parent_folders()
  expose = true
}

locals {
  # manage workspaces
  environment = read_terragrunt_config(".environment.hcl",read_terragrunt_config(find_in_parent_folders("common/environment.hcl")))

  # Define parameters for each workspace
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
```
<!-- END_TF_DOCS -->