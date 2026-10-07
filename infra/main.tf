terraform {
  required_version = ">= 1.0"
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "4.0.0"
    }
  }
}

provider "docker" {}

resource "docker_network" "group_network" {
  name = "g03-network"
}

resource "docker_volume" "sqlite_volume" {
  name = "g03-sqlite-data"
}

resource "docker_image" "app" {
  name         = "hr-triage:latest"
  keep_locally = true
}

resource "docker_container" "api_container" {
  image = docker_image.app.image_id
  name  = "g03-api-container"

  networks_advanced {
    name = docker_network.group_network.name
  }

  mounts {
    target = "/app/data"
    source = docker_volume.sqlite_volume.name
    type   = "volume"
  }

  ports {
    internal = 8000
    external = 8003
  }
}

resource "docker_container" "ui_container" {
  image = docker_image.app.image_id
  name  = "g03-ui-container"

  networks_advanced {
    name = docker_network.group_network.name
  }

  ports {
    internal = 8500
    external = 8503
  }
}