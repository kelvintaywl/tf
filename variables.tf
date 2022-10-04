variable "postgresdb_image" {
  description = "Docker image name for postgresdb"
  type        = string
  default     = "library/postgres:13"
}

variable "postgresdb_container_port" {
  description = "Exposed port for the postgresdb container"
  type        = number
  default     = 5432
}

variable "postgresdb_container_mount_source" {
  description = "Mount source for init"
  type        = string
}

variable "postgresdb_container_envs" {
  description = "Env vars to load for postgresdb container (Set of String)"
  type        = set(string)
  default = [
    "POSTGRES_DB=wiki",
    "POSTGRES_USER=Free",
    "POSTGRES_PASSWORD=Willy"
  ]
}

variable "postgrest_image" {
  description = "Docker image name for postgrest"
  type        = string
  default     = "postgrest/postgrest"
}

variable "postgrest_container_port" {
  description = "Exposed port for the postgrest container"
  type        = number
  default     = 3000
}

variable "postgrest_container_envs" {
  description = "Env vars to load for postgrest container (Set of String)"
  type        = set(string)
  default = [
    "PGRST_DB_URI=postgres://Free:Willy@db:5432/wiki",
    "PGRST_DB_ANON_ROLE=Free",
    "PGRST_DB_SCHEMA=public",
    "PGRST_OPENAPI_SERVER_PROXY_URI=http://127.0.0.1:3000"
  ]
}
