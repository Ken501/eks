//Helm release outputs

output "manifest" {
  value = helm_release.nginx.manifest
}