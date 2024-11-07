/*
resource "aws_lb_target_group" "demo_tg" {
  health_check {
    interval = 5
    healthy_threshold = 3
    path = "/"
    protocol = "HTTP"
    timeout = 3
    unhealthy_threshold = 3
  }
  name     = "demo-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpcid
}

resource "aws_lb" "demo-aws-lb" {
  name               = "demo-app-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_grp_id[*]
  subnets = var.subnetid[*]
  enable_deletion_protection = false  // we want to delete it from terraform, true will disable deletion of LB through terraform

  tags = {
    Environment = "test-LB-dev"
  }
}

resource "aws_lb_listener" "demo_lb_listener" {
  load_balancer_arn = aws_lb.demo-aws-lb.arn
  port              = "3000"
  protocol          = "HTTP"
  //ssl_policy        = "ELBSecurityPolicy-2016-08"
  //certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.demo_tg.arn
  }
}
/*
resource "aws_lb_target_group_attachment" "demo-tg-attachment" {
  target_group_arn = aws_lb_target_group.demo_tg.arn
  count            = var.instance_count
  target_id        = "${var.instance_id[1]}"
  #target_id       =  "${element(var.instance_id , count.index)}"
  port             = 80
}

*/


