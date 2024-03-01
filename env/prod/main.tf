module "Prod" {
  source = "../../infra"

  name          = "aluraflix"
  image_name    = "aluraflix-api"
  image_version = "latest"
  vpc_cidr      = "10.0.0.0/16"
  key           = "ecs-prod"
}