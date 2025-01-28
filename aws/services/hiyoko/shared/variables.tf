# global
variable "project" {
  description = "The project name"
  type        = string
  default     = "hiyoko"
}

variable "domain" {
  description = "The Domain"
  type        = string
  default     = "example.com"
}

variable "environment" {
  description = "The environment (e.g., develop, staging, production, shared)"
  type        = string
  default     = "shared"
}
