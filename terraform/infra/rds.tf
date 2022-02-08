resource "aws_db_instance" "rdsinst" {
    identifier = "${var.projectname}-rdsinstance"
    allocated_storage = 20
    instance_class = var.instanceclass
    engine = var.dbengine
    engine_version = var.dbengineversion
    db_subnet_group_name = aws_db_subnet_group.dbsubnetgroup.name
    vpc_security_group_ids = [aws_security_group.rdssg.id]
    name = var.dbname
    username = var.dbusername
    password = aws_ssm_parameter.dbpassword.value
    skip_final_snapshot = var.skipfinalsnapshot
    storage_encrypted = var.storageencrypted
    apply_immediately = var.dbchangeapplyimmediately
    backup_retention_period = 0
}
resource "aws_db_subnet_group" "dbsubnetgroup" {
    name = "${var.projectname}-dbsubnetgroup"
    subnet_ids = aws_subnet.private-subs[*].id
}
resource "aws_security_group" "rdssg" {
    name = "${var.projectname}-rdssg"
    vpc_id = aws_vpc.main.id
    lifecycle {
        create_before_destroy = true
    }
    ingress {
        from_port = 5432
        to_port = 5432
        protocol = "tcp"
        cidr_blocks = [aws_vpc.main.cidr_block]
    }
    egress {
        description = "out"
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = [aws_vpc.main.cidr_block]
    }
}
resource "aws_ssm_parameter" "dbhost" {
    name = "${var.projectname}-dbhost"
    description = "db host"
    type = "String"
    value = aws_db_instance.rdsinst.address
}
resource "aws_ssm_parameter" "dbname" {
    name = "${var.projectname}-dbname"
    description = "db name"
    type = "String"
    value = var.dbname
}
resource "aws_ssm_parameter" "dbuser" {
    name = "${var.projectname}-dbuser"
    description = "db user"
    type = "String"
    value = var.dbusername
}
resource "aws_ssm_parameter" "dbpassword" {
    name = "${var.projectname}-dbpassword"
    description = "db password"
    type = "SecureString"
    value = random_password.password.result
}
resource "random_password" "password" {
    length = 16
    special = true
    override_special = "#%^"
}