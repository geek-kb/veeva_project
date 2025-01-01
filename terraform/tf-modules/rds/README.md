
# README for RDS Terraform Module

---

#### Overview
This Terraform module provisions and manages an RDS MySQL instance, its associated security group, and subnet group in AWS. It ensures secure and reliable database management by leveraging AWS best practices, such as security groups and database subnet groups.

---

#### Features

- **Security Group**: Allows access to the RDS instance on the specified port.
- **Subnet Group**: Configures a subnet group for the RDS instance.
- **RDS Instance**: Manages MySQL-based RDS instances with various configurations.
- **Outputs**: Provides essential details about the RDS instance, such as endpoint and credentials.

---

#### Resources Created

1. **AWS Security Group (`aws_security_group`)**
   - Allows MySQL access from specified CIDR blocks.
   - Allows all outbound traffic.

2. **AWS DB Subnet Group (`aws_db_subnet_group`)**
   - Organizes subnets for the RDS instance.

3. **AWS DB Instance (`aws_db_instance`)**
   - Provisions a MySQL-based RDS instance with user-defined configurations.

---

#### Inputs

| Name                     | Description                                            | Type         | Default       |
|--------------------------|--------------------------------------------------------|--------------|---------------|
| `environment`            | The environment (e.g., dev, staging, prod)            | `string`     |               |
| `vpc_id`                 | The ID of the VPC                                     | `string`     |               |
| `subnet_ids`             | A list of subnet IDs for the RDS instance             | `list(string)` |               |
| `allowed_cidr_blocks`    | List of CIDR blocks allowed to access the RDS instance| `list(string)` |               |
| `db_name`                | The name of the database                              | `string`     |               |
| `db_username`            | The master username for the database                  | `string`     |               |
| `db_password`            | The master password for the database                  | `string`     |               |
| `engine_version`         | The version of the database engine                    | `string`     |               |
| `instance_class`         | The instance class for the RDS instance               | `string`     |               |
| `allocated_storage`      | The initial allocated storage (in GB)                 | `number`     | `20`          |
| `max_allocated_storage`  | The maximum allocated storage (in GB)                 | `number`     | `100`         |
| `parameter_group_name`   | The name of the parameter group                       | `string`     | `null`        |
| `multi_az`               | Specifies whether the RDS instance is multi-AZ        | `bool`       | `false`       |
| `storage_type`           | The storage type (e.g., standard, gp2, io1)           | `string`     | `gp2`         |
| `backup_retention_period`| The number of days to retain backups                  | `number`     | `7`           |
| `publicly_accessible`    | Whether the RDS instance is publicly accessible       | `bool`       | `false`       |
| `skip_final_snapshot`    | Skip final snapshot before destroying the instance    | `bool`       | `true`        |
| `deletion_protection`    | Enable deletion protection                            | `bool`       | `false`       |
| `tags`                   | A map of tags to assign to resources                  | `map(string)`| `{}`          |

---

#### Outputs

| Name                     | Description                                           |
|--------------------------|-------------------------------------------------------|
| `rds_instance_endpoint`  | The endpoint of the RDS instance                     |
| `rds_instance_arn`       | The ARN of the RDS instance                          |
| `rds_security_group_id`  | The ID of the RDS security group                     |
| `rds_db_username`        | The username of the RDS database                     |
| `rds_db_password`        | The password of the RDS database (sensitive)         |

---

#### Usage Example

```hcl
module "rds" {
  source                   = "./rds-module"
  environment              = "staging"
  vpc_id                   = "vpc-12345678"
  subnet_ids               = ["subnet-12345678", "subnet-87654321"]
  allowed_cidr_blocks      = ["192.168.1.0/24"]
  db_name                  = "mydb"
  db_username              = "admin"
  db_password              = "securepassword"
  engine_version           = "8.0.28"
  instance_class           = "db.t3.micro"
  allocated_storage        = 20
  max_allocated_storage    = 100
  parameter_group_name     = null
  multi_az                 = false
  storage_type             = "gp2"
  backup_retention_period  = 7
  publicly_accessible      = false
  skip_final_snapshot      = true
  deletion_protection      = false
  tags                     = {
    Project = "MyProject"
    Owner   = "Admin"
  }
}
```
