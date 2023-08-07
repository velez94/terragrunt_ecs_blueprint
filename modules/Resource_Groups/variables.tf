variable "resource_group_name" {
  description = "Resource Group Name"
  type = string
  default = "RS_"
}


variable "resource_tags_filters" {
  description = "Resource group tags"
  type =   object( {
        ResourceTypeFilters = list(string),
        TagFilters= list(object(
          {
            Key=string,
            Values= list(string)
          }
        )
        )
      }
    )

  default = {
    ResourceTypeFilters= ["AWS::EC2::Instance"],
    TagFilters= [
    {
      Key= "Stage",
      Values=["Test"]
    }
  ]
  }
}

variable "enable_app_insights" {
  description = "Enable app insights for resource group"
  type = bool
  default = false
}

variable "create_resource_group" {
  description = "Create resource group"
  type= bool
  default = true
}

variable "tags" {
  default     = {}
  description = "Specifies a key-value map of user-defined tags that are attached to the secret."
  type        = map(string)
}

variable "description" {
  description = "Description for resource group"
  type= string
  default = "A result group more"
}

