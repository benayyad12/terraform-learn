# terraform-learn

A concise, beginner-friendly reference for Terraform — what it is, basic workflow, common commands, configuration syntax, providers, and variable usage.

Table of contents
- [What is Terraform](#what-is-terraform)
- [Prerequisites](#prerequisites)
- [Quick start](#quick-start)
- [Terraform workflow](#terraform-workflow)
- [Common Terraform commands](#common-terraform-commands)
- [HCL syntax (basic)](#hcl-syntax-basic)
- [Examples](#examples)
  - [local_file resource example](#local_file-resource-example)
  - [random_pet example](#random_pet-example)
- [Variables](#variables)
  - [Variable types](#variable-types)
  - [Declaring variables](#declaring-variables)
  - [Providing variable values](#providing-variable-values)
  - [Precedence of variable sources](#precedence-of-variable-sources)
- [Providers](#providers)
- [Multiple providers & aliases (brief)](#multiple-providers--aliases-brief)
- [Tips & best practices](#tips--best-practices)
- [References](#references)

What is Terraform
------------------
Terraform is "infrastructure as code" (IaC). It lets you define and provision infrastructure using configuration files written in HashiCorp Configuration Language (HCL). Terraform is multi‑cloud and works with many providers (AWS, Azure, GCP, and many community/partner providers).

Prerequisites
-------------
- Install Terraform (see https://www.terraform.io/downloads).
- Have credentials configured for the cloud/provider(s) you will use (e.g., AWS CLI credentials, Azure CLI login, or service account for GCP).

Quick start
-----------
1. Create your .tf files (Terraform configuration).
2. Run terraform init to initialize and download provider plugins.
3. Run terraform plan to preview changes.
4. Run terraform apply to apply the changes (creates/modifies resources).
5. Run terraform destroy to remove resources when no longer needed.

Terraform workflow
------------------
- init: initialize a working directory, download providers and modules
- plan: preview the changes required to reach the desired state
- apply: apply the planned changes
- show: inspect state or plan output
- destroy: delete resources defined in configuration

Common Terraform commands
-------------------------
- terraform version               # display Terraform and provider versions
- terraform init                  # initialize a working directory
- terraform plan                  # preview changes
- terraform apply                 # apply changes
- terraform apply -var 'k=v'      # apply with inline variable
- terraform apply -var-file=x.tfvars  # apply with tfvars file
- terraform show                  # show details of resources/state
- terraform destroy               # destroy resources
- terraform fmt                   # format configuration files
- terraform validate              # validate configuration for syntax/consistency
- terraform state <subcommand>    # inspect or modify the state

HCL syntax (basic)
------------------
A Terraform file is made of blocks. Example resource block:

```hcl
resource "local_file" "pet" {
  filename = "/root/pets.txt"
  content  = "We love pets!"
}
```

General block pattern:
- block-type "resource-type" "name" { key = value ... }

Examples
--------

local_file resource example
```hcl
resource "local_file" "pet" {
  filename = "/root/pet.txt"
  content  = "I love pet!"
  # file_permission = "0700"  # optional
}
```

random_pet example (generates a random name)
```hcl
resource "random_pet" "my_pet" {
  length    = 1
  separator = "."
  prefix    = "Mr"
}
```

Variables
---------

Variable types
- string
- number
- bool
- list (list(string), list(number), ...)
- map (map(string), map(number), ...)
- set
- tuple
- object

Declaring variables
```hcl
variable "filename" {
  description = "Path to save the file"
  type        = string
  default     = "/root/pet.txt"   # optional
}
```

Example using variables in a resource:
```hcl
variable "filename" { default = "/root/pet.txt" }
variable "content"  { default = "I love pet!" }

resource "local_file" "pet" {
  filename = var.filename
  content  = var.content
}
```

Example with a list:
```hcl
variable "prefix" {
  type    = list(string)
  default = ["Mr", "Mrs", "Sir"]
}

resource "random_pet" "my_pet" {
  prefix = var.prefix[0]
}
```

How to use variables without default
- If a variable has no default, Terraform will prompt for its value during interactive runs.
- Other ways to provide values (from highest to lowest precedence below):
  - -var on the command line: terraform apply -var 'filename=/root/pet.txt'
  - -var-file: terraform apply -var-file="terraform.tfvars"
  - Environment variable: export TF_VAR_filename="/root/pet.txt"
  - Default value in variable declaration (lowest precedence)

Precedence of variable sources
1. -var on command line
2. -var-file
3. Environment variables (TF_VAR_*)
4. Default in variable declaration

Providers
---------
Providers are the plugins that Terraform uses to manage resources. Examples:
- Official: aws, azurerm, google
- Partner: F5 (BigIP), DigitalOcean (partner/community may vary)
- Community: various community-contributed providers

Provider reference example (local provider):
registry.terraform.io/hashicorp/local

Multiple providers & aliases (brief)
- You can configure multiple provider instances (for example: multiple AWS accounts or regions) and use provider aliases.
- Example:
```hcl
provider "aws" {
  region = "us-east-1"
}

provider "aws" {
  alias  = "eu"
  region = "eu-west-1"
}

resource "aws_s3_bucket" "b1" {
  provider = aws
  bucket   = "my-bucket-us"
}
```

Tips & best practices
- Keep secrets out of .tf files. Use environment variables, secret managers, or encrypted storage.
- Use terraform fmt and terraform validate to keep configs neat and correct.
- Store state remotely (e.g., Terraform Cloud, S3 with locking) for team collaboration.
- Break large configurations into modules.
- Use version constraints on providers and Terraform to avoid unexpected upgrades.

References
- https://www.terraform.io/docs
- Terraform registry: https://registry.terraform.io
