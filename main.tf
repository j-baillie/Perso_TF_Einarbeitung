provider "aws" {
  region = "eu-central-1"
  access_key = "???????"
  secret_key = "???????"
  # with this, terraform knows that we are 'going into' AWS. It already has the API's installed so knows how to call into AWS, using the login credentials we have given it
  # that being the region, access_key and secret_key
  # for security, these details will be omitted upon saving to github
}
# resource is tf snytax // "aws_instance" points to the specific object in the provider we want to call // JonUbuntuEc2 is purely
# a name label, which we can refer back to further down in the tf code
resource "aws_instance" "JonUbuntuEc2" {
  ami = "ami-0e872aee57663ae2d" # can be found in the ami catalogue "AMI Catalog" - Ubuntu Server 24.04 LTS
  instance_type = "t2.micro"
  tags = {
    name = "UbuntuServer1"
  }
# then we can specify further details
}

#here we are declaring how the VPC should look.
resource "aws_vpc" "PersoVPC"{
  cidr_block = "10.0.0.0/16" # 10.0.0.0 -> 10.0.255.255 (Netmask is then 255.255.0.0)
  tags = {
    Name = "prod"
  }
}

resource "aws_subnet" "StandSubnet" {
  vpc_id = aws_vpc.PersoVPC.id # note - that the ID is a combination of the resource type + the name of the resource + .id
  cidr_block = "10.0.1.0/24" # we're talking about + .id to specify the actual ID, which we are then passing to this next component
}
# we need to tell terraform the vpc we want to setup the subnet in. For that it needs an id - vpc_id.
# Terraform then goes with the vpc_id to the aws cloud api and does what we need it to




resource "aws_s3_bucket" "Inventory_Bucket" {
  bucket = "inventory_bucket"
  tags = {
    Name = "The Inventory Bucket"
  }
}
