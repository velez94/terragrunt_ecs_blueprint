<!-- BEGIN_TF_DOCS -->

# Resource Group Module
This module creates resource groups for resources easy management from AWS console.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_resource_group_arn"></a> [resource\_group\_arn](#output\_resource\_group\_arn) | Resource Tag ARN |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_resource_group"></a> [create\_resource\_group](#input\_create\_resource\_group) | Create resource group | `bool` | `true` | no |
| <a name="input_description"></a> [description](#input\_description) | Description for resource group | `string` | `"A result group more"` | no |
| <a name="input_enable_app_insights"></a> [enable\_app\_insights](#input\_enable\_app\_insights) | Enable app insights for resource group | `bool` | `false` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource Group Name | `string` | `"RS_"` | no |
| <a name="input_resource_tags_filters"></a> [resource\_tags\_filters](#input\_resource\_tags\_filters) | Resource group tags | <pre>object( {<br>        ResourceTypeFilters = list(string),<br>        TagFilters= list(object(<br>          {<br>            Key=string,<br>            Values= list(string)<br>          }<br>        )<br>        )<br>      }<br>    )</pre> | <pre>{<br>  "ResourceTypeFilters": [<br>    "AWS::EC2::Instance"<br>  ],<br>  "TagFilters": [<br>    {<br>      "Key": "Stage",<br>      "Values": [<br>        "Test"<br>      ]<br>    }<br>  ]<br>}</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Specifies a key-value map of user-defined tags that are attached to the secret. | `map(string)` | `{}` | no |
<!-- END_TF_DOCS -->