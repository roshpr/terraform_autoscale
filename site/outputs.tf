output "bastion_ip" {
  value = "54.159.102.149"
}
output "autoscale_id" {
  value = "${module.autoscale.web_autoscale_id}"
}
output "autoscale_sg_name" {
  value = "${module.autoscale.autoscale_sg_name}"
}
output "elb_sg_name" {
  value = "${module.autoscale.elb_sg_name}"
}
output "elb_name" {
  value = "${module.autoscale.elb_name}"
}