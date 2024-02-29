module "Dev" {
  source = "../../infra"

  name     = "aluraflix"
  vpc_cidr = "10.0.0.0/16"
  key      = "ecs-dev"
}
