resource "aws_elb" "as_ui_elb" {
    name = "web-elb"
    subnets = ["${compact(split(",",var.external_subnets))}"]
    security_groups = ["${aws_security_group.elb_sg.id}"]

    listener {
      lb_port = 80
      instance_port = 80
      lb_protocol = "http"
      instance_protocol = "http"
    }

    // TODO add changes for 443
    health_check {
      healthy_threshold = 2
      unhealthy_threshold = 2
      timeout = 15
      target = "HTTP:80/"
      interval = 30
    }
    cross_zone_load_balancing = true
    idle_timeout = 400
    connection_draining = true
    connection_draining_timeout = 400

    tags {
      Name = "web_wlb"
      deployment = "bbl"
    }
}
resource "aws_autoscaling_attachment" "proxy_asg" {
  autoscaling_group_name = "${aws_autoscaling_group.as_autoscaling.id}"
  elb                    = "${aws_elb.as_ui_elb.id}"
}
