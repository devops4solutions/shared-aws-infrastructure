resource "aws_lb" "public_alb" {
  name                       = "${var.environment}-alb"
  internal                   = false
  load_balancer_type         = "application"
  subnets                    = data.aws_subnets.selected.ids
  enable_deletion_protection = false
  security_groups            = [aws_security_group.alb.id, aws_security_group.alb-internal.id]
}


resource "aws_security_group" "alb" {
  name   = "external-sg-alb"
  vpc_id = var.vpc_id

  dynamic "ingress" {
    for_each = var.allow_ip
    iterator = cidr
    content {
      protocol    = "tcp"
      from_port   = 80
      to_port     = 80
      cidr_blocks = [var.allow_ip[cidr.key]]
    }
  }

  dynamic "ingress" {
    for_each = var.allow_ip
    iterator = cidr
    content {
      protocol    = "tcp"
      from_port   = 443
      to_port     = 443
      cidr_blocks = [var.allow_ip[cidr.key]]
    }
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "alb-internal" {
  name   = "internal-sg-alb"
  vpc_id = var.vpc_id

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    self        = "false"
    cidr_blocks = [data.aws_vpc.vpcid.cidr_block]


  }

  ingress {
    protocol  = "tcp"
    from_port = 443
    to_port   = 443
    self      = "false"

    cidr_blocks = [data.aws_vpc.vpcid.cidr_block]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "aws_vpc" "vpcid" {
  id = var.vpc_id
}



resource "aws_lb_listener" "lb_listener_redirect" {
  load_balancer_arn = aws_lb.public_alb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "Fixed response content"
      status_code  = "200"
    }
  }
}
