
# to store the datasets
module "s3_data_source" {
  source = "./s3"
  project_name = local.project_name
  bucket_name = "datasource-movies"
  common_tags = local.tags
}

# For target to store the transformed data
module "dynamodb" {
  source = "./dynamodb"
  project_name = local.project_name
  table_name = "movies-table"
  hash_key = "show_id"
  attribute_name = "show_id"
  attribute_type = "S"
  common_tags = local.tags
}

# For Glue IAM access on S3, DynamoDB, CloudWatch
module "iam" {
  source = "./iam"
  project_name = local.project_name
  iam_role_name = "etl-task-role" 
  common_tags = local.tags
}

# For Glue resources
module "glue" {
  source = "./glue"
  project_name = local.project_name
  catalog_db = "movies-database"
  iam_role_arn = module.iam.iam_role_arn
  glue_crawler_name = "movies-crawler"
  s3_data_source_target_path = "s3://netflix-${terraform.workspace}-datasource-movies/data-sources/netflix-movies/"
  glue_job_name = "movie-job"
  s3_script_location_path = "s3://netflix-${terraform.workspace}-datasource-movies/scripts/script.py"
  s3_temp_location_path = "s3://netflix-${terraform.workspace}-datasource-movies/temp-dir/"
  common_tags = local.tags
}
