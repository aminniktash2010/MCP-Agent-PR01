# Infrastructure as Code with Terraform and GitHub Actions

This repository contains Terraform configurations for managing Azure infrastructure using GitHub Actions.

## Project Structure

```
├── environments/
│   ├── dev/          # Development environment
│   └── prod/         # Production environment
├── modules/
│   └── networking/   # Networking module
└── scripts/          # Helper scripts
```

## Prerequisites

- Azure Subscription
- Service Principal with Contributor access
- GitHub repository with Actions enabled

## GitHub Secrets Required

The following secrets need to be configured in your GitHub repository:

- `AZURE_CLIENT_ID`: Service Principal Client ID
- `AZURE_CLIENT_SECRET`: Service Principal Secret
- `AZURE_SUBSCRIPTION_ID`: Azure Subscription ID
- `AZURE_TENANT_ID`: Azure Tenant ID

## Workflows

### Main Terraform Workflow
- Triggered on push to main branch and pull requests
- Performs format checking, validation, and planning
- Applies changes only on merge to main

### Destroy Workflow
- Manually triggered workflow
- Requires explicit confirmation
- Includes safety measures and delay for cancellation

## Local Development

1. Clone the repository
2. Copy `.env.example` to `.env` and fill in your Azure credentials
3. Run `source scripts/load_env.sh` to load credentials
4. Navigate to desired environment: `cd environments/dev`
5. Run Terraform commands:
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

## Safety Measures

- Environment-specific state files
- Manual approval required for production changes
- Destroy protection with confirmation requirements
- 30-second delay before destruction
