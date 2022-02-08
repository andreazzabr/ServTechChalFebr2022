variable "albtg" {
    type = string
    default = ""
}
variable "containerimage" {type=string}
variable "dbhost" {
    type = string
    default = ""
}
variable "dbname" {type = string}
variable "dbpassword" {
    type = string
    default = ""
}
variable "dbusername" {type = string}
variable "ecscluster" {
    type = string
    default = ""
}
variable "ecsrole" {
    type = string
    default = ""
}
variable "ecsservicedesiredcount" {type=string}
variable "ecssg" {
    type = string
    default = ""
}
variable "ecssubnets" {type=list(any)}
variable "projectname" {type = string}
variable "taskdefinitioncpu" {type=string}
variable "taskdefinitionmem" {type=string}
variable "tasktemplate" {
    type=string
    default ="cdserve.json"
}
variable "vpccidr" {type = string}
variable "vpcid" {type = string}