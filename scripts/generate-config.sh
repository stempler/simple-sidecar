#!/bin/sh

TARGET_FILE=/etc/nginx/conf.d/default.conf

echo "Generating nginx configuration..."
cat <<EOT > $TARGET_FILE
resolver 127.0.0.11 ipv6=off;
server {
  set \$upstream_service http://$SERVICE_HOST:$SERVICE_PORT;
  server_name _;
  listen [::]:$SERVICE_PORT;
  listen $SERVICE_PORT;

  # Allow special characters in headers
  ignore_invalid_headers off;
  # Allow any size file to be uploaded.
  # Set to a value such as 1000m; to restrict file size to a specific value
  client_max_body_size 0;
  # Disable buffering
  proxy_buffering off;
  proxy_request_buffering off;

  location / {
    proxy_set_header Host \$http_host;
    proxy_set_header X-Real-IP \$remote_addr;
    proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto \$scheme;

    proxy_connect_timeout 300;
    # Default is HTTP/1, keepalive is only enabled in HTTP/1.1
    proxy_http_version 1.1;
    proxy_set_header Connection "";
    chunked_transfer_encoding off;

    proxy_pass \$upstream_service;
  }
}
EOT
