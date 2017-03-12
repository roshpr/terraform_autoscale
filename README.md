# terraform_autoscale
Create a website load balanced between 3 EC2 instances managed by autoscaling group
* Create 3 EC2 instances 
* Front end it with ELB
* Autoscaling is configured to create 3 instances
* Userdata: install apache
* variable inputs are present inside site & autoscale folder.

#Executing the code
* make changes to main.tf/variables in site folder
* Run the following commands
    * terraform get site
    * terraform apply site
