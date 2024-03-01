resource "aws_key_pair" "ssh_key" {
  key_name   = var.key
  public_key = file("${var.key}.pub")
}

resource "aws_launch_template" "launch_template" {
  depends_on = [
    aws_security_group.security_group,
    aws_key_pair.ssh_key
  ]

  name          = "lt-ecs-asg-aluraflix"
  image_id      = "ami-02ca28e7c7b8f8be1"
  instance_type = "t2.micro"

  key_name               = var.key
  vpc_security_group_ids = [aws_security_group.security_group.id]
  iam_instance_profile {
    name = "ecsInstanceRole"
  }

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 8
      volume_type = "gp3"
    }
  }

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
    id      = aws_launch_template.launch_template.id
    version = "$Latest"
  }

  vpc_zone_identifier = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]

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
  security_groups    = [aws_security_group.security_group.id]
  subnets            = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]

  enable_deletion_protection = false

  tags = {
    Name = "ecs-alb-${var.name}"
  }
}

resource "aws_lb_target_group" "ecs_tg" {
  name        = "ecs-tg-${var.name}"
  port        = "80"
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.main.id

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

