variable "region" {
	type = string
	default = "us-east-1"
}

variable "prefix" {
	type = string
	default = "techno"
}

variable "environment" {
	type = string
	default = "Production"
}

variable "name" {
	type = string
	default = "raihan"
}

variable "city" {
	type = string
	default = "jakartapusat"
}

variable "labRoleARN" {
	type = string
	default = "arn:aws:iam::523842163503:role/LabRole"
}

variable "adminEmail" {
	type = string
	default = "handi@seamolec.org"
}
