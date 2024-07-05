provider "aws" {
  region = "eu-central-1"
  /*
  access_key = "???????"
  secret_key = "???????"
  explicit declaration of keys is not needed when the details are available in .aws folder in user directory

  # with declaration of keys, terraform is given a form of authentication.
*/
}

data "aws_region" "current" {}

locals {
  awsRegion = data.aws_region.current.name
  kurz = "BJO"
  # list of declaration of variables that we can re-use elsewhere for ease.
  # locals are variables that contain just one element
}

terraform {
  backend "s3" {
    bucket         = "dev-terraform-remote-state-wkltt9"
    key            = "jon.state"
    region         = "eu-central-1"
//    dynamodb_table = "jon"
    encrypt        = true
  }
}

/*
A Local. is only accessible within the local module vs a Terraform variable., which can be scoped globally.
Another thing to note is that a local in Terraform doesn’t change its value once assigned. A variable value can be manipulated via expressions
https://spacelift.io/blog/terraform-locals
*/

# variable in this case means an input variable - we are inputting a variable that contains many elements that can be referenced globally.
variable "TerraformRemoteStateBucket" {
  type        = string
  description = "S3 bucket in which the state files are saved. Use default for jet deployment."
  default     = "dev-terraform-remote-state-wkltt9"
}

variable "AWSAccountSetupState" {
  type        = string
  description = "Name of the network state file / dynamo db table"
  default     = "AWSAccountSetup"
}

variable "AWSNetworkState" {
  type        = string
  description = "Name of the network state file / dynamo db table"
  default     = "network"
}

data "terraform_remote_state" "AWSAccountSetup" {
  backend   = "s3"
  workspace = "dev"
  config = {
    bucket         = var.TerraformRemoteStateBucket
    key            = "${var.AWSAccountSetupState}.tfstate"
    region         = local.awsRegion
    dynamodb_table = var.AWSAccountSetupState
  }
}

data "terraform_remote_state" "AWSNetworkState" {
  backend   = "s3"
  workspace = "dev"
  config = {
    bucket         = var.TerraformRemoteStateBucket
    key            = "${var.AWSNetworkState}.state"
    region         = local.awsRegion
    dynamodb_table = var.AWSNetworkState
  }
}

/*output "yyyy" {
  value = data.terraform_remote_state.AWSNetworkState.outputs
}*/

resource "aws_security_group" "allow_ssh" {
  name        = "${local.kurz}-allow_ssh"
  description = "Allow ssh inbound traffic and all outbound traffic"
  vpc_id      = data.terraform_remote_state.AWSNetworkState.outputs.vpc_id

  tags = {
    Name = "${local.kurz}-allow_ssh"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv4" {
  security_group_id = aws_security_group.allow_ssh.id
  #cidr_ipv4         = data.terraform_remote_state.AWSNetworkState.outputs.vpc_cidr_block
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
  cidr_ipv4         = "0.0.0.0/0"
  tags = {
    Name = "allow_ssh_ipv4_inbound"
  }
}

resource "aws_instance" "JonUbuntuEc2" {
  ami = "ami-0e872aee57663ae2d" # can be found in the ami catalogue "AMI Catalog" - Ubuntu Server 24.04 LTS
  instance_type = "t2.micro"
  subnet_id = element(data.terraform_remote_state.AWSNetworkState.outputs.vpc_public_subnets, 0) # long story short, we are wanting to fill this subnet_id argument with a result, contained in the data source (hense data.*). We are specifying we want to take the first element (here as a 0 because computers).
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  key_name = aws_key_pair.jonpubkey.key_name
  tags = {
    Name        = "${local.kurz}-UbuntuServer1"
    description = "Jon Baillie Ubuntu Server. Per Terraform deployed."
    Owner = "Jon Baillie"
    info = "EinarbeitungsPlayRoom"
  }
  # then we can specify further details
  # tags can be custom, many however are standardised
}

resource "aws_key_pair" "jonpubkey" {
  key_name = "consistrechnerjbENGERLAND"
  public_key = file("${path.cwd}/id_ed25519.pub")
}




output "vpc_public_subnet_ids" { # "vpc_public_subnet_ids" is literally just a name. We are just naming the label for easy identification
  value = data.terraform_remote_state.AWSNetworkState.outputs.vpc_public_subnets
  # The value is - DATASOURCE.datasourcestype.datasourcename.wewantanOUTput.theOutputwewant
  # Datasource is "go query something, the information i need to tied up in the following container/element/resource/item delcared
}

output "JonUbuntuEc2PubIP" {
  value = aws_instance.JonUbuntuEc2.public_ip
}