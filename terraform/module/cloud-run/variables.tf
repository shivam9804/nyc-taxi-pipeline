variable "project_id" {
  description = "The ID of the project in which the resource belongs."
  type        = string
}

variable "location" {
  description = "The location of the cloud run service."
  type        = string
}

variable "labels" {
  description = "The labels for the cloud run service."
  type        = map(string)
  default     = {}
}

variable "name" {
  description = "The name of the cloud run service."
  type        = string
}

variable "image" {
  description = "The container image to deploy."
  type        = string
}

variable "secret_environment_name" {
  description = "The name of the secret environment variable to be used in the cloud run service."
  type        = string
}

variable "cloud_run_cpu" {
  description = "The CPU limit for the Cloud Run service."
  type        = string
  default     = "2"
}

variable "cloud_run_memory" {
  description = "The memory limit for the Cloud Run service."
  type        = string
  default     = "1024Mi"
}

variable "cloud_run_min_instance_count" {
  description = "The minimum number of instances for the Cloud Run service."
  type        = number
  default     = 1
}

variable "cloud_run_max_instance_count" {
  description = "The maximum number of instances for the Cloud Run service."
  type        = number
  default     = 10
}