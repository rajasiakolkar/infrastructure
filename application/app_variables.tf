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
variable "most_recent" {
    type = string
}
variable "dev_id" {
    type = string
}
variable "vpcName" {
    type = string
}
variable "vpcCIDRblock" {
    type = string
}
variable "subnetCIDRblock1" {
    type = string
}
variable "subnetCIDRblock2" {
    type = string
}
variable "subnetCIDRblock3" {
    type = string
}
variable "application_name" {
    type = string
}
variable "compute_platform" {
    type = string
}
variable "iam_policy_name" {
    type = string
}
variable "iam_username" {
    type = string
}
variable "GH_Upload_To_S3_policy_name" {
    type = string
}
variable "codeDeployBucket" {
    type = string
}
variable "GH_Code_Deploy_policy_name" {
    type = string
}
variable "CodeDeploy_EC2_S3_policy_name" {
    type = string
}
variable "code_deploy_ec2_service_role_name" {
    type = string
}
variable "account_id" {
    type = string
}
variable "domain" {
    type = string
}

# end of variables.tf