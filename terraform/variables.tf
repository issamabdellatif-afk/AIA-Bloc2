variable "region" {
  description = "Région AWS"
  type        = string
  default     = "eu-west-3"
}

variable "instance_type" {
  description = "Type de EC2"
  type        = string
  default     = "t3.micro"
}

variable "owner" {
  description = "Etiquette Ressources Owner"
  type        = string
  default     = "issam-abdellatif"
}
