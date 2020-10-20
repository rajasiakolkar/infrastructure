# variables.tf
variable "profile" {
     type = string
}
variable "region" {
     type = string
}
variable "SGApplication" {
    type = string
}
variable "vpc_id" {
    type = string
}
variable "aws_security_group_protocol" {
    type = string
}
variable "SGDatabase" {
    type = string
}
variable "db_name" {
    type = string
}
variable "db_allocated_storage" {
    type = number
}
variable "db_engine" {
    type = string
}
variable "db_engine_version" {
    type = number
}
variable "db_instance" {
    type = string
}
variable "db_multi_az" {
    type = string
}
variable "db_identifier" {
    type = string
}
variable "db_username" {
    type = string
}
variable "db_password" {
    type = string
}
variable "db_publicly_accessible" {
    type = string
}
variable "db_skip_final_snapshot" {
    type = string
}
variable "dynamoDB_name" {
    type = string
}
variable "dynamoDB_hashKey" {
    type = string
}
variable "dynamoDB_writeCapacity" {
    type = number
}
variable "dynamoDB_readCapacity" {
    type = number
}
variable "ami" {
    type = string
}
variable "instance_type" {
    type = string
}
variable "disable_api_termination" {
    type = string
}
variable "key_name" {
    type = string
}
variable "volume_size" {
    type = number
}
variable "volume_type" {
    type = string
}
variable "s3_bucket" {
    type = string
}
variable "s3_acl" {
    type = string
}
variable "s3_force_destroy" {
    type = string
}
variable "s3_bucket_name" {
    type = string
}
variable "s3_lifecycle_id" {
    type = string
}
variable "s3_lifecycle_enabled" {
    type = string
}
variable "s3_lifecycle_transition_days" {
    type = number
}
variable "s3_lifecycle_transition_storage_class" {
    type = string
}
variable "delete_on_termination" {
    type = string
}
variable "device_name" {
    type = string
}
variable "aws_db_endpoint" {
    type = string
}

# end of variables.tf