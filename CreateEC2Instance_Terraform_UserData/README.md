# CreateEC2Instance_Terraform_UserData
# EC2 Instance Provisioning with Terraform

This Terraform configuration provisions an EC2 instance on AWS with additional setup and file transfer using user data.

## Overview

The Terraform configuration in this repository sets up:

- An EC2 instance with specified AMI, instance type, security groups, and user data script.
- User data script installs Apache, .NET Core 6.0, creates directories, sets up services, and transfers files from a local directory to the EC2 instance.
- Utilizes the AWS CLI and SCP to handle file transfers and instance setup.

## Prerequisites

- AWS CLI configured with appropriate access and permissions.
- Terraform installed locally.

## Usage

1. Clone this repository:

   ```bash
   git clone https://github.com/your-username/your-repo.git
   cd your-repo
# Initialize Terraform:
terraform init
# Review and apply the Terraform configuration:

terraform plan

terraform apply

Access your EC2 instance and verify the setup.

# Customization
Modify the userdata.sh script to suit your specific setup requirements.
Adjust the paths and commands in the Terraform files to reflect your configurations.
Customize security groups, instance types, and other parameters as needed in the Terraform configuration files.

# Cleanup
To avoid incurring charges, destroy the created resources when they are no longer needed:

terraform destroy


