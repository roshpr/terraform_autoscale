

data "template_file" "user_data" {
  template = "${file("${var.root_path}/../template/bootstrap.sh.tpl")}"
}

resource "aws_launch_configuration" "web_launch_config" {
  name = "web-launch-config"
  image_id = "${var.ami}"
  instance_type = "${var.instance_cfg["proxy.type"]}"
  security_groups = ["${aws_security_group.as_sg.id}"]
  associate_public_ip_address = false
  ebs_optimized = false
  key_name = "${var.ec2_instance_key}"
  #iam_instance_profile = "${aws_iam_instance_profile.proxy_iam_profile.id}"
  user_data = "${data.template_file.user_data.rendered}"

  lifecycle {
    create_before_destroy = true
  }
  root_block_device {
    volume_size = "${var.instance_cfg["proxy.volume.0"]}"
    delete_on_termination = true
    volume_type = "standard"
    #snapshot_id = "s23423989"
  }
  ebs_block_device {
    device_name = "/dev/sdg"
    volume_size = "${var.instance_cfg["proxy.datavolume.0"]}"
    encrypted = true
    delete_on_termination = true
    volume_type = "standard"
    #snapshot_id = "s23423989"
  }
}

resource "aws_autoscaling_group" "as_autoscaling" {
  name = "web-autoscale"
  availability_zones = ["${split(",", var.vpcvar["availability_zones"])}"]
  vpc_zone_identifier = ["${split(",", var.internal_subnets)}"]
  max_size = "${var.instance_cfg["proxy.maxcount"]}"
  min_size = "${var.instance_cfg["proxy.mincount"]}"
  desired_capacity = "${var.instance_cfg["proxy.mincount"]}"
  default_cooldown = 30
  force_delete = true
  launch_configuration = "${aws_launch_configuration.web_launch_config.id}"
  termination_policies = ["NewestInstance"]
  tag {
    key = "Name"
    value = "web_autoscale"
    propagate_at_launch = true
  }
  tag {
    key = "deployment"
    value = "bbl"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}