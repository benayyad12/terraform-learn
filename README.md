# terraform-learn

Terraform is an infrustructure as code tool.

Terraform is used for provisioning infrastructure 

Terraform is a multicloud tool that support different providers: AWS, AZURE and GCP...

Terraform uses HCL (HashiCorp Configuration Language) which makes it more user friendly and easier to work with.

It works in 3 steps:

init (initialize terraform installing necessary plugins)

plan (Terraform shows the plan to get to the desired state)

apply (Applyc changes after confirmation of the desired state)

Terraform commands:

terraform version => display current version (+provider's version)

Terraform init => initialize terraform by installing plugins to communicate with provider

terraform plan => show the changes to get to the desired state

terraform apply => apply changes 

terraform show => display resource created 

terraform destroy => to delete infrastructure

syntax:

block parameters {

         key1 = value1
         
         key2 = value2
}

example:  

resource "local_file" "pet" {

         filename = "/root/pets.txt"
         
         content = "We love pets!"
}

local_file = provider_resource

resource name = "pet"

to update config:

resource "local_file" "pet" {

      filename = "/root/pets.txt"
      
      content = "we love pets!"
      
      file_permission = "0700"
      
}

Terraform Providers:

OFFICIAL: AWS / AZURE / GCP

PARTNER: BigIP (F5NW) and Digital Ocean

COMMUNITY:  ucloud or active directory

init => install plugins for provider

hashicorp/local: used to locate the plugin of local provider in the hashicorp registry

organizational namespace: hashicorp

Type : local

hostname: registry.terraform.io

=> registry.terraform.io/hashicorp/local

Multiple providers:

example: random => random_per

resource "random_pet" "my-pet" {

      length = "1"

      separator = "."

      prefix = "Mr"

  
}

it allows us to generate pet name.



