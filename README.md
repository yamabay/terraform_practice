# terraform_practice
This is an example deployment project for AWS using Terraform.  It focuses on deploying various network resources including:
- VPCs
- Public and Private Subnets
- Custom Security Groups
- Custom Route Tables
- EC2 Creation
- NAT Gateways
- Internet Gateways

As seen below, there is a diagram showing the high-level overview of the deployment.
It will create mirrored resources across two different regions.  The regions, CIDRs, subnets, AMIs, etc can all be modified through the **variables.tf** file without needing to change hardcoded values throughout the rest of the project.
The overall goal of the project was to simply practice deploying AWS network resources using Terraform.  However, there was also a focus on making the project as portable as possible to help others easily use it for their own practice/reference.

Always open to suggestions to improve the code and any new additions to the project for extra challenge!



![aws-terraform drawio](https://user-images.githubusercontent.com/107229102/188531311-93e1dc1b-554e-4fd9-8fe7-98be3b590000.png)

