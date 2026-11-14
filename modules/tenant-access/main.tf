data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "trust" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
  }
}

data "aws_iam_policy_document" "upload" {
  statement {
    actions   = ["s3:PutObject"]
    resources = ["${var.bucket_arn}/recordings/${var.tenant_id}/*"]
  }
  statement {
    actions   = ["kms:GenerateDataKey", "kms:Decrypt"]
    resources = [var.kms_key_arn]
  }
}

resource "aws_iam_role" "uploader" {
  name               = "${var.name_prefix}-${var.tenant_id}-uploader"
  assume_role_policy = data.aws_iam_policy_document.trust.json
}

resource "aws_iam_role_policy" "upload" {
  name   = "upload-own-prefix"
  role   = aws_iam_role.uploader.id
  policy = data.aws_iam_policy_document.upload.json
}
