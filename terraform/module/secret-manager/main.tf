resource "google_secret_manager_secret" "secret" {
  secret_id = var.name
  
  labels = var.labels

  replication {
    auto {}
  }
}