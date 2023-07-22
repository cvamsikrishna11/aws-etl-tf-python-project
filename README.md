# AWS Serverless ETL POC

Repo to create the infra for ETL process. This repo have the code to read dataset from S3, crawl the schema onto Glue data catalog, transform it via Glue Python Job and finally store it on to the DynamoDB.

This repository contains a Terraform configuration for deploying AWS resources. 

The Terraform configuration creates S3, IAM roles, Glue related resources.

The infrastructure is created in the `us-west-1` AWS region.

## Prerequisites

- Terraform (latest)
- AWS Account
- AWS CLI

## Getting Started

1. Clone the repository:

    ```shell
    git clone https://github.com/cvamsikrishna11/aws-etl-tf-python-project.git
    cd aws-etl-tf-python-project
    ```

2. Initialize Terraform:

    ```shell
    terraform init
    ```

3. Create a plan and apply:

    ```shell
    terraform plan
    terraform apply
    ```

## Once the infra is created 
1. Run AWS Glue crawler to create schema table
2. Run Glue job for the ETL


## Destroying Infrastructure

When you're done with the infrastructure, you can destroy it by running:

```shell
terraform destroy
```
Note: If s3 bucket creation is talking more time than its becuase I might have tried that bucket name while testing, increase the project_name=netflix (in locals.tf) to next version (example netflixv1).

Happy learning 🤗