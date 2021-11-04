#Crate ecs
resource "aws_ecs_cluster" "appb" {
    name = "${var.env}-${var.owner}-cluster"
}
resource "aws_ecs_task_definition" "app" {
    name = "${var.env}-task-definition"
    execution_role_arn = &
    task_role_arn = &
    container_definitions =
    network_mode = "awsvpc"
    requires_compatibilities = ["FARGATE"]
}
resource "aws_ecs_service" "forapp" {
    name = "${var.env}-service"
    cluster = aws_ecs_cluster.appb.id
    task_definition = aws_ecs_task_definition.app.arn
    desired_count = 2
    launch_type = "FARGATE"
    network_configuration {
      security_groups = [aws_security_group.ecs_ag.id]
      subnets = aws_subnet.privatesubnetA.*.id
      assign_public_ip = true
    }
    load_balancer{
      target_group_arn = aws_alb_target_group.ecs.id
      container_name = "${var.env}-app"
      container_port = var.app_port
    }
}
