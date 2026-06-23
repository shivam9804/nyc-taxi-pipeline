variable "name" {
  description = "The name of the secret manager."
  type        = string
}

variable "labels" {
  description = "The labels for the secret manager."
  type        = map(string)
  default     = {}
}
