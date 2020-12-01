  
variable "projectname" {
  description = "The prefix which should be used for all resources in this example"
}

variable "location" {
  description = "The Azure Region in which all resources in this example should be created."
}

variable "admin" {
	description= "Add your Admin Name"
}

variable "password"{
  description = "Add Password"
}

variable "vmnumber" {
  type = number
  description = "The Number of virtual Machines"

}

variable "image" {
    type = string
    description = "Packer Server Image"
    default = "/subscriptions/939bb7d7-6909-4049-929c-1df590b9f273/resourceGroups/packer-rg/providers/Microsoft.Compute/images/myPackerImage"
}
