# terraform-learn
terraform is an infrastructure as code tool
used for provisionning infrastructure.

It's a multicloud tool supporting different providers such as: GCP, AWS, AZURE and also Private cloud.

Terraform uses HCL HarshiCorp Configuration Language which make it user friendly and more easier to work with.

Terraform communicates with different providers using API.

It's works in 3 steps:

Init (initialise terraform installing necessary plugins)

Plan (shows the plan to get to the desired state)

Apply (apply changes when user type "yes" to confirm that)

Terraform commands:

terraform version => to see the used version example: v0.13.0

terraform plan => shows changes to get to the desired state

terraform apply => requires confirmation to make the changes 

terraform show => shows the created resource

terraform refresh => get current state

terraform destroy => destroy infrastructure 

example:

creating local file in /root/pets.txt with the following content: "we love pets"

Syntax:

<block> <parameters> {

       key1 = value1
       
       key2 = value2
       
}
real example:

resource "local_file" "pet" {

       filename = "/root/pets.txt"
       
       content = "we love pets"
       
}

to update infrastructre using terraform:

resource "local_file" "pet" {

       filename = "/root/pets.txt"
       
       content = "we love pets"
       
       file_permission = "0700"
       
}

then we run: terraform plan (to see plan to get to the desired state)

terraform apply (the file will be deleted and recreated with the new permissions)


to destroy completely the infrastructure:

terraform destroy


