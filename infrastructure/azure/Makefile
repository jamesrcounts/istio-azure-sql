default: plan

backend_instance_id := real-macaque

login:
	az login
	az account set --subscription "Jim Counts (Personal)"
	az account show --output table

backend_config:
	az keyvault secret download \
		--name azurerm-backend-tfvars \
		--vault-name kv-$(backend_instance_id) \
		--file azurerm.backend.tfvars

fmt:
	terraform fmt -recursive

init:
	terraform init --upgrade -backend-config azurerm.backend.tfvars
	terraform -v
	terraform providers
	
clean:
	terraform destroy -auto-approve

config:
	@echo 'backend_instance_id="$(backend_instance_id)"' > terraform.auto.tfvars

validate:
	terraform validate

plan: config init fmt validate
	terraform plan -out plan.tfplan

apply: fmt init validate
	terraform apply
