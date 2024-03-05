terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.38.0"
    }
  }

  required_version = ">= 1.2.0"
}

resource "aws_key_pair" "ssh_key" {
  key_name   = var.key
  public_key = file("${var.key}.pub")
}

resource "aws_launch_template" "ecs_launch_template" {
  name          = "lt-ecs-asg-aluraflix"
  image_id      = "ami-02ca28e7c7b8f8be1" # tem que ter suporte ao ecs TROCAR
  instance_type = "t2.micro"

  key_name               = var.key
  vpc_security_group_ids = [var.sg_allow_http, var.sg_default]
  iam_instance_profile {
    name = "ecsInstanceRole"
  }

  # block_device_mappings {
  #   device_name = "/dev/xvda"
  #   ebs {
  #     volume_size = 8
  #     volume_type = "gp3"
  #   }
  # }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "ecs-instance"
    }
  }

  user_data = filebase64("${path.module}/ecs.sh")
}

resource "aws_autoscaling_group" "ecs_asg" {
  name             = "infra-ecs-cluster-${var.name}"
  desired_capacity = 2
  max_size         = 3
  min_size         = 1

  launch_template {
    id      = aws_launch_template.ecs_launch_template.id
    version = "$Latest"
  }

  vpc_zone_identifier = [var.subnet1, var.subnet2]

  tag {
    key                 = "AmazonECSManaged"
    value               = true
    propagate_at_launch = true
  }
}

resource "aws_lb" "ecs_alb" {
  name               = "ecs-alb-${var.name}"
  internal           = false
  load_balancer_type = "application"

  security_groups = [var.sg_allow_http, var.sg_default]
  subnets         = [var.subnet1, var.subnet2]

  enable_deletion_protection = false

  tags = {
    Name = "ecs-alb-${var.name}"
  }

}

resource "aws_lb_target_group" "ecs_tg" {
  name        = "ecs-tg-${var.name}"
  port        = "80"
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = var.vpc_id

  health_check {
    path = "/"
  }
}

resource "aws_lb_listener" "ecs_alb_listener" {
  load_balancer_arn = aws_lb.ecs_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs_tg.arn
  }
}
