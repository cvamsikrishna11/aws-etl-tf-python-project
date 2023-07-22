variable "project_name" {
  description = "Project name" 
}

variable "table_name" {
  description = "The name of the DynamoDB table"
  type        = string  
}

variable "read_capacity" {
  description = "The read capacity for the DynamoDB table"
  type        = number
  default     = 20
}

variable "write_capacity" {
  description = "The write capacity for the DynamoDB table"
  type        = number
  default     = 20
}

variable "hash_key" {
  description = "The attribute to use as the hash key for the DynamoDB table"
  type        = string
  default     = "show_id"
}

variable "attribute_name" {
  description = "The name of the attribute"
  type        = string
  default     = "show_id"
}

variable "attribute_type" {
  description = "The type of the attribute"
  type        = string
  default     = "S"
}


variable "common_tags" {
  description = "Common tags across the application"
  type        = map(string)
}