
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["dlm.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "dlm_lifecycle_role" {
  name               = var.iam_role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "aws_iam_policy_document" "dlm_lifecycle" {
  statement {
    effect = "Allow"

    actions = [
      "ec2:CreateSnapshot",
      "ec2:CreateSnapshots",
      "ec2:DeleteSnapshot",
      "ec2:DescribeInstances",
      "ec2:DescribeVolumes",
      "ec2:DescribeSnapshots",
    ]

    resources = ["*"]
  }

  statement {
    effect    = "Allow"
    actions   = ["ec2:CreateTags"]
    resources = ["arn:aws:ec2:*::snapshot/*"]
  }
}

resource "aws_iam_role_policy" "dlm_lifecycle" {
  name   = var.iam_policy_name
  role   = aws_iam_role.dlm_lifecycle_role.id
  policy = data.aws_iam_policy_document.dlm_lifecycle.json
}


resource "aws_dlm_lifecycle_policy" "example" {
  description        = "DLM lifecycle policy for snapshots"
  execution_role_arn = aws_iam_role.dlm_lifecycle_role.arn
  state              = var.policy_state
  tags = var.policy_tags

  policy_details {
    resource_types = var.resource_types

    schedule {
      name = var.policy_schedule_name

      create_rule {
        interval      = var.interval
        interval_unit = "HOURS"
        times         = var.times
      }

      retain_rule {
        count = var.count_number
      }

      tags_to_add = var.extra_tags

      copy_tags = var.copy_tags
    }

    target_tags = var.target_tags
    
  }
}