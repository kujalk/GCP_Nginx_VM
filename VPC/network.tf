
#VPC
resource "google_compute_network" "vpc_network" {
  name                    = "${var.project_name}-vpc"
  auto_create_subnetworks = false
  routing_mode            = "GLOBAL"
}

#Public Subnet
resource "google_compute_subnetwork" "public" {
  name                     = "${var.project_name}-public-subnet"
  ip_cidr_range            = var.public_cidr
  region                   = var.region
  network                  = google_compute_network.vpc_network.id
  private_ip_google_access = false
}

#Private
resource "google_compute_subnetwork" "private" {
  name                     = "${var.project_name}-private-subnet"
  ip_cidr_range            = var.private_cidr
  region                   = var.region
  network                  = google_compute_network.vpc_network.id
  private_ip_google_access = true
}