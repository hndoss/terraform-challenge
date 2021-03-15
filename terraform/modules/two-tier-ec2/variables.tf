variable "project" {
  description = "Name of the project."
  type        = string
}

variable "environment" {
  description = "Name of the environment."
  type        = string
}

variable "public_autoscaling_groups" {
  description = "Public autoscaling configuration."
  type = set(object({
    name                = string
    image_id            = string
    instance_type       = string
    ssh_key_name        = string
    min_size            = number
    max_size            = number
    desired_capacity    = number
    default_cooldown    = string
    vpc_zone_identifier = list(string)
    security_groups     = list(string)
  }))
}

variable "private_autoscaling_groups" {
  description = "Private autoscaling configuration."
  type = set(object({
    name                = string
    image_id            = string
    instance_type       = string
    ssh_key_name        = string
    min_size            = number
    max_size            = number
    desired_capacity    = number
    default_cooldown    = string
    vpc_zone_identifier = list(string)
    security_groups     = list(string)
  }))
}

variable "target_group_arns" {
  description = "List of the Target group ARNS to register the private autoscaling group"
  type        = list(string)
}
