resource "google_cloud_run_v2_service" "cloud_run_service" {
  name     = var.name
  location = var.location
  project  = var.project_id

  scaling {
    min_instance_count = var.cloud_run_min_instance_count
    max_instance_count = var.cloud_run_max_instance_count
  }

  template {
    containers {
      image = var.image
      resources {
        limits = {
          cpu    = var.cloud_run_cpu
          memory = var.cloud_run_memory
        }
      }
      env {
        name = "ENV"
        value_source {
          secret_key_ref {
            secret  = var.secret_environment_name
            version = "latest"
          }
        }
      }
    }
  }

  traffic {
    percent = 100
    type    = "TRAFFIC_TARGET_ALLOCATION_TYPE_LATEST"
  }

  labels = var.labels

}