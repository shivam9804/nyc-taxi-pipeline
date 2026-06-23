variable "project_id" {
  description = "The ID of the project in which the resource belongs."
  type        = string
}

variable "dataset_id" {
  description = "The ID of the dataset."
  type        = string
}

variable "location" {
  description = "The location of the dataset."
  type        = string
}

variable "labels" {
  description = "The labels for the dataset."
  type        = map(string)
  default     = {}
}

variable "expiration_ms" {
  description = "The default lifetime of all tables in the dataset, in milliseconds. The minimum value is 3600000 milliseconds (one hour)."
  type        = number
  default     = null
}

variable "dataset_access" {
  description = "A list of dataset access entries."
  type = list(object({
    role   = string
    member = string
  }))
  default = []
}

variable "cloud_run_service_name" {
  description = "The name of the Cloud Run service."
  type        = string
  default     = "my-cloud-run"
}

variable "cloud_run_labels" {
  description = "The labels to apply to the Cloud Run service."
  type        = map(string)
  default     = {}
}

variable "cloud_run_image" {
  description = "The container image to deploy to Cloud Run."
  type        = string
  default     = "gcr.io/my-project/my-image:latest"
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

variable "secret_environment_name" {
  description = "The name of the secret environment variable to be used in the Cloud Run service."
  type        = string
}

variable "lake_name" {
  type        = string
  description = "Name of the data lake"
}

variable "lake_location" {
  type        = string
  description = "Location of the data lake"
}

variable "lake_description" {
  type        = string
  description = "Description of the data lake"
}

variable "lake_display_name" {
  type    = string
  default = "Display name of the data lake"
}

variable "lake_labels" {
  type    = map(string)
  default = {}
}

variable "project_id" {
  type        = string
  description = "GCP project ID"
}

variable "raw_zone_name" {
  type        = string
  description = "The name of the raw zone."
  default     = "raw_zone"
}

variable "curated_zone_name" {
  type        = string
  description = "The name of the curated zone."
  default     = "curated_zone"
}
