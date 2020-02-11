output "docdb_host" {
    value = aws_docdb_cluster.docdb_cluster.endpoint
}
