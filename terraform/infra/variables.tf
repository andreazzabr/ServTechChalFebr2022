variable "dbchangeapplyimmediately" {type = bool}
variable "dbengine" {type = string}
variable "dbengineversion" {type = string}
variable "dbname" {type = string}
variable "dbusername" {type = string}
variable "dnshosts" {type = bool}
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
variable "vpccidr" {type = string}
