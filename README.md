# Servian Tech Challenge February 2022

The objective of this repository is to provide a solution to this [Tech Challenge](https://github.com/servian/TechChallengeApp), please visit the page to get a deeper view of architecture.

### Technology choices  

#### AWS  
As largest cloud provider, it has great documentation, all services needed for the solution, so it was the preferred choice.

#### Amazon Elastic Container Service (ECS)  
ECS was chosen for container management, using Fargate as it's a serverless compute engine.

#### Amazon Elastic Load Balancing (ALB)
ALB provides application high availability and auto-scaling. Incoming traffic is distributed to target group.

#### Amazon Relational Database Service (RDS)  
A single DB instance was used for this solution, to keep low costs, in a production environment I'd recommend using RDS Cluster for high availability and reliability.

#### Amazon Simple Storage Service (S3)
A single bucket was necessary to store the Terraform state file.

#### AWS Identity and Access Management (IAM)
IAM Roles were necessary to give ECS Task access to Parameter Store and RDS Database.

#### AWS Systems Manager - Parameter Store  
It was used to store connection strings to database, cheaper than Secrets Manager (which would be better for production environment, with secrets rotation enabled).  

#### Amazon Security Groups
Security groups were created to control inbound and outbound traffic, either public and private.  

#### Amazon Virtual Private Cloud (VPC)
VPC and subnets (public and private) were created to allow resource deployment.

#### GitHub and GitHub Actions
For code management and pipeline automation.

#### Terraform
It was the chosen tool for Infrastructure as Code (IaC) to manage resource provisioning.  

#### 3Musketeers approach:
- [Makefile](Makefile) to automate the scripts.  
- [Docker](https://docker.io) to download container images with all requisites to perform 'make' commands.  
- [Docker Compose](docker-compose.yml) to run everything without installing a lot of dependencies.  

<br>

### Prerequisites  

You need to have an AWS Account with [programmatic access](https://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html#access-keys-and-secret-access-keys) and a GitHub account with [Personal Access Token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token) with **Workflow permission**.  
For the pipeline to run without issues, first you need to setup some [secrets](https://docs.github.com/en/actions/security-guides/encrypted-secrets) in your GitHub repository:  

**AWS_ACCESS_KEY_ID**: for pipeline programmatic access  
**AWS_SECRET_ACCESS_KEY**: for pipeline programmatic access  
**TF_BACKEND_BUCKET**: S3 bucket name where you want to keep your Terraform State key.  
**TF_BACKEND_KEY**: 'File' that will be created automatically containing your Terraform State.  
**WORKFLOW_TOKEN**: GitHub Personal Access Token (PAT) with workflow permissions.   

*That's all you need to make it work.  
<br>

### How to Run  

1- Clone this repository on your computer  

2- Setup all the prerequisites  

3- Open file ".github/workflows/main.yml", you will notice there are 3 important variables:
- UPDATE_DB : when *True* this variable will make the pipeline to create/refresh the database (Necessary during first run).  
- DESTROY : when *True* this variable will destroy the whole stack created by this pipeline.  
- RUN_PIPELINE : when *True* makes the pipeline to run, if you leave as *False*, any update you make in terraform or any other file will not trigger the pipeline.  
Change to *True* depending on what you want to do.  

4- Push everything to your repository.  

5- Go your repository "Actions" and see the pipeline run.  
The following steps will happen there:

- **TF Plan Infra**  
This step will run terraform plan and save the file in GitHub.

- **TF Apply Infra**  
This step will grab the plan file from last step and create the basic infrastructure.

- **Preparing Database**  
When 'update_db' is set to True, the first time it populates the database with data, or subsequentially it will refresh the data.

- **Serving APP**  
This step will deploy the application into ECS Cluster and show the Load Balancer http address so you can access it via browser.

- **Destroy Infra**  
When 'destroy' var is set to True, it will destroy all resources created by the pipeline.

- **Update Variables**  
This step will set the variables 'update_db','destroy' and 'run_pipeline' to *False* in main.yml file.  
You will notice the pipeline will run again (as this file has been changed) but as 'run_pipeline' is *False* nothing will actually happen.