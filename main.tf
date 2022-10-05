terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.22.0"
    }
  }

  backend "gcs" {
    bucket  = "ktwl-tf-backend"
    prefix  = "github.com/kelvintaywl/tf/state"
  }
}

provider "docker" {}

resource "docker_network" "learntf" {
  name = "learntf"
}

resource "docker_image" "postgresdb" {
  name         = var.postgresdb_image
  keep_locally = false
}

resource "docker_image" "postgrest" {
  name         = var.postgrest_image
  keep_locally = false
}

resource "docker_container" "postgresdb" {
  image = docker_image.postgresdb.name
  name  = "db"
  ports {
    internal = 5432
    external = var.postgresdb_container_port
  }
  env = var.postgresdb_container_envs
  mounts {
    type   = "bind"
    target = "/docker-entrypoint-initdb.d"
    source = var.postgresdb_container_mount_source
  }
  networks_advanced {
    name = docker_network.learntf.name
  }
}

resource "docker_container" "postgrest" {
  image = docker_image.postgrest.name
  name  = "server"
  ports {
    internal = 3000
    external = var.postgrest_container_port
  }
  env = var.postgrest_container_envs
  networks_advanced {
    name = docker_network.learntf.name
  }
}
