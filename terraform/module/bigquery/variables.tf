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
