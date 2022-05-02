/*
resource "aws_iam_user" "ahmed-samir" {
  name = "ahmed-samir"
}

# Creating Groups
resource "aws_iam_group" "Admin" {
  name = "Admin"
}

#Assign users to groups

resource "aws_iam_group_membership" "Admin" {
  name = "Admin"
  users = [
    aws_iam_user.ahmed-samir.name,
  ]
  group = aws_iam_group.Admin.name
}

# Attach Policy
resource "aws_iam_policy_attachment" "Admin-access-policy" {
  name       = "Admin-access"
  groups     = [aws_iam_group.Admin.name]
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

data "aws_iam_group" "Admin" {
  group_name = "Admin"
  depends_on = [aws_iam_group_membership.Admin]
}
*/
