locals {
  common_tags = {
    Project        = "CCGC 5502 Automation Project"
    Name           = var.student_name
    ExpirationDate = "2027-12-31"
    Environment    = "Lab"
  }
}