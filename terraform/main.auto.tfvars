####################
#variables for Infra
####################

projectname = "srvntchall"
region = "ap-southeast-2"
vpccidr = "10.0.0.0/16"
publicsubnets = [
  {
    name = "public-a"
    cidr = "10.0.10.0/24"
    az   = "ap-southeast-2a"
    publicip = true
  },
  {
    name = "public-b"
    cidr = "10.0.11.0/24"
    az   = "ap-southeast-2b"
    publicip = true
  }
]
privatesubnets = [
  {
    name = "private-a"
    cidr = "10.0.20.0/24"
    az = "ap-southeast-2a"
    publicip = false
  },
  {
    name = "private-b"
    cidr = "10.0.21.0/24"
    az = "ap-southeast-2b"
    publicip = false
  }
]
dbchangeapplyimmediately = true
dbengine = "postgres"
dbengineversion = "10.7"
dbname = "app"
dbusername = "postgres"
dnshosts = true
instanceclass = "db.t2.micro"
skipfinalsnapshot = true
storageencrypted = false

##########################
#variables for ECS Service
##########################
containerimage = "servian/techchallengeapp:latest"
ecsservicedesiredcount = "2"
recoverywindow = "0"
taskdefinitioncpu = "256"
taskdefinitionmem = "512"
