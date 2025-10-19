# terraform-learn

Terraform is an infrustructure as code tool.

Terraform is used for provisioning infrastructure 

Terraform is a multicloud tool that support different providers: AWS, AZURE and GCP...

Terraform uses HCL (HashiCorp Configuration Language) which makes it more user friendly and easier to work with.

It works in 3 steps:

init (initialize terraform installing necessary plugins)

plan (Terraform shows the plan to get to the desired state)

apply (Apply changes after confirmation of the desired state)

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

Use input Variables => hardcoding variables is not a good idea 

example of using input variables:

resource "local_file" "pet" {

      content = "I love pet!"

      filename = "/root/pet.txt"

}

declare variables:

variable "filename" {

    default = "/root/pet.txt"

}

variable "content" {

     default = "I love pet!"

}

to use these vars:

resource "local_file" "pet" {

    filename = var.filename

    content = var.content

}

variable types:

bool

numeric

map 

list

string

tuple

set 

object

=>

to declare variable:

variable "name-of-variable" {

      default = 

      type = 

      description =

}

exemple with list:

variable "prefix" {

     default = ["Mr", "Mrs", Sir"]
     
     type = list(string)

}
      

resource "random_pet" "my-pet" {

      prefix = var.prefix[0] 

}

How to use variables without default:

when you declare a variable keep it empty (default/type/description)

variable "filename" {

    

}


Terraform will ask you to enter a value of the variable through the console

or you have other options:

Export variables:

export TF_VAR_filename = "/root/pet.txt"

Use -var flag:

terraform apply -var filename="/root/pet.txt"

Use files terraform.tfvars:

filename="/root/pet.txt"

or use *.auto.tfvars files.

Resource Attribute:

we can use attribute of other resource in different resource 

example:

resource "random_pet" "my-pet" {

       prefix = var.prefix

       length = var.length

       separator = var.separator

}

if we want to use random_pet to generate a pet's name and passs it in the local_file's content we can:

resource "local_file" "pet" {

      filename = var.filename

      content = "This is my pet: ${random_pet.my-pet.id}"

}

Resource Dependencies:

2 types:

Implicit Dependency: 

when you use Resource attribute (terraform will create random_pet.pet.id before local_file because we need to generate pet's name (id) and put it in the content )

this called implicit 

When we destroy: terraform destroy

terraform will delete: local_file => then random_pet

Explicit Dependency:

example:

resource "local_file" "my-pet" {

      filename = var.filename

      content = "My pet is Mr.Tom"

      depends_on = [

          random_pet.pet
          
          ]

}

resource "random_pet" "pet" {

      length = var.length

      prefix = var.prefix 

      separator = var.separator

}

example explicit dependency:

resource "local_file" "whale" {

     filename = "/root/whale"
     
     content = "whale"

}

resource "local_file" "krill" {

     filename = "/root/krill"
     
     content = "krill"

}

we want to make whale depends on krill :

resource "local_file" "whale" {

     filename = "/root/whale"
     
     content = "whale"

     depends_on = [ local_file.krill ]

}

now: krill local file will be created first then whale after.

Implicit dependency:  use reference expression like => ${tls_private_key.pvtkey.private_key_pem} 

Output Variables:

resource "random_pet" "pet" {

        length = var.length

        prefix = var.prefix

        separator = var.separator

}

Define a variable pet-name to save the output of random_pet result:

output "pet-name" {

        value = random_pet.pet.id

        description = "Record the value of pet id generated by random_pet resource"

}

if we execute: terraform output

we will see all output variables or specifically terraform output name-of-output-variable

example: terraform output pet-name 

Example 2:  Output variable

resource "local_file" "kodekloud" {

       filename = "/root/kodekloud"
       
       content = "Welcome to KodeKloud"

}

output "welcome" {

    value = local_file.kodekloud.content 

}

terraform output welcome 

> Welcome to KodeKloud
    


