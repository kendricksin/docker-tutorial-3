terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

provider "docker" {
  host = "npipe:////./pipe/docker_engine"
}

resource "docker_image" "ubuntu" {
  name         = "ubuntu:20.04"
  keep_locally = false
}

resource "docker_container" "ubuntu_container" {
  name  = "ubuntu_container"
  image = docker_image.ubuntu.image_id

  ports {
    internal = 22
    external = 2222
  }

  entrypoint = ["/bin/bash", "-c", "while true; do sleep 1000; done"]
}
