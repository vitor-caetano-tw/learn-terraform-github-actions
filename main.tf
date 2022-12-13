terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.45.0"
    }
  }
  required_version = ">= 1.1.0"

  # cloud {
  #   organization = "telus-fourkeys"

  #   workspaces {
  #     name = "gh-actions-demo"
  #   }
  # }
}

terraform {
  backend "gcs" {
    bucket = "fourkeys-31337-tf-state"
    prefix = "terraform-dummy/state"
  }
}
variable "gcp_creds" {
  default = ""
}

provider "google" {
  credentials = var.gcp_creds

  project = "fourkeys-31337"
  region  = "us-central1"
  zone    = "us-central1-c"
}

module "gcloud_build_event_handler" {
  source                 = "terraform-google-modules/gcloud/google"
  version                = "~> 2.0"
  create_cmd_entrypoint  = "gcloud"
  create_cmd_body        = "iam service-accounts list"
}

# resource "google_compute_network" "vpc_network" {
#   name = "terraform-network"
# }

# resource "google_compute_instance" "vm_instance" {
#   name         = "terraform-instance"
#   machine_type = "f1-micro"

#   boot_disk {
#     initialize_params {
#       image = "debian-cloud/debian-11"
#     }
#   }

#   network_interface {
#     network = google_compute_network.vpc_network.name
#     access_config {
#     }
#   }
# }
