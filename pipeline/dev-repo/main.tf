provider "google" {
  credentials = file("credential.json")
  project     = "sandbox-ctcheumadjeu"
  region      = "europe-west1"
}


# Activer certains services
variable "service_list" {
  description = "The list of apis necessary for the project"
  type        = list(string)
  default     = ["cloudbuild.googleapis.com", "sourcerepo.googleapis.com", "containeranalysis.googleapis.com", "container.googleapis.com"]
}
resource "google_project_service" "service_project" {
  for_each = toset(var.service_list)
  service = each.key
}

variable "sa" {
  type    = string
  default = "test-algo@sandbox-ctcheumadjeu.iam.gserviceaccount.com"
}
resource "google_container_cluster" "primary" {
  name     = "my-gke-cluster"
  location = "europe-west1-b"

  remove_default_node_pool = true
  initial_node_count       = 1
}

# création d'un cluster
resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "my-node-pool"
  location   = "europe-west1-b"
  cluster    = google_container_cluster.primary.name
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = "e2-medium"

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = "test-algo@sandbox-ctcheumadjeu.iam.gserviceaccount.com"
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}

# Créez 2 repos
variable "repo_list" {
  description = "The list of repo we need"
  type        = list(string)
  default     = ["dev-repo", "prod-repo"]
}

resource "google_sourcerepo_repository" "repos" {
  for_each = toset(var.repo_list)
  name     = each.key
}

#Creation du déclencheur dev
resource "google_cloudbuild_trigger" "cloud_build_trigger" {
  name        = "dev-trigger"
  description = "Cloud Source Repository Trigger master branch on dev-repo"

  trigger_template {
    branch_name = "master"
    repo_name   = "dev-repo"
  }

  filename = "cloudbuild.yaml"
}

# Création du déclencheur prod
resource "google_cloudbuild_trigger" "cloud_build_prod" {
  name        = "prod-trigger"
  description = "Cloud Source Repository Trigger master branch on prod-repo"

  trigger_template {
    branch_name = "prod"
    repo_name   = "prod-repo"
  }

  filename = "cloudbuild.yaml"
}
