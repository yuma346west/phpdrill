module "ecs" {
  source = "../modules/ecs"

  app_name = "${var.project_name}-ecs"

  network_mode = "awcvpc"

  container_name = "myphp"

  container_definitions = file("resources/container_definitions.json")
  execution_role_arn    = var.execution_role_arn

  // Networking and Compatibility
  subnets            = var.subnets
  security_groups    = var.security_groups
  assign_public_ip   = true

  // Resource Allocation
  cpu    = "256"
  memory = "512"

  // Service Configuration
  desired_count       = 2
  launch_type         = "FARGATE"
  target_group_arn    = var.target_group_arn
  container_port      = 8080
}