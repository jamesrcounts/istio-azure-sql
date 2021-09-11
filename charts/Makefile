default: push

registry := crrealmacaque
repository := sqlworker
login_server := ${registry}.azurecr.io
chart_id := ${login_server}/helm/${repository}

export HELM_EXPERIMENTAL_OCI=1

login:
	az login
	az account set --subscription "Jim Counts (Personal)"
	az account show --output table

save:
	helm chart save ./${repository} ${chart_id}:0.1.0

auth:
	az acr login --name ${registry} --expose-token --output tsv --query accessToken | \
		helm registry login ${login_server} \
			--username 00000000-0000-0000-0000-000000000000 \
			--password-stdin

push: save auth
	helm chart push ${chart_id}:0.1.0