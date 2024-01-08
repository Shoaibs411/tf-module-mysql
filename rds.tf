# Provisioning RDS Instance
resource "aws_db_instance" "default" {
  allocated_storage    = 10
  db_name              = "roboshop-${var.ENV}-mysql"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  username             = "admin1"
  password             = "RoboShop1"
  parameter_group_name = aws_db_parameter_group.mysql.name
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.mysql.name
}

# Provisioning RDS Parameter Group
resource "aws_db_parameter_group" "mysql" {
  name   = "roboshop-${var.ENV}-mysql-pg"
  family = "mysql5.7"
}


# Creates a Subnet Group
resource "aws_db_subnet_group" "mysql" {
  name       = "roboshop-${var.ENV}-mysql-subnet-group"
  subnet_ids = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS

  tags = {
    Name     = "roboshop-${var.ENV}-mysql-subnet-group"
  }
}

