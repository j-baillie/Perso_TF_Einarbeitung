variable "jonpubkeyname" {
  type = string
  description = "Name to be given to keypair on ec2 instance"
  default = "ConsistRechnerJonBaillie"
}

variable "jonpubkeypath" {
  type = string
  description = "Path to public key"
  default = "DUMMY"
}