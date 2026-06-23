output "lake_id" {
  description = "The ID of the Dataplex lake."
  value       = google_dataplex_lake.nyc_taxi_lake.id
}

output "raw_zone_id" {
  description = "The ID of the Dataplex raw zone."
  value       = google_dataplex_zone.raw_zone.id
}

output "curated_zone_id" {
  description = "The ID of the Dataplex curated zone."
  value       = google_dataplex_zone.curated_zone.id
}

output "asset_id" {
  description = "The ID of the Dataplex asset."
  value       = google_dataplex_asset.nyc_taxi_curated_asset.id
}