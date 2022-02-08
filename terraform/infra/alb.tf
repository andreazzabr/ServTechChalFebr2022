resource "aws_lb" "alb" {
  name               = "${var.projectname}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.albsg.id]
  subnets            = aws_subnet.public-subs[*].id
  tags = {
    Project = "Servian TechChallenge"
  }
}
resource "aws_lb_listener" "alblistener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.albtg.arn
  }
}
resource "aws_lb_target_group" "albtg" {
  name        = "${var.projectname}-albtg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.main.id
}
resource "aws_security_group" "albsg" {
    name = "${var.projectname}-albsg"
    vpc_id = aws_vpc.main.id
    lifecycle {
        create_before_destroy = true
    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
}
