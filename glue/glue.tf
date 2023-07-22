resource "aws_glue_catalog_database" "db" {
  name = "${var.project_name}-${terraform.workspace}-${var.catalog_db}"

  tags = merge({ Environment = "${terraform.workspace}" }, var.common_tags)
}

resource "aws_glue_crawler" "crawler" {
  database_name = aws_glue_catalog_database.db.name

  role          = var.iam_role_arn
  name          = "${var.project_name}-${terraform.workspace}-${var.glue_crawler_name}"
  description   = "crawler to read the netflix dataset and create tables on the Glue"
  

  s3_target {
    path = var.s3_data_source_target_path
  }

  schema_change_policy {
    delete_behavior = "LOG"
    update_behavior = "UPDATE_IN_DATABASE"
  }

  tags = merge({ Environment = "${terraform.workspace}" }, var.common_tags)
}



resource "aws_glue_job" "glue_job" {
  name     = "${var.project_name}-${terraform.workspace}-${var.glue_job_name}"
  role_arn = var.iam_role_arn

  glue_version = "4.0"
  command {
    script_location = var.s3_script_location_path
    python_version  = "3"
  }

  default_arguments = {
    "--TempDir" = var.s3_temp_location_path
    "--enable-job-insights"=	true
    "--job-language"= "python"
  }

  execution_property {
    max_concurrent_runs = 1
  }

  max_retries = 0

  tags = merge({ Environment = "${terraform.workspace}" }, var.common_tags)
}
