terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.13"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

resource "docker_image" "ubuntu" {
  name         = "ubuntu:20.04"
  keep_locally = false
}

resource "docker_container" "ubuntu_container" {
  name  = "ubuntu_container"
  image = docker_image.ubuntu.latest

  ports {
    internal = 22
    external = 2222
  }

  entrypoint = ["/bin/bash", "-c", "while true; do sleep 1000; done"]
}
