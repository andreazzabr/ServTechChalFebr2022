# Servian Tech Challenge February 2022

The objective of this repository is to provide the code to this [Tech Challenge](https://github.com/servian/TechChallengeApp)
- I have used [Terraform](https://www.terraform.io/) to create the resources in AWS.
- [Makefile](Makefile) to automate the scripts.
- [Docker] to create the container image. Although it's not necessary to complete the Challenge in normal circunstances.


### Prerequisites
Terraform v0.13 must be installed and configured (logged in on your AWS account) to run the scripts.
AWS Cli is also necessary to grab the Loab Balancer DNS at the end (otherwhise you have to use AWS Portal to grab the DNS address).
I also assume you have a GitHub account and a token (with permissions to read repositories), you need to add them in the [main.tfvars](./terraform/main.tfvars) file.


### How to Run
Run below to prepare the infra. 
```
make prep_infra
```

Run below to prepare the database with info.
```
make prep_db
```

Run below to start serving the container to load balancer (this commando can also be used to pull a new container image from repo).
```
make serve
```

If you want everything done for you, please run:
```
make create_everything
```

If you forgot to grab the load balancer address, please run:
```
make dnsname
```

Run below to destroy everything. Also de DB, be careful! :)
```
make destroy_everything
```
