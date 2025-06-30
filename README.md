# Descope Terraform Demo

This repository demonstrates how to manage Descope projects and flows using Terraform. It includes automated workflows for promoting flows from staging to production and managing deployments.

## Purpose

This demo is designed for Descope Solutions Engineers (SEs) and Developer Relations (DevRel) teams to showcase a lightweight CI/CD workflow for managing authentication flows. It demonstrates:

- How to manage Descope Flows as Infrastructure as Code (IaC)
- The complete lifecycle of making authentication changes
- Best practices for promoting changes from staging to production
- Integration with modern CI/CD tools and workflows

## Setup

> A Full Complete Guide to setting this demo up can be found in this [Notion page](https://www.notion.so/descope/Terraform-Demo-for-Descope-217397faca2a80d4b1d2d297cdbf5f45?source=copy_link).

1. Fork or clone this repository:

   ```bash
   git clone https://github.com/descope-cx/descope-terraform-demo.git
   cd descope-terraform-demo
   ```

2. **Important**: Before proceeding, ensure you have the flow JSON files in the `flows/` directory:

   - `flows/sign-up-or-in.json`
   - `flows/sign-in.json`
   - `flows/sign-up.json`

   These files should contain your current flow configurations. You can export them from your Descope Console or create them from scratch.

3. Add a `terraform.tfvars` file to your root directory, with your Project ID and Management Key to run these Terraform plans locally as well

   ```
   management_key = "<Descope Management Key>"
   project_id = "<Descope Project ID>"
   ```

4. Set up the following GitHub repository secrets and variables:

   **Secrets:**

   - `DESCOPE_MGMT_KEY`: Your Descope Management Key
   - `GH_PAT`: Your GitHub Personal Access Token

   **Variables:**

   - `STAGING_PROJECT_ID`: Your Descope Staging Project ID

5. To set up GitHub secrets and variables:
   - Go to your repository settings
   - Navigate to "Secrets and variables" → "Actions"
   - Add each secret and variable as listed above

## Workflow Options

### Option 1: Direct Terraform Deployment

Before running any Terraform commands, ensure you have:

1. All required flow JSON files in the `flows/` directory
2. Properly configured GitHub secrets and variables
3. Valid Descope Management Key and Project IDs

Then proceed with:

1. Initialize Terraform:

   ```bash
   terraform init
   ```

2. Review the planned changes:

   ```bash
   terraform plan
   ```

3. Apply the changes:
   ```bash
   terraform apply
   ```


### Option 2: Automated Flow Promotion

1. Add, commit, and push your applied changes with the new `.tfstate` file from your local repo to the GitHub repo before continuing. 
2. Make changes to your flows in the Descope Console for your staging project
3. Go to the "Actions" tab in your GitHub repository
4. Run the "Promote Flows from Staging" workflow manually
5. The workflow will:
   - Export flows from your staging project
   - Create a pull request with the changes
   - Once merged, automatically deploy to production

## Automated Deployment

The repository includes two GitHub Actions workflows:

1. `deploy-to-prod.yml`: Automatically deploys changes to production when merged to main
2. `replace-flow.yml`: Promotes flows from staging to production via pull request

## Modifying Terraform Configuration

The `main.tf` file contains the Terraform configuration for your Descope project. You can modify this file to:

- Add or remove connectors (HTTP, HIBP, Forter, SMTP, etc.)
- Change project settings
- Add additional flows
- Configure other Descope resources

To make changes:

1. Edit the `main.tf` file
2. Commit and push your changes to the main branch
3. The changes will be automatically deployed to production via the GitHub Actions workflow

Example of adding a new connector:

```hcl
connectors = {
  "http": [
    {
      name = "My Custom Connector"
      description = "Custom HTTP Connector"
      base_url = "https://api.example.com"
    }
  ]
}
```
