variable "s3_static" {
    type = string
    description = "provide the bucket name and tag value to the bucket which you creating"
}

variable "s3_static_acl" {
    type = string
    description = "mention the required acl to the bucket"
}