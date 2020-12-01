  
variable "projectname" {
  type    = string
  default = "Udacity" 
  description = "The prefix which should be used for all resources in this example"

}

variable "location" {
  type        = string
  default     = "West Europe"
  description = "The Azure Region in which all resources in this example should be created."
}

variable "admin" {
	description= "Add your Admin Name"
}

variable "password"{
  description = "Add Password"
}

variable "vmnumber" {
  type        = number
  default     = 2
  description = "The Number of virtual Machines"

  # define regex condition for validation
  validation {
    condition     = can(regex("2|3|4|5", var.vmnumber))
    error_message = "The number of virtual machines must be between 2 and 5; please correct your Input" 

  } 

}

variable "image" {
    type = string
    description = "Packer Server Image"
    default = "/subscriptions/939bb7d7-6909-4049-929c-1df590b9f273/resourceGroups/packer-rg/providers/Microsoft.Compute/images/myPackerImage"
}
