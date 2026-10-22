terraform {
  required_version = ">= 1.5"

  backend "http" {}
}

variable "environment" {
  description = "Environnement cible : d, int, uat ou prd"
  type        = string

  validation {
    condition     = contains(["d", "int", "uat", "prd"], var.environment)
    error_message = "environment doit être d, int, uat ou prd."
  }
}

variable "image" {
  description = "Image à déployer (valeur issue des group variables GitLab)"
  type        = string
}

output "deployed" {
  value = "${var.image} -> ${var.environment}"
}
