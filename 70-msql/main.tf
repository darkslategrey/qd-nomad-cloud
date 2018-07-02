provider "google" {
  project = "courseur-staging"
}

resource "google_sql_database_instance" "staging" {
  name = "staging-mysql"
  region = "europe-west2"
  database_version = "MYSQL_5_6"

  settings {
    tier = "db-f1-micro"
    # tier = "D0"
    # database_version = "MYSQL_5_6"
  }
}

resource "google_sql_database" "lp" {
  name      = "lp"
  instance  = "${google_sql_database_instance.staging.name}"
  charset   = "latin1"
  collation = "latin1_swedish_ci"
}

resource "google_sql_database" "lm" {
  name      = "lm"
  instance  = "${google_sql_database_instance.staging.name}"
  charset   = "latin1"
  collation = "latin1_swedish_ci"
}

resource "google_sql_database" "metro" {
  name      = "metro"
  instance  = "${google_sql_database_instance.staging.name}"
  charset   = "latin1"
  collation = "latin1_swedish_ci"
}

resource "google_sql_user" "users" {
  name     = "courseur"
  instance = "${google_sql_database_instance.staging.name}"
  host     = "%"
  # password = "changeme"
}

# TODO: creation d'un service account dedie pour le sql proxy
# mysql url 
# courseur-staging:europe-west2:staging-mysql
