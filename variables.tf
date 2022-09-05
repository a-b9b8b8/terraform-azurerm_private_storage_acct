variable "rg_name" { type = string }
variable "rg_location" { type = string }
variable "tags" { type = map(string) }
variable "subnet_name" { type = string }
variable "vnet_rg_name" { type = string }
variable "vnet_name" { type = string }
variable "storage_acct_name" { type = string }
variable "account_tier" { type = string }
variable "replication_type" { type = string }
variable "priv_svc_connection_name" { type = string }
variable "subresource_name" { type = list(string) }
