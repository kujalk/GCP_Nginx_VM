output "vpc" {
  value = google_compute_network.vpc_network.id
}

output "public-subnet" {
  value = google_compute_subnetwork.public.id
}

output "private-subnet" {
  value = google_compute_subnetwork.private.id
}