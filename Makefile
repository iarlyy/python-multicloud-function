base_dir := $(shell pwd)
terraform_values_path := $(shell echo $(base_dir)/terraform.tfvars)
build_folder_path := "./build"
dist_package_filename := "function.zip"
gcp_project_name := ""
gcp_region := ""

invoke-aws:
	aws lambda invoke \
		--function-name $(shell cd terraform ; terraform output -raw aws_function_name) \
		--payload $(shell cat events/aws_lambda.json| base64 ) out \
		--log-type Tail \
		--query 'LogResult' --output text |  base64 -d && \
		cat out | jq -r && rm -f out

invoke-gcp:
	gcloud functions call \
		$(shell cd terraform ; terraform output -raw gcp_function_name|cut -d "/" -f6) \
		--data '$(shell cat events/gcp_function.json)'	 \
		--project $(gcp_project_name) \
		--region $(gcp_region)

invoke-all: invoke-aws invoke-gcp

.PHONY: build
build:
	@echo building && \
	if [ -d ./build ]; then rm -rf ./build; fi && \
	mkdir $(build_folder_path) && \
	cp gcp_handler.py main.py && \
	zip -r9 $(build_folder_path)/$(dist_package_filename) *.json *.py function/* && \
	rm -f main.py

deploy-aws:
	@cd terraform && \
	terraform init && \
	terraform apply -var-file=$(terraform_values_path)

deploy-azure:
	@cd terraform
	echo deploy-azure

deploy-gcp:
	@cd terraform
	echo deploy-gcp

deploy-multicloud: deploy-aws
	@echo "Deployed!"

destroy-multicloud:
	@cd terraform && \
	terraform init && \
	terraform destroy -var-file=$(terraform_values_path)
