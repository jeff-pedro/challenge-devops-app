resource "aws_autoscaling_group" "ecs_asg" {
  name             = "infra-ecs-cluster-aluraflix"
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
