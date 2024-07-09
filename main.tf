provider "aws" {
  region = "eu-central-1"
  /*
  access_key = "???????"
  secret_key = "???????"
  explicit declaration of keys is not needed when the details are available in .aws folder in user directory

  # with declaration of keys, terraform is given a form of authentication.
*/
}

terraform {
  backend "s3" {
    bucket  = "dev-terraform-remote-state-wkltt9"
    key     = "jon.state"
    region = "eu-central-1"
    //    dynamodb_table = "jon"
    encrypt = true
  }
}

data "aws_region" "current" {}

locals {
  awsRegion      = data.aws_region.current.name
  kurz           = "BJO"
  kurzklein      = "bjo"
  PubKeyName     = "Public_key"
  AutoUbuntusips = [for serverInstance in aws_instance.AutoUbuntus : serverInstance.public_ip]
  # list of declaration of variables that we can re-use elsewhere for ease.
  # locals are variables that contain just one element
}

# variable in this case means an input variable - we are inputting a variable that contains many elements that can be referenced globally.

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

resource "aws_security_group" "allowed_traffic" {
  name        = "${local.kurz}-allowed_traffic_in"
  description = "Allow inbound traffic and all outbound traffic"
  vpc_id      = data.terraform_remote_state.AWSNetworkState.outputs.vpc_id

  tags = {
    Name = "${local.kurz}-allowed_traffic_in"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv4" {
  security_group_id = aws_security_group.allowed_traffic.id
  #cidr_ipv4         = data.terraform_remote_state.AWSNetworkState.outputs.vpc_cidr_block
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
  cidr_ipv4   = "0.0.0.0/0"
  tags = {
    Name = "${local.kurz}-allow_ssh_ipv4_inbound"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_in" {
  security_group_id = aws_security_group.allowed_traffic.id
  #cidr_ipv4         = data.terraform_remote_state.AWSNetworkState.outputs.vpc_cidr_block
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80
  cidr_ipv4   = "0.0.0.0/0"
  tags = {
    Name = "${local.kurz}-allow_http_inbound"
  }
}

resource "aws_vpc_security_group_egress_rule" "allow_all_out" {
  security_group_id = aws_security_group.allowed_traffic.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
  tags = {
    Name = "${local.kurz}-allow_all_outbound"
  }
}

resource "aws_instance" "AutoUbuntus" {
  for_each                    = toset(data.terraform_remote_state.AWSNetworkState.outputs.vpc_public_subnets)
  ami                         = "ami-0e872aee57663ae2d"
  instance_type               = "t2.micro"
  subnet_id                   = each.key
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.allowed_traffic.id]
  iam_instance_profile        = aws_iam_instance_profile.AutoUbuntuProfile.name
  key_name = module.awskeydeploy.jonpubkeyname
  ##you can call specific arguments out of modules that have been loaded
  user_data                   = "${file("./install_apache.sh")}"

  tags = {
    Name        = "${local.kurz}-UbuntuServer-for_each-${each.key}"
    description = "Jon Baillie for_each example"
    Owner       = "Jon Baillie"
    info        = "EinarbeitungsPlayRoom"
  }

}

resource "aws_route53_record" "AutoUbuntusDNS" {
  name    = "${local.kurz}-Ubuntu-CL"
  type    = "A"
  zone_id = data.terraform_remote_state.AWSAccountSetup.outputs.route53dnsZoneID
  ttl     = 30
  records = local.AutoUbuntusips # equates to "Value/Route traffic to" in the AWS Panel
  #records = [aws_instance.AutoUbuntus.public_ip]
  #records = {for k, instance in aws_instance.AutoUbuntus : k => instance.public_ip} # returns a map
}

resource "aws_route53_record" "privnetfARecord" {
  depends_on = [aws_route53_record.AutoUbuntusDNS]
  name    = "privnetf"
  type    = "CNAME"
  zone_id = data.terraform_remote_state.AWSAccountSetup.outputs.route53dnsZoneID
  ttl     = 30
  records = [aws_route53_record.AutoUbuntusDNS.fqdn] # equates to "Value/Route traffic to" in the AWS Panel
  #records can also be a list - denoted by []
}

/* disabled extra ec2 instances
resource "aws_instance" "JonUbuntuEc2" {
  ami = "ami-0e872aee57663ae2d" # can be found in the ami catalogue "AMI Catalog" - Ubuntu Server 24.04 LTS
  instance_type = "t2.micro"
  subnet_id = element(data.terraform_remote_state.AWSNetworkState.outputs.vpc_public_subnets, 0) # long story short, we are wanting to fill this subnet_id argument with a result, contained in the data source (hense data.*). We are specifying we want to take the first element (here as a 0 because computers).
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  key_name = aws_key_pair.jonpubkey.key_name
  tags = {
    Name        = "${local.kurz}-UbuntuServer-Man"
    description = "Jon Baillie Ubuntu Server. Per Terraform deployed."
    Owner = "Jon Baillie"
    info = "EinarbeitungsPlayRoom"
  }
  # then we can specify further details
  # tags can be custom, many however are standardised
}



resource "aws_instance" "CountUbuntus" {
  count = 2
  ami = "ami-0e872aee57663ae2d"
  instance_type = "t2.micro"
  subnet_id = element(data.terraform_remote_state.AWSNetworkState.outputs.vpc_public_subnets, 1)
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  key_name = aws_key_pair.jonpubkey.key_name
  tags = {
    Name = "${local.kurz}-UbuntuServer-Count-${count.index}"
    description = "Jon Baillie count example"
    Owner = "Jon Baillie"
    info = "Einarbeitungsplayroom"
  }
}
*/ # disabled extra ec2 instances

module "awskeydeploy" {
  # here i am loading the module. The phrase between the "" is purely a label
  # when calling, i want to overwrite the VARIABLE of the MODULE with this data - NOT the ARGUMENT of the RESOURCE invocation
  source        = "./aws_key_pair"
  jonpubkeypath = file("${path.cwd}/id_ed25519.pub")
}

module "first_bucket" {
  source        = "./s3bucket"
  bucket_name   = "${local.kurzklein}-source-bucket"
  force_destroy = true
}

module "second_bucket" {
  source      = "./s3bucket"
  bucket_name = "${local.kurzklein}-dump-bucket"
}

resource "aws_s3_object" "indexphpobject" {
  bucket     = module.first_bucket.bucketname
  key        = "index.php"
  source     = "./index.php"
  depends_on = [
    module.first_bucket
  ]
}

module "iam_policies_init" {
  source = "./iam_policies_init"
}

resource "aws_iam_role" "AutoUbuntusRole" {
  name = "bjo-ubuntusrole"
  assume_role_policy = module.iam_policies_init.ec2_assume_role.json
  #policy is defined elsewhere. Here we are pulling the policy json information created in the module over
}

resource "aws_iam_role_policy" "join_policy" {
  name   = "join_policy"
  role = aws_iam_role.AutoUbuntusRole.name
  policy = module.iam_policies_init.s3_read_acess.json
  #policy is defined elsewhere. Here we are pulling the policy json information created in the module over
}

resource "aws_iam_instance_profile" "AutoUbuntuProfile" {
  name = "bjo-ec2InstanceProfile"
  role = aws_iam_role.AutoUbuntusRole.name
  #
}
