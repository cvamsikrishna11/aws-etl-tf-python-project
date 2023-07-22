resource "aws_dynamodb_table" "netflix-movies-table" {
  name           = "${var.project_name}-${terraform.workspace}-${var.table_name}"
  billing_mode   = "PROVISIONED"
  read_capacity  = var.read_capacity
  write_capacity = var.write_capacity
  hash_key       = var.hash_key

  attribute {
    name = var.attribute_name
    type = var.attribute_type
  }

  tags = merge({ Environment = "${terraform.workspace}" }, var.common_tags)
}
