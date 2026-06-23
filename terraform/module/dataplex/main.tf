resource "google_dataplex_lake" "nyc_taxi_lake" {
  name         = var.lake_name
  location     = var.lake_location
  description  = var.lake_description
  display_name = var.lake_display_name
  labels       = var.lake_labels
}

resource "google_dataplex_zone" "raw_zone" {

  discovery_spec {
    enabled = true
  }

  lake     = google_dataplex_lake.nyc_taxi_lake.id
  location = var.lake_location
  name     = var.raw_zone_name

  resource_spec {
    location_type = "SINGLE_REGION"
  }

  type         = "RAW"
  description  = "Raw zone for the data lake"
  display_name = "Raw Zone"

  labels = var.lake_labels
}

resource "google_dataplex_zone" "curated_zone" {

  discovery_spec {
    enabled = true
  }

  lake     = google_dataplex_lake.nyc_taxi_lake.id
  location = var.lake_location
  name     = var.curated_zone_name

  resource_spec {
    location_type = "SINGLE_REGION"
  }

  type         = "CURATED"
  description  = "Curated zone for the data lake"
  display_name = "Curated Zone"

  labels = var.lake_labels
}

resource "google_dataplex_asset" "nyc_taxi_curated_asset" {
  name          = "nyc-taxi-curated-asset"
  lake          = google_dataplex_lake.nyc_taxi_lake.id
  dataplex_zone = google_dataplex_zone.curated_zone.id
  location      = var.lake_location

  resource_spec {
    name = "projects/${var.project_id}/datasets/${var.dataset_id}"
    type = "BIGQUERY_DATASET"
  }

  discovery_spec {
    enabled = true
  }

  description  = "Asset for the NYC taxi data in the curated zone"
  display_name = "NYC Taxi Asset"

  labels = var.lake_labels
}
