# Azure Infrastructure Operations Project: Deploying a scalable IaaS web server in Azure

### Introduction

For this project, I wrote a Packer template and a Terraform template to deploy a customizable, scalable web server in Azure.

### Getting Started

1. Clone this repository
2. Create your infrastructure as code
3. Update this README to reflect how someone would use your code.

### Dependencies

1. Create an [Azure Account](https://portal.azure.com/)
2. Install the [Azure command line interface](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)
3. Install [Packer](https://www.packer.io/downloads) (add to Path. Vars)
4. Install [Terraform](https://www.terraform.io/downloads.html) (add to Path. Vars)

### Instructions

#### Packer 

After installing Azure, Packer and Terraform, download all elements from this repository and place them in the same folder. At **first** go to **server.json** and change the **client-secret**, the **subsciption-id** and the **client_id** to match yours.  Run **packer build server.json** in the command line (navigate to the specific folder), to create a server Iamge. 

#### Terraform 

First, look in your **Azure-Portal**, in the **Segment Images**, for the location of the image you just created.  Copy the value and paste it into the **variables.tf** file under default. This ensures that this image is also used to create the server.   

Use a command line to navigate to your folder containing your terraform data (main.tf and variables.tf) and plan the infrastructure with **terraform plan -out yourplannamehere.plan**. Terraform asks for the **user name for Azure**, the **password**, the **location of the server**, and the **number of virtual machines**. The number of virtual machines is kept flexible, so that you can choose from $1$ to $\infty$.  

You will also be asked for a **project name**, which is used as a prefix for the naming of central resources.  Apart from that, this is a Prefix of all assigned tags. 

After your plan was generated, you can deploy your server using **terraform apply yourplannamehere.plan**. This might take a while and after its done, you can check your azure portal for your deployed infrastructure. 

The Type of VM's is predefined as **Standard_D2_v3**. If you want to change it, replace it with your favorite Version. 

### Output 

This will create the following Ressources: 

+ Network
+ Network Security Group 
+ A public-Ip
+ Load balancer
+ Virtual-Machines (in my Case 2)
+ Availability Sets for VM's (corresponding to VM's)
+ Network Interface Cards (corresponding to VM's)
+ Disks for the VM's (corresponding to VM's)
+ One Managend Disk. 

### Resources 

[Azure Documentation](https://docs.microsoft.com/de-de/azure/?product=featured)

[Terraform Documentation](https://www.terraform.io/docs/index.html)

[Terraform Providers Git](https://github.com/terraform-providers)





