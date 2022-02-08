variable "albtg" {
    type = string
    default = ""
}
variable "containerimage" {type=string}
variable "dbchangeapplyimmediately" {type = bool}
variable "dbengine" {type = string}
variable "dbengineversion" {type = string}
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
variable "dnshosts" {type = bool}
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
variable "ecssubnets" {
    type=list(any)
    default = [""]
}
variable "instanceclass" {type = string}
variable "publicsubnets" { 
    type = list(object({
        name = string
        cidr = string
        az = string
        publicip = bool
    }))
}
variable "privatesubnets" { 
    type = list(object({
        name = string
        cidr = string
        az = string
        publicip = bool
    }))
}
variable "projectname" {type = string}
variable "recoverywindow" {type=string}
variable "region" {type = string}
variable "skipfinalsnapshot" {type = bool}
variable "storageencrypted" {type = bool}
variable "taskdefinitioncpu" {type=string}
variable "taskdefinitionmem" {type=string}
variable "tasktemplate" {
    type=string
    default ="cdserve.json"
}
variable "vpccidr" {type = string}