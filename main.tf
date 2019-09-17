resource "aws_docdb_subnet_group" "docdb" {
  name = "${var.projectname}-${var.environment}-documentdb-subnetgroup"

  subnet_ids = [
    "${var.priv-subnet-1}",
    "${var.priv-subnet-2}",
    "${var.priv-subnet-3}",
  ]

  tags {
    Project = "${var.project}"
    Stages  = "${var.stage}"
  }
}

resource "aws_docdb_cluster_parameter_group" "docdb" {
  family      = "${var.docdb_familyversion}"
  name        = "${var.projectname}-${var.environment}-documentdb-parametergroup"
  description = "Parameter group in use by ${var.projectname}-${var.environment} clusters"

  parameter {
    name  = "tls"
    value = "${var.docdb_tlsEnable}"
  }

  parameter {
    name  = "profiler"
    value = "${var.docdb_profilerEnable}"
  }
}

resource "aws_security_group" "docdb" {
  name        = "documentdb-sg"
  description = "DocumentDB Security Group"
  vpc_id      = "${var.vpc}"

  ingress {
    from_port = 27017
    to_port   = 27017
    protocol  = "tcp"

    security_groups = [
      "${var.vpn-sg}"
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Project = "${var.project}"
    Stages  = "${var.stage}"
  }
}

resource "aws_docdb_cluster" "docdb_cluster" {
  cluster_identifier      = "${var.projectname}-${var.environment}-documentdb-cluster"
  engine                  = "docdb"
  master_username         = "${var.projectname}-${var.environment}-admin"
  master_password         = "${var.docdb_masterPassword}"
  port                    = "${var.docdb_port}"
  backup_retention_period = 5
  preferred_backup_window = "01:00-03:00"
  skip_final_snapshot     = false
  storage_encrypted       = "${var.docdb_storageEncrypted}"
  vpc_security_group_ids  = "${aws_security_group.docdb.id}"

  tags {
    Project = "${var.project}"
    Stages  = "${var.stage}"
  }
}

resource "aws_docdb_cluster_instance" "docdb_cluster_instances" {
  count              = "${var.docdb_instanceNumber}"
  identifier         = "${var.projectname}-${var.environment}-documentdb-node-${count.index}"
  cluster_identifier = "${aws_docdb_cluster.docdb_cluster.id}"
  instance_class     = "${var.docdb_instanceType}"
}