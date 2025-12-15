# Azure App Service (Terraform)

This folder contains Terraform configuration for an Azure App Service.

## Local Usage

- Prerequisites:
  - Terraform 1.x installed
  - Access to an Azure subscription (and credentials configured if planning/applying)

- Initialize the working directory (downloads providers/modules):

```zsh
terraform init
```

- Create/update a portable provider lock file for both macOS (Apple Silicon) and Linux (x86_64). This ensures consistent provider versions across local dev and CI runners:

```zsh
terraform providers lock -platform=darwin_arm64 -platform=linux_amd64
```

This command generates or updates `.terraform.lock.hcl`. Commit this file to version control to pin provider checksums across environments.

- (Optional) Validate and plan changes:

```zsh
terraform validate
terraform plan \
  -out=plan.tfplan
```

- (Optional) Apply the plan:

```zsh
terraform apply plan.tfplan
```

## Notes

- Update the lock file whenever you change provider constraints or upgrade Terraform.
- Variables expected by this configuration are defined in `variables.tf`. Provide values via `-var`, `-var-file`, or environment variables as needed.
- Standard files:
  - `main.tf`, `variables.tf`, `outputs.tf`, `versions.tf`
