variable "lake_name" {
  type    = string
  default = "Name of the data lake"
}

variable "lake_location" {
  type    = string
  default = "Location of the data lake"
}

variable "lake_description" {
  type    = string
  default = "Description of the data lake"
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
  type    = string
  default = "GCP project ID"
}

variable "dataset_id" {
  type        = string
  description = "The ID of the dataset."
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
