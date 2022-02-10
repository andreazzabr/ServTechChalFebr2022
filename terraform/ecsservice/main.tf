resource "aws_ecs_service" "ecs-service" {
  name = "${var.projectname}-ecs-service"
  cluster = var.ecscluster
  task_definition = aws_ecs_task_definition.goltask.arn
  desired_count = var.ecsservicedesiredcount
  force_new_deployment = true
  launch_type = "FARGATE"
  network_configuration {
    subnets = var.ecssubnets
    security_groups = [var.ecssg]
    assign_public_ip = true
  }
  load_balancer {
    target_group_arn = var.albtg
    container_name   = "gol-srvn"
    container_port   = 80
  }
}
resource "aws_ecs_task_definition" "goltask" {
  family = "${var.projectname}-goltask"
  container_definitions = data.template_file.containerdata.rendered
  requires_compatibilities = ["FARGATE"]
  network_mode = "awsvpc"
  cpu = var.taskdefinitioncpu
  memory = var.taskdefinitionmem
  task_role_arn = var.ecsrole
  execution_role_arn = var.ecsrole
}
data "template_file" "containerdata" {
  template = file("${path.module}/${var.tasktemplate}")
  vars = {
    dbhost = var.dbhost
    dbname = var.dbname
    dbusername = var.dbusername
    dbpassword = var.dbpassword
    containerimage = var.containerimage
  }
}