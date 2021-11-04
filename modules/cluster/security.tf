#Create security groups for my ELB
resource "aws_security_group" "alb" {
    name = "${var.env}-sg-to-elb"
    vpc_id = aws_vpc.kharkov.id
    ingress {
      from_port = var.app_port
      to_port = var.app_port
      protocol = "tcp"
      cidr_blocks = [var.destination]
    }
    egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = [var.destination]
    }
}
resource "aws_security_group" "ecs_ag" {
    name = "${var.env}-ag"
    vpc_id = aws_vpc.kharkov.id
    ingress {
      from_port = var.app_port
      to_port = var.app_port
      protocol = "tcp"
      cidr_blocks = [var.destination]
    }
    egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = [var.destination]
    }
}
