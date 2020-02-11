resource "aws_docdb_subnet_group" "this" {
  name = "${var.projectname}-${var.environment}-documentdb-subnetgroup"

  subnet_ids = [
    var.priv-subnet-1,
    var.priv-subnet-2,
    var.priv-subnet-3
  ]

  tags = {
    Project = var.projectname
    Stages  = var.environment
  }
}

resource "aws_docdb_cluster_parameter_group" "this" {
  family      = var.docdb_familyversion
  name        = "${var.projectname}-${var.environment}-documentdb-parametergroup"
  description = "Parameter group in use by ${var.projectname}-${var.environment} clusters"

  parameter {
    name  = "tls"
    value = var.docdb_tlsEnable
  }

  parameter {
    name  = "profiler"
    value = var.docdb_profilerEnable
  }
}

resource "aws_security_group" "this" {
  name        = "documentdb-sg"
  description = "DocumentDB Security Group"
  vpc_id      = var.vpc

  ingress {
    from_port = 27017
    to_port   = 27017
    protocol  = "tcp"

    security_groups = [
      var.vpn_sg,
      var.eb_nodesSecuritygroup
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Project = var.projectname
    Stages  = var.environment
  }
}

resource "aws_docdb_cluster" "this" {
  cluster_identifier              = "${var.projectname}-${var.environment}-documentdb-cluster"
  engine                          = "docdb"
  master_username                 = "${var.projectname}${var.environment}admin"
  master_password                 = var.docdb_masterPassword
  port                            = var.docdb_port
  backup_retention_period         = 5
  preferred_backup_window         = "01:00-03:00"
  skip_final_snapshot             = true
  apply_immediately               = true
  #snapshot_identifier     = "${var.projectname}-${var.environment}-documentdb-snapshot-${replace("${timestamp()}", "/[-| |T|Z|:]/", "")}"
  storage_encrypted               = var.docdb_storageEncrypted
  db_cluster_parameter_group_name = aws_docdb_cluster_parameter_group.this.name
  db_subnet_group_name            = aws_docdb_subnet_group.this.name
  vpc_security_group_ids          = [aws_security_group.this.id]

  tags = {
    Project = var.projectname
    Stages  = var.environment
  }
}

resource "aws_docdb_cluster_instance" "this" {
  count              = var.docdb_instanceNumber
  identifier         = "${var.projectname}-${var.environment}-documentdb-node-${count.index}"
  cluster_identifier = aws_docdb_cluster.this.id
  instance_class     = var.docdb_instanceType
}
