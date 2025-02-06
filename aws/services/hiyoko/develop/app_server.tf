# ====================================================
# EC2 keypair
# ====================================================
# ローカルでキーペアを作成
# ssh-keygen [-t 鍵の種類] [-b 鍵のビット数(2048以上が推奨)] [-f 鍵のファイル名]
# ssh-keygen -t rsa -b 2048 -f hiyoko-dev-keypair
resource "aws_key_pair" "keypair" {
  key_name   = "${var.project}-${var.environment}-keypair"
  public_key = file(var.keypair_path)

  tags = {
    Name    = "${var.project}-${var.environment}-keypair"
    Project = var.project
    Env     = var.environment
  }
}

# ====================================================
# Launch template
# ====================================================
resource "aws_launch_template" "app" {
  name          = "${var.project}-${var.environment}-app-launch-template"
  image_id      = data.aws_ami.app.id
  instance_type = var.ec2_instance_type
  key_name      = aws_key_pair.keypair.key_name

  iam_instance_profile {
    name = aws_iam_instance_profile.app_ec2_profile.name
  }

  network_interfaces {
    associate_public_ip_address = true
    security_groups = [
      aws_security_group.app_sg.id,
      aws_security_group.opmng_sg.id
    ]
    delete_on_termination = true
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name    = "${var.project}-${var.environment}-app-ec2"
      Project = var.project
      Env     = var.environment
      Type    = "app"
    }
  }

  # user_data = filebase64("./init.sh")
}

# ====================================================
# Autoscaling Group
# ====================================================
resource "aws_autoscaling_group" "app_asg" {
  name                      = "${var.project}-${var.environment}-app-asg"
  max_size                  = 2
  min_size                  = 2
  desired_capacity          = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"

  vpc_zone_identifier = [
    module.vpc_main.public_subnet_ids_by_az[var.availability_zone["a"]],
    module.vpc_main.public_subnet_ids_by_az[var.availability_zone["c"]]
  ]

  target_group_arns = [
    aws_lb_target_group.alb_target_group.arn
  ]

  launch_template {
    id      = aws_launch_template.app.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "${var.project}-${var.environment}-app-asg"
    propagate_at_launch = true
  }
}
