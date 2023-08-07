<!-- BEGIN_TF_DOCS -->

# VPC Resources
This file creates a custom VPC from aws public Repository based on **terraform-aws-modules/vpc/aws**
## Source Module info
 - **version**: = "5.0.0"
 - **Link**:  [terraform-aws-modules/vpc/aws](https://github.com/terraform-aws-modules/terraform-aws-vpc)

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
  # Define parameters for each workspace
  env         = {
    default = {
      create                               = false
      name                                 = "${include.root.locals.common_vars.locals.project}-${include.root.locals.environment.locals.workspace}-vpc"
      cidr                                 = "10.10.0.0/16"
      enable_dns_hostnames                 = true
      enable_dns_support                   = true
      azs                                  = ["us-east-2a", "us-east-2b"]#data.aws_availability_zones.azs.zone_ids
      public_subnets                       = ["10.10.1.0/24", "10.10.2.0/24"]
      private_subnets                      = ["10.10.3.0/24", "10.10.4.0/24"]
      database_subnets                     = ["10.10.5.0/24", "10.10.6.0/24"]
      map_public_ip_on_launch = true
      enable_nat_gateway                   = false
      single_nat_gateway                   = true
      one_nat_gateway_per_az               = false
      enable_vpn_gateway                   = false
      enable_flow_log                      = true
      create_flow_log_cloudwatch_iam_role  = true
      create_flow_log_cloudwatch_log_group = true
      flow_log_destination_type            = "cloud-watch-logs"

      tags                                 = {
        Environment = include.root.locals.environment.locals.workspace
        Layer       = "Networking"
      }
    }
    "#{environment}#" = {

      create = true
    }
    "prod" = {

      create = true
    }
  }
  # Merge parameters
  environment_vars = contains(keys(local.env), include.root.locals.environment.locals.workspace) ? include.root.locals.environment.locals.workspace : "default"
  workspace        = merge(local.env["default"], local.env[local.environment_vars])
}


terraform {
  source = "tfr:///terraform-aws-modules/vpc/aws?version=5.0.0"

}

inputs = {
  create_vpc = local.workspace["create"]

  name = local.workspace["name"]
  cidr = local.workspace["cidr"]

  enable_dns_hostnames = local.workspace["enable_dns_hostnames"]
  enable_dns_support   = local.workspace["enable_dns_support"]
  map_public_ip_on_launch = local.workspace["map_public_ip_on_launch"]
  azs              = local.workspace["azs"]
  private_subnets  = local.workspace["private_subnets"]
  public_subnets   = local.workspace["public_subnets"]
  database_subnets = local.workspace["database_subnets"]

  enable_nat_gateway     = local.workspace["enable_nat_gateway"]
  single_nat_gateway     = local.workspace["single_nat_gateway"]
  one_nat_gateway_per_az = local.workspace["one_nat_gateway_per_az"]

  enable_flow_log                      = local.workspace["enable_flow_log"]
  create_flow_log_cloudwatch_iam_role  = local.workspace["create_flow_log_cloudwatch_iam_role"]
  create_flow_log_cloudwatch_log_group = local.workspace["create_flow_log_cloudwatch_log_group"]
  flow_log_destination_type            = local.workspace["flow_log_destination_type"]

  tags = local.workspace["tags"]

}
```
<!-- END_TF_DOCS -->