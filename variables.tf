
variable "iam_policy_name" {
  type        = string
  default     = "dlm-lifecycle-policy"
  description = "IAM policy name"
}
variable "iam_role_name" {
  type        = string
  default     = "dlm-lifecycle-role"
  description = "IAM Role name"
}
variable "resource_types" {
  type        = list(any)
  default     = ["VOLUME"]
  description = "A list of resource types that should be targeted by the lifecycle policy. Ex:- VOLUME and INSTANCE"
}
variable "policy_state" {
  type        = string
  default     = "ENABLED"
  description = "Whether the lifecycle policy should be enabled or disabled"
}
variable "policy_tags" {
  type        = map(any)
  default     = {
    Name = "snapshot-policy"
  }
  description = "tags added to the policy"
}

variable "policy_schedule_name" {
  type        = string
  default     = "Daily schedule at 9 am"
  description = "policy schedule name. Ex:- To run daily at 9 am"
}
variable "interval" {
  type        = number
  default     = "12"
  description = "How often this lifecycle policy should be evaluated. 1,2,3,4,6,8,12 or 24 are valid values."
}


variable "times" {
  type        = list(any)
  default     = ["09:00"]
  description = " A list of times in 24 hour clock format that sets when the lifecycle policy should be evaluated. Ex:- 09:00."
}

variable "count_number" {
  type        = number
  default     = "5"
  description = " How many snapshots to keep. Must be an integer between 1 and 1000."
}


variable "extra_tags" {
  type        = map(any)
  default     = {
    SnapshotCreator = "DLM"
    Creator = "Bala"
  }
  description = " DLM lifecycle policies will already tag the snapshot with the tags on the volume. This configuration adds extra tags on top of these."
}
variable "copy_tags" {
  type        = bool
  default     = "false"
  description = "DLM lifecycle policies will allow tag the snapshot with the tags on the volume"
}

variable "target_tags" {
  type        = map(any)
  default     = {
    Snapshot = "true"
  }
  description = "volumes or instances having these tags are taken snapshot"
}


