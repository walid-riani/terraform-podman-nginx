terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.6"
    }
  }
}

# 📦 Docker provider configuratie (via Podman socket)
provider "docker" {
  host = "tcp://localhost:2375"
}

# 🔽 Pull het Nginx image
resource "docker_image" "nginx" {
  name = "nginx:latest"
}

# 🚀 Start een container op basis van het Nginx image
resource "docker_container" "nginx" {
  name  = "nginx-server"
  image = docker_image.nginx.image_id

  # ✅ Gebruik Podman's standaard bridge-netwerk
  network_mode = "bridge"

  # 🌍 Poort-mapping: hostpoort 8081 → containerpoort 80
  ports {
    internal = 80
    external = 8081
  }

  # 🟢 Zorg dat container opnieuw opstart bij reboot (optioneel)
  restart = "always"
}
