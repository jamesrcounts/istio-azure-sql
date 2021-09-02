variable "admin_group_object_id" {
  description = "(Required) An Object ID of the Azure Active Directory Groups which should have Admin Role on the Cluster."
  type        = string
}

variable "resource_group" {
  description = "(Required) The resource group to deploy the policy into."
  type = object({
    id       = string
    name     = string
    location = string
    tags     = map(string)
  })
}

variable "primary_blob_endpoint" {
  description = " (Required) The blob storage endpoint (e.g. https://MyAccount.blob.core.windows.net). This blob storage will hold all extended auditing logs."
  type        = string
}

variable "resource_suffix" {
  default     = ""
  description = "(Optional) This module will append this value to the resource name."
  type        = string
}

variable "connection_policy" {
  default     = "Default"
  description = "(Optional) The connection policy the server will use. Possible values are Default, Proxy, and Redirect. Defaults to Default."
  type        = string
}