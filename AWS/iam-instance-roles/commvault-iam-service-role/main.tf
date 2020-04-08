# This is a custom role, with a custom policy that should only be given to Commvault instances in AWS
resource "aws_iam_role" "wt-commvault-role" {
  assume_role_policy = file("${path.module}/policies/ec2-trust.json")
  description        = "IAM Instance Role fopr Commvault Instances"
  name               = "WT_Commvault_Instance_Role"
  tags = {
    Name        = "WT_Commvault_Instance_Role"
    Owner       = var.owner
    Managed     = var.managed
    Environment = "All"
    Internal    = ""
    Cost        = var.cost
    Division    = var.division
    Department  = var.department
  }
}

resource "aws_iam_instance_profile" "wt-commvault-instance-profile" {
  name = "WT_Commvault_IAM_Instance_Profile"
  role = aws_iam_role.wt-commvault-role.name
}

resource "aws_iam_policy" "wt-commvault-role-policy" {
  policy = file("${path.module}/policies/commvault.json")
  name   = "WT_Commvault_IAM_Role_Policy"
}

resource "aws_iam_role_policy_attachment" "wt-commvault-policy-attachement" {
  policy_arn = aws_iam_policy.wt-commvault-role-policy.arn
  role       = aws_iam_role.wt-commvault-role.name
}


resource "aws_iam_policy" "wt-commvault-s3-role-policy" {
  policy = file("${path.module}/policies/commvault-s3-policy.json")
  name   = "WT_Commvault_S3_Role_Policy"
}

resource "aws_iam_role_policy_attachment" "wt-commvault-policy-attachement-2" {
  policy_arn = aws_iam_policy.wt-commvault-s3-role-policy.arn
  role       = aws_iam_role.wt-commvault-role.name
}

resource "aws_iam_policy" "wt-commvault-glacier-role-policy" {
  policy = file("${path.module}/policies/commvault-glacier-policy.json")
  name   = "WT_Commvault_Glacier_Role_Policy"
}

resource "aws_iam_role_policy_attachment" "wt-commvault-policy-attachement-3" {
  policy_arn = aws_iam_policy.wt-commvault-glacier-role-policy.arn
  role       = aws_iam_role.wt-commvault-role.name
}
