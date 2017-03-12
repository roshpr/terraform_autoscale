output "web_autoscale_id" {
  value = "${aws_autoscaling_group.as_autoscaling.arn}"
}
output "autoscale_sg_name" {
  value = "${aws_security_group.as_sg.name}"
}
output "elb_sg_name" {
  value = "${aws_security_group.elb_sg.name}"
}
output "elb_name" {
  value = "${aws_elb.as_ui_elb.name}"
}