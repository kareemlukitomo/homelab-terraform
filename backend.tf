terraform {
  backend "gcs" {
    bucket  = "shaquillekareem"
    prefix  = "terraform/state"
    credentials = "/tmp/gcs_credentials.json"
  }
}
