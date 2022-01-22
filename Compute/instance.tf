data "template_file" "user_data" {
  template = file(var.meta_script)
}

# instance template
resource "google_compute_instance" "default" {
  name         = "${var.project_name}-vm"
  zone         = var.zone
  machine_type = var.machine_type
  tags         = [var.project_name]

  network_interface {
    network    = var.network
    subnetwork = var.subnetwork
    access_config {
      # add external ip to fetch packages
    }
  }
  boot_disk {
    initialize_params {
      image = var.image
    }
  }
  metadata = {
    startup-script = data.template_file.user_data.rendered
  }

  lifecycle {
    create_before_destroy = true
  }
}


#Allow port 22,80 for testing
resource "google_compute_firewall" "allow-ssh" {
  name          = "${var.project_name}-fw-allow-ssh-http"
  direction     = "INGRESS"
  network       = var.network
  source_ranges = ["0.0.0.0/0"]
  allow {
    protocol = "tcp"
    ports    = ["22", "80"]
  }
  target_tags = [var.project_name]
}