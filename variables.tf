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