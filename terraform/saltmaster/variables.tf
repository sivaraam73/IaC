variable "service_name"{
  
  default = "OVH-Service_name"
}

variable "deployment_instances" {

  description = "deployment name"
  type        = string
  default     = "SaltMsster"
}

variable "deployment_image" {

  description = "image name"
  type        = string
  default     = "AlmaLinux 9"

}

variable "deployment_flavor" {

  description = "machine type"
  type        = string
  default     = "d2-8"
}

variable "instance_count" {

  description = " number of instances"
  type        = number
  default     = 1
}


variable "pub_key" {
  type = string
  default = "~/.ssh/<public-key>"
}

variable "pvt_key" {
   type = string
   default = "~/.ssh/<private-key>"

}

variable "regions"{

  default=GRA5
}
