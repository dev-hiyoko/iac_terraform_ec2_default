# ====================================================
# ALB
# ====================================================
resource "aws_lb" "alb" {
  name               = "${var.project}-${var.environment}-app-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.web_sg.id]
  subnets = [
    module.vpc_main.public_subnet_ids_by_az[var.availability_zone["a"]],
    module.vpc_main.public_subnet_ids_by_az[var.availability_zone["c"]]
  ]

  tags = {
    Name    = "${var.project}-${var.environment}-app-alb"
    Project = var.project
    Env     = var.environment
  }
}

# TODO 証明書設定後、httpsに修正する
resource "aws_lb_listener" "alb_listener_http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_target_group.arn
  }
}

# ====================================================
# Target Group
# ====================================================
resource "aws_lb_target_group" "alb_target_group" {
  name     = "${var.project}-${var.environment}-app-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.vpc_main.id

  tags = {
    Name    = "${var.project}-${var.environment}-app-tg"
    Project = var.project
    Env     = var.environment
  }
}

resource "aws_lb_target_group_attachment" "instance" {
  target_group_arn = aws_lb_target_group.alb_target_group.arn
  target_id        = aws_instance.app.id
}

