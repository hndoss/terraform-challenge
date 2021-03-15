data "aws_ami" "ami" {
  most_recent = true
  owners      = ["487799950875"]

  filter {
    name   = "name"
    values = ["terraform-challenge"]
  }
}
