# python-multicloud-function
a python function that is fully compatible to run on AWS Lambda, GCP Functions and Azure Functions

# Steps

#### build
> make build

#### create terraform.tfvars (edit relevant variables, such as: cloud regions, azure subscription id, gcp project id)
> cp terraform.tfvars.dist terraform.tfvars

#### deploy everything
> make deploy-multicloud

#### invoke
> make invoke-all

#### undeploy everything
> make destroy-multicloud

# Useful links

#### AWS
https://docs.aws.amazon.com/lambda/latest/dg/lambda-python.html
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function

#### GCP
https://cloud.google.com/functions/docs/quickstart-python
https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloudfunctions_function

#### Azure
https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/function_app
https://docs.microsoft.com/en-us/azure/app-service/configure-language-python
https://www.maxivanov.io/deploy-azure-functions-with-terraform/
