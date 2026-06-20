resource "google_bigquery_dataset" "dataset" {
  project                     = var.project_id
  dataset_id                  = var.dataset_id
  location                    = var.location
  labels                      = var.labels
  default_table_expiration_ms = var.expiration_ms
  delete_contents_on_destroy  = false
}

resource "google_bigquery_dataset_iam_member" "access" {
  for_each = { for idx, access in var.dataset_access : "${idx}" => access }

  project    = var.project_id
  dataset_id = google_bigquery_dataset.dataset.dataset_id
  role       = each.value.role
  member     = each.value.member
}
