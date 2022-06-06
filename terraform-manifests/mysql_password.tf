# Secret Variables (Should not be checked-in to Github)

variable "database_admin_password" {
  default = "w0rdpr3ss@p4ss"
  sensitive   = true
  type        = string
}

variable "mysql_db_password" {
  default = "H@Sh1CoR3!"
  sensitive   = true
  type        = string
}
