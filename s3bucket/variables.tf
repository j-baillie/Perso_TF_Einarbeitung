variable "force_destroy" {
  type        = bool
  description = "(Optional, Default:false) Boolean that indicates all objects (including any locked objects) should be deleted from the bucket when the bucket is destroyed so that the bucket can be destroyed without error. These objects are not recoverable. This only deletes objects when the bucket is destroyed, not when setting this parameter to true. Once this parameter is set to true, there must be a successful"
  default     = false
}

variable "bucket_name" {
  type        = string
  description = "the bucketname"
  default     = "consist-jon-default"
}

