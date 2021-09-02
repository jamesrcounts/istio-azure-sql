locals {
  instance_id      = var.resource_group.tags["instance_id"]
  base_server_name = "sql-${local.instance_id}"
  server_name      = var.resource_suffix == "" ? local.base_server_name : "${local.base_server_name}-${var.resource_suffix}"
}