output "vpcid" {
    value = aws_vpc.main.id
}
output "publicsubnetids" {
    value = aws_subnet.public-subs[*].id
}
output "dbhost" {
    value = aws_ssm_parameter.dbhost.value
}
output "dbpassword" {
    value = aws_ssm_parameter.dbpassword.value
    sensitive   = true
}
output "ecscluster" {
    value = aws_ecs_cluster.ecscluster.id
}
output "ecssg" {
    value = aws_security_group.ecssg.id
}
output "ecsrole" {
    value = aws_iam_role.ecs_role.arn
}
output "albtg" {
    value = aws_lb_target_group.albtg.arn
}
