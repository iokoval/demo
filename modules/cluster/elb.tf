#create ellastic load balancer

resource "aws_alb" "forecs" {
    name = "alb-for-ecs"
    security_groups = [aws_security_group.alb.id]
    subnets = aws_subnet.publicsubnetA.*.id
    internal = false
    tags={
      Name = "${var.env}-alb"
      Owner = "${var.owner}"
    }
}
resource "aws_alb_target_group" "ecs" {
    name = "tf-target-for-ecs"
    target_type = "ip"
    port = var.app_port
    protocol = var.app_protocol
    vpc_id = aws_vpc.kharkov.id
    health_check {
      healthy_threshold = 2
      unhealthy_threshold = 2
      timeout = 5
      path = "/"
      interval = 10
    }
}

resource "aws_alb_listener" "forapp" {
  load_balancer_arn = aws_alb.forecs.id
  port = var.app_port
  protocol = var.app_protocol
  default_action{
    type = "forward"
    target_group_arn = aws_alb_target_group.ecs.id
  }
}
