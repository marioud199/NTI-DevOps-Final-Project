
resource "aws_iam_role" "backup_role" {
  name = "AWSBackupDefaultServiceRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action    = "sts:AssumeRole",
        Effect    = "Allow",
        Principal = {
          Service = "backup.amazonaws.com"
        },
      },
    ],
  })
}

resource "aws_iam_role_policy_attachment" "backup_role_policy" {
  role       = aws_iam_role.backup_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
}

# Backup Vault
resource "aws_backup_vault" "my_backup_vault" {
  name = "my-backup-vault"
}

# Backup Plan
resource "aws_backup_plan" "my_backup_plan" {
  name = "my-backup-plan"
  rule {
    rule_name         = "my-backup-rule"
    target_vault_name = aws_backup_vault.my_backup_vault.name
    schedule          = "cron(0 12 * * ? *)"
    # start_window      = "3 hours"
    # completion_window = "60 minutes"
    lifecycle {
      delete_after = 7
    }
  }
}

# Backup Selection
resource "aws_backup_selection" "ec2_backup_selection" {
  iam_role_arn = aws_iam_role.backup_role.arn
  name         = "ec2-backup-selection"
  plan_id      = aws_backup_plan.my_backup_plan.id

  resources = [
    var.ec2_arn
  ]
}
