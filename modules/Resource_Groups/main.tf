/*
* # Resource Group Module
* This module creates resource groups for infrastructure easy management from AWS console.
*
*
*/



resource "aws_resourcegroups_group" "resource_group" {
  count       = var.create_resource_group ? 1 : 0
  name        = var.resource_group_name
  description = var.description
  #configuration =
  resource_query {
    query = jsonencode(var.resource_tags_filters)
  }
  tags = var.tags
}


resource "aws_applicationinsights_application" "app_insight" {
  count               = var.enable_app_insights && var.create_resource_group ? 1 : 0
  resource_group_name = aws_resourcegroups_group.resource_group[0].name
  auto_create         = true
  cwe_monitor_enabled = true
  auto_config_enabled = true
  ops_center_enabled  = false //<< enable when ops item is up
  tags                = var.tags
  depends_on          = [aws_resourcegroups_group.resource_group[0]]
}
