
resource "aws_iam_user" "gitlab-user" {
  name = "gitlab.user@g.works"
}

resource "aws_iam_user" "joni" {
  name = "joni.mustaniemi@g.works"
}

resource "aws_iam_user" "maxim" {
  name = "maxim@g.works"
}

resource "aws_iam_user" "sami" {
  name = "sami@g.works"
}

# Creating Groups
resource "aws_iam_group" "Admin" {
  name = "Admins"
}

#Assign users to groups

resource "aws_iam_group_membership" "Admin" {
  name = "Admins"
  users = [
    aws_iam_user.gitlab-user.name,
    aws_iam_user.joni.name,
    aws_iam_user.maxim.name,
    aws_iam_user.sami.name,
  ]
  group = aws_iam_group.Admin.name
}

# Attach Policy
resource "aws_iam_policy_attachment" "Admin-access-policy" {
  name       = "Admin-access"
  roles      = ["g-works-Admin-role"]
  groups     = [aws_iam_group.Admin.name]
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

data "aws_iam_group" "Admin" {
  group_name = "Admins"
  depends_on = [aws_iam_group_membership.Admin]
}
