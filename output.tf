# output <labelname for the output>
output "bucket2_name" {
  value = module.second_bucket.bucketname
  #what we want to output is - <foundinamodule>.<modulename we have loaded>.output to load from module
}

output "bucket2_force_destroy" {
  value = module.second_bucket.force_destroy
}

output "bucket1_name" {
  value = module.first_bucket.bucketname
}


output "bucket1_force_destroy" {
  value = module.first_bucket.force_destroy
}

output "jonpubkeyname" {
  value = module.awskeydeploy.jonpubkeyname
}

output "jonpubkeypath" {
  value = module.awskeydeploy.jobpubkeypath
}


#print into the console the public ips of the servers created with for_each
output "Z_JonForEachPubIP" {
  value = {for k, server_Instance in aws_instance.AutoUbuntus : k => server_Instance.public_ip}
  # for every instance, pull the information public_ip to k. print k
  #value = aws_instance.AutoUbuntus.public_ip
}

output "vpc_public_subnet_ids" {
  # "vpc_public_subnet_ids" is literally just a name. We are just naming the label for easy identification
  value = data.terraform_remote_state.AWSNetworkState.outputs.vpc_public_subnets
  # The value is - DATASOURCE.datasourcestype.datasourcename.wewantanOUTput.theOutputwewant
  # Datasource is "go query something, the information i need is tied up in the following container/element/resource/item declared
}

output "UbuntuIps" {
  value = local.AutoUbuntusips
}

output "UbuntuDNSName" {
  value = aws_route53_record.AutoUbuntusDNS.fqdn
  #what we want is part of a resource (created or to be created), the resource label is <> and the value we want is the fqdn
}

output "s3objectbucket" {
  value = aws_s3_object.indexphpobject.bucket
}

output "s3objectfile" {
  value = aws_s3_object.indexphpobject.key
}

output "TerraformRemoteStateBucket" {
  value = var.TerraformRemoteStateBucket
}

output "AWSAccountSetupState" {
  value = var.AWSAccountSetupState
}

output "AWSNetworkState" {
  value = var.AWSNetworkState
}