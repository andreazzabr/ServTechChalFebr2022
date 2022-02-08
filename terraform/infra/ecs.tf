resource "aws_ecs_cluster" "ecscluster" {
  name = "${var.projectname}-cluster"
  capacity_providers = ["FARGATE"]
}
resource "aws_security_group" "ecssg" {
    name = "${var.projectname}-ecssg"
    vpc_id = aws_vpc.main.id
    lifecycle {
        create_before_destroy = true
    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = [aws_vpc.main.cidr_block]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
}
resource "aws_iam_role" "ecs_role" {
    name = "${var.projectname}-ecsrole"
    assume_role_policy = <<-EOF
    {
        "Version": "2008-10-17",
        "Statement": [
            {
                "Action": "sts:AssumeRole",
                "Principal": {
                    "Service": "ecs-tasks.amazonaws.com"
                },
                "Effect": "Allow",
                "Sid": ""
            }
        ]
    }
    EOF
}
resource "aws_iam_role_policy_attachment" "ecs_role_policy_attachment" {
  role      = aws_iam_role.ecs_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
resource "aws_iam_role_policy_attachment" "ecs_role_policy_attachment_ssm" {
  role     = aws_iam_role.ecs_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMReadOnlyAccess"
}
resource "aws_iam_role_policy_attachment" "ecs_role_policy_attachment_rdsaccess" {
  role     = aws_iam_role.ecs_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonRDSDataFullAccess"
}
resource "aws_iam_role_policy_attachment" "ecs_role_policy_attachment_secret" {
  role     = aws_iam_role.ecs_role.name
  policy_arn = aws_iam_policy.secretread.arn
}
resource "aws_iam_policy" "secretread" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "kms:Decrypt",
        "secretsmanager:GetSecretValue",
        "secretsmanager:ListSecrets",
        "secretsmanager:DescribeSecret"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}