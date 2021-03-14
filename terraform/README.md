# How To Use

``` 
export AWS_ACCESS_KEY_ID="XXXXX"
export AWS_SECRET_ACCESS_KEY="XXXXX"
export AWS_REGION=us-west-2
export TERRAFORM_S3_BUCKET="acklen-terraform-state"

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

terraform destroy \
    -var aws_access_key_id="${AWS_ACCESS_KEY_ID}" \
    -var aws_secret_access_key="${AWS_SECRET_ACCESS_KEY}" \
    -var aws_region="${AWS_REGION}" \
    -var project="terraform" \
    -var environment="test" -auto-approve
```

## How to Connect to Private Instance

``` 
eval $(ssh-agent)
ssh-add terraform.pem # the SSH keypair used to create the public and private instances
ssh -A -i terraform.pem ubuntu@BASTION_IP
ssh -A ubuntu@PRIVATE_INSTANCE_IP
```

---
See [here](./TERRAFORM_README.md) for Terraform module description.
