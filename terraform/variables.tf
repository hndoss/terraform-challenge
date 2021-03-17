variable "aws_access_key_id" {
  description = "Specifies the AWS access key used as part of the credentials to authenticate the user"
  type        = string
}

variable "aws_secret_access_key" {
  description = "Specifies the AWS secret key used as part of the credentials to authenticate the user"
  type        = string
}

variable "aws_region" {
  description = "Specifies the AWS Region to send the request to"
  type        = string
}

variable "project" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Name of the environment"
  type        = string
}