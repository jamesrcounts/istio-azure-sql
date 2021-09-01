locals {
  env_instance_id = module.configuration.imports["appenv-instance-id"]
  //subnets         = jsondecode(module.configuration.imports["subnets"])
}
