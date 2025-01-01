# RDS Security Group
resource "aws_security_group" "rds_sg" {
  name_prefix = "${var.environment}-rds-sg"
  description = "Security group for RDS MySQL instance"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow MySQL access"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name = "${var.environment}-rds-sg"
  })
}

# RDS Subnet Group
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "${var.environment}-rds-subnet-group"
  subnet_ids = var.subnet_ids
  tags = merge(var.tags, {
    Name = "${var.environment}-rds-subnet-group"
  })
}

# RDS Instance
resource "aws_db_instance" "rds_instance" {
  allocated_storage    = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  engine               = "mysql"
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  db_name                 = var.db_name
  username             = var.db_username
  password             = var.db_password
  parameter_group_name = var.parameter_group_name
  publicly_accessible  = var.publicly_accessible
  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  multi_az             = var.multi_az
  storage_type         = var.storage_type
  backup_retention_period = var.backup_retention_period
  skip_final_snapshot  = var.skip_final_snapshot
  deletion_protection  = var.deletion_protection

  tags = merge(var.tags, {
    Name = "${var.environment}-rds-instance"
  })
}
