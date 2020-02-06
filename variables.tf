variable "projectname" {
  default = ""
  type    = string
}

variable "environment" {
  default = ""
  type    = string
}

variable "vpc" {
  description = "The ID of the VPC where will be created"
  default     = ""
  type        = string
}

variable "vpn_sg" {
  description = "The ID of the VPN server"
  default     = ""
  type        = string
}

variable "eb_nodesSecuritygroup" {
  description = "The ID of the VPN server"
  default     = ""
}


variable "priv-subnet-1" {
  description = "Private Subnet 1 ID"
  default     = ""
  type        = string
}

variable "priv-subnet-2" {
  description = "Private Subnet 2 ID"
  default     = ""
  type        = string
}

variable "priv-subnet-3" {
  description = "Private Subnet 3 ID"
  default     = ""
  type        = string
}

variable "docdb_familyversion" {
  description = "Version to launch on documentdb (MONGODB compatibility)"
  default     = "docdb3.6"
  type        = string
}

variable "docdb_tlsEnable" {
  description = "Set TLS communication to/from DocumentDB cluster"
  default     = "false"
  type        = string
}

variable "docdb_profilerEnable" {
  description = "Set mongodb profiler on/off"
  default     = "false"
  type        = string
}

variable "docdb_masterPassword" {
  description = "Password for DocumentDB admin"
  default     = "changeme"
  type        = string
}

variable "docdb_port" {
  description = "Port where DocumentDB will be accesed"
  default     = "27017"
  type        = string
}

variable "docdb_storageEncrypted" {
  description = "Set DocumentDB storage encryption at rest"
  default     = "true"
  type        = string
}

variable "docdb_instanceNumber" {
  description = "Number of instances to launch within the cluster"
  default     = "1"
  type        = string

}

variable "docdb_instanceType" {
  description = "Type of instance to launch into DocumentDB cluster"
  default     = "db.r5.large"
  type        = string
}
