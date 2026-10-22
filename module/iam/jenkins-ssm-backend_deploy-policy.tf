resource "aws_iam_role_policy" "jenkins_backend_ssm_deploy" {
  name = "JenkinsBackendSSMDeployPolicy"

  role = aws_iam_role.ssm_role.name

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Sid    = "AllowBackendSSMDeployment"
        Effect = "Allow"

        Action = [
          "ssm:SendCommand"
        ]

        Resource = [
          "arn:aws:ec2:ap-south-1:174376948569:instance/i-03b37f268f34ea125",
          "arn:aws:ssm:ap-south-1::document/AWS-RunShellScript"
        ]
      }
    ]
  })
}
