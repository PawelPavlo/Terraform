#  resource "google_compute_backend_service" "default" {
#    name        = "backend"
#    port_name   = "http"
#    protocol    = "HTTP"
#    timeout_sec = 10
#    health_checks = [google_compute_http_health_check.autohealing.id]
#  }
#    backend {
#     group = google_compute_region_instance_group_manager.aappserver.id
#   #"google_compute_region_instance_group_manager" "aappserver"
#   }

# resource "google_compute_global_forwarding_rule" "default" {
#   name       = "global-rule"
#   target     = google_compute_target_http_proxy.default.id
#   port_range = "80"
# }

# resource "google_compute_target_http_proxy" "default" {
#   name        = "target-proxy"
#   description = "a description"
#   url_map     = google_compute_url_map.default.id
# }

# resource "google_compute_url_map" "default" {
#   name            = "url-map-target-proxy"
#   description     = "a description"
#   default_service = google_compute_backend_service.default.id


#     path_rule {
#       paths   = ["/"]
#       service = google_compute_backend_service.default.id
#     }
#   }
# resource "google_compute_global_network_endpoint_group" "external_proxy" {
#   provider = google-beta
#   name                  = "network-endpoint"
#   network_endpoint_type = "INTERNET_FQDN_PORT"
#   default_port          = "443"
# }
