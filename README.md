#NTI DevOps Final Project README
Overview

This project demonstrates a comprehensive DevOps pipeline utilizing various technologies including Terraform, Ansible, Docker, Kubernetes, and Jenkins. The goal is to automate the setup, deployment, and management of a web application with a focus on scalability, reliability, and security.
Table of Contents

    Terraform
    Ansible
    Docker
    Kubernetes
    Jenkins

Terraform

Terraform is used to provision the necessary AWS infrastructure. The tasks include:

    EKS Cluster: Create an EKS (Elastic Kubernetes Service) cluster consisting of two nodes with an auto-scaling group and an Elastic Load Balancer (ELB).
    RDS Instance: Create an RDS (Relational Database Service) instance and store the username and password in AWS Secrets Manager.
    EC2 Instance: Provision an EC2 instance for running Jenkins.
    Backup: Make daily snapshots of the Jenkins instance using AWS Backup service.
    Logging: Save ELB access logs to an AWS S3 bucket.
    ECR: Create an AWS ECR (Elastic Container Registry).

Ansible

Ansible is used for configuration management and application deployment on EC2 instances:

    Jenkins Installation: Install Jenkins, including configuration and plugin installations.
    CloudWatch Agent: Install the CloudWatch agent on all EC2 instances in the project for monitoring.

Docker

Docker is used to containerize the application:

    Docker Images: Create Docker images for the application code.
    Docker Compose: Create a Docker Compose file to run the application locally for development and testing.

Kubernetes

Kubernetes manages the deployment, scaling, and operations of application containers across clusters of hosts:

    Manifests: Create Kubernetes manifests to deploy the application on the AWS EKS cluster.
    Network Policy: Implement network policies to ensure security best practices between pods.

Jenkins

Jenkins is used to automate the CI/CD pipeline:

    Multi-Branch Pipeline: Create a multi-branch pipeline to trigger builds on every push to all GitHub branches.
    Pipeline Stages:
        Build Docker Image: Build the Dockerfile in the repository.
        Push to ECR: Push the Docker image to AWS ECR.
        Deploy to Kubernetes: Deploy the new image to Kubernetes pods.

Getting Started
Prerequisites

    AWS Account
    Terraform installed
    Ansible installed
    Docker installed
    Kubernetes CLI installed
    Jenkins installed

Setup

    Terraform:
        Initialize Terraform configuration.
        Apply the Terraform configuration to provision the AWS infrastructure.

    Ansible:
        Run the Ansible playbook to configure Jenkins and install the CloudWatch agent.

    Docker:
        Build Docker images for the application.
        Use Docker Compose to run the application locally.

    Kubernetes:
        Apply Kubernetes manifests to the EKS cluster.

    Jenkins:
        Set up Jenkins multi-branch pipeline.
        Configure the pipeline stages to build, push, and deploy the application.

Usage

After setting up the infrastructure and configuring the necessary components, the CI/CD pipeline will automatically handle new code changes:

    Push changes to the GitHub repository.
    Jenkins will trigger the pipeline.
    The Docker image will be built and pushed to ECR.
    The new image will be deployed to the Kubernetes pods in the EKS cluster.

Contributing

Contributions are welcome! Please fork the repository and submit a pull request.
License

This project is licensed under the MIT License. See the LICENSE file for details.
