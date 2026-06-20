project_id = "my-gcp-project-id"
dataset_id = "my_dataset"
location = "US"
dataset_access = [
  {
    role   = "roles/bigquery.dataViewer"
    member = "serviceAccount:dataform-sa@data-engineering.iam.gserviceaccount.com"
  },
  {
    role   = "roles/bigquery.dataEditor"
    member = "serviceAccount:dataform-sa@data-engineering.iam.gserviceaccount.com"
  }
]
secret_environment_name = "dev-environment"
cloud_run_service_name = "my-cloud-run-service"
cloud_run_image = "gcr.io/my-gcp-project-id/my-cloud-run-image:latest"
cloud_run_cpu = 1
cloud_run_memory = "512Mi"
cloud_run_min_instance_count = 0
cloud_run_max_instance_count = 5
cloud_run_labels = {
  environment = "dev"
  team        = "data-engineering"
}