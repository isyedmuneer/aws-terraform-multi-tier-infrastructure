# DB Subnet Group (RDS ko chalne ke liye kam se kam 2 private subnets chahiye)
resource "aws_db_subnet_group" "main" {
  name       = "main-db-subnet-group"
  subnet_ids = [aws_subnet.private_1.id, aws_subnet.private_2.id]
  tags       = { Name = "main-db-subnet-group" }
}

# RDS MySQL Instance (Private Subnet)
resource "aws_db_instance" "mysql" {
  allocated_storage      = 20
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  db_name                = "mydb"
  username               = "admin"
  password               = "SuperSecurePassword123!" # Pro tip: Isko real use me vault/variables se handle karein
  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  skip_final_snapshot    = true

  tags = { Name = "prod-mysql-db" }
}
