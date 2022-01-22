provider "google" {
  credentials = "E:\\Test\\ssh-test-6335-542424d.json"
  project     = "ssh-test-52265"
}

module "gcp-network" {
  source       = "./VPC"
  region       = "us-central1"
  project_name = "upwork"
  public_cidr  = "192.168.10.0/24"
  private_cidr = "192.168.20.0/24"
}

module "gcp-compute" {
  source       = "./Compute"
  project_name = "upwork"
  zone         = "us-central1-c"
  meta_script  = "E:\\Test\\BootScript.sh"
  machine_type = "e2-small"
  network      = module.gcp-network.vpc
  subnetwork   = module.gcp-network.public-subnet
  image        = "debian-cloud/debian-10"
}

output "vm-ip"{
    value = module.gcp-compute.vm-ip-address
}