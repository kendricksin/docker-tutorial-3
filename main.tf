# main.tf
provider "docker" {
  host = "unix:///var/run/docker.sock"
}

resource "docker_image" "ubuntu" {
  name = "ubuntu:20.04"
  keep_locally = false
}

resource "docker_container" "ubuntu" {
  name  = "ubuntu_container"
  image = docker_image.ubuntu.latest

  # Expose port 22 for SSH (optional)
  ports {
    internal = 22
    external = 2222
  }

  # Commands to keep the container running
  entrypoint = ["/bin/bash", "-c", "while true; do sleep 1000; done"]
}
