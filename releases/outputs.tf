//Helm release outputs

output "manifest" {
  value = helm_release.nginx.manifest
}

output "chart" {
  value = helm_release.nginx.metadata.chart
}