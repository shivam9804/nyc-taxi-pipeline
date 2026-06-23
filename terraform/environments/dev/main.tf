module "bigquery_dataset" {
  source = "../../module/bigquery"

  project_id     = var.project_id
  dataset_id     = var.dataset_id
  location       = var.location
  labels         = var.labels
  expiration_ms  = var.expiration_ms
  dataset_access = var.dataset_access
}

module "secret_manager" {
  source = "../../module/secret-manager"

  name   = var.secret_environment_name
  labels = var.labels
}


module "cloud_run" {
  source = "../../module/cloud-run"

  name                         = var.cloud_run_service_name
  location                     = var.location
  labels                       = var.cloud_run_labels
  image                        = var.cloud_run_image
  project_id                   = var.project_id
  cloud_run_cpu                = var.cloud_run_cpu
  cloud_run_memory             = var.cloud_run_memory
  cloud_run_min_instance_count = var.cloud_run_min_instance_count
  cloud_run_max_instance_count = var.cloud_run_max_instance_count
  secret_environment_name      = module.secret_manager.environment_name
}

module "dataplex" {
  source = "../../module/dataplex"

  lake_name         = var.lake_name
  lake_location     = var.lake_location
  lake_description  = var.lake_description
  lake_display_name = var.lake_display_name
  lake_labels       = var.lake_labels
  project_id        = var.project_id
  dataset_id        = module.bigquery_dataset.dataset_id
  raw_zone_name     = var.raw_zone_name
  curated_zone_name = var.curated_zone_name
}