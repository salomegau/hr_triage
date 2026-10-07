output "api_container_id" {
  description = "ID of the API container"
  value       = docker_container.api_container.id
}

output "ui_container_id" {
  description = "ID of the UI container"
  value       = docker_container.ui_container.id
}