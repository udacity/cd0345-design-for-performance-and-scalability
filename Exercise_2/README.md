
Configure the AWS profile to use for this session.
```bash
aws configure set profile ucloud
```

To verify that the profile is set, run the following command:
```bash
aws configure list
```

Initialize terraform backend with the AWS profile.
```bash
terraform init
```

Deploy the infrastructure.
```bash
terraform apply
```

Destroy the infrastructure.
```bash
terraform destroy
```