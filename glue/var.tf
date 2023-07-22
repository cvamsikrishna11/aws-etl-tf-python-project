variable "project_name" {
  description = "Project name" 
}

variable "catalog_db" {
  description = "Glue data catalog db"
  type        = string
}

variable "iam_role_arn" {
  description = "IAM role arn for access"
  type        = string
}

variable "glue_crawler_name" {
  description = "Crawler name"
  type        = string
}

variable "glue_job_name" {
  description = "glue job name"
  type        = string
}

variable "s3_data_source_target_path" {
  description = "S3 location of datasource"
  type        = string
}

variable "s3_script_location_path" {
  description = "S3 location of glue job python script"
  type        = string
}

variable "s3_temp_location_path" {
  description = "S3 location of glue job temp dir"
  type        = string
}

variable "common_tags" {
  description = "Common tags across the application"
  type        = map(string)
}