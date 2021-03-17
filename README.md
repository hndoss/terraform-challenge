# Terraform Challenge

The purpose of the following project is to develop infrastructure in Terraform that meets the following requirements:

* Create a custom VPC with three private subnets and three public subnets
* Create an application load balancer to serve traffic web between two EC2 instances
* You must use a custom AMI
* Deploy a VPN server to ssh from home to the EC2 instances
* Create a template to automate this deployment with any CI/CD tool

The solution presents a network module that allows you to create `N` private or public networks in a VPC created by the same module together with security groups that you want to define. [Packer](https://www.packer.io) was implemented to create custom AMI where a script is included to install nginx and to be able to test the infrastructure. Each module is documented with [terraform-docs](https://github.com/terraform-docs/terraform-docs). See [here](./terraform/TERRAFORM_README.md) for Terraform module description. A pipeline in GitHub actions takes care of creating an AMI and managing the infrastructure using the created AMI.

Regarding the VPN server, I opted to create bastion servers in the public network that allow me to enter the private network, it requires access to the key that was used to create the instances in the public and private network. It is done as follows:

``` 
eval $(ssh-agent)
ssh-add terraform.pem # the SSH keypair used to create the public and private instances
ssh -A -i terraform.pem ubuntu@BASTION_IP
ssh -A ubuntu@PRIVATE_INSTANCE_IP
```

## How To Use

``` 
export AWS_ACCESS_KEY_ID="XXXXX"
export AWS_SECRET_ACCESS_KEY="XXXXX"
export AWS_REGION=us-west-2
export TERRAFORM_S3_BUCKET="acklen-terraform-state"

cd terraform

terraform init \
    -backend-config="bucket=${TERRAFORM_S3_BUCKET}" \
    -backend-config="key=temp/terraform"

terraform plan \
    -var aws_access_key_id="${AWS_ACCESS_KEY_ID}" \
    -var aws_secret_access_key="${AWS_SECRET_ACCESS_KEY}" \
    -var aws_region="${AWS_REGION}" \
    -var project="terraform" \
    -var environment="test"

terraform apply \
    -var aws_access_key_id="${AWS_ACCESS_KEY_ID}" \
    -var aws_secret_access_key="${AWS_SECRET_ACCESS_KEY}" \
    -var aws_region="${AWS_REGION}" \
    -var project="terraform" \
    -var environment="test" -auto-approve
```

## Clean everything

``` 
terraform destroy \
    -var aws_access_key_id="${AWS_ACCESS_KEY_ID}" \
    -var aws_secret_access_key="${AWS_SECRET_ACCESS_KEY}" \
    -var aws_region="${AWS_REGION}" \
    -var project="terraform" \
    -var environment="test" -auto-approve
```
