output "sql_instance_connection_name" {
    value = google_sql_database_instance.sql_bookshelf.connection_name
}

output "sql_database_name" {
    value = google_sql_database.database.name
}

output "sql_user_password" {
    value = google_sql_user.users.password
    sensitive = true
}