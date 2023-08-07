output "resource_group_arn" {
  value = aws_resourcegroups_group.resource_group.*.arn
  description = "Resource Tag ARN"
}

output "application_insight_id" {
  value = try(aws_applicationinsights_application.app_insight[0].id, null)
  description = "Application Insight ID"
}