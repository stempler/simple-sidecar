#!/bin/sh

TARGET_FILE=/etc/nginx/conf.d/default.conf

echo "Generating nginx configuration..."
cat <<EOT > $TARGET_FILE
resolver 127.0.0.1 ipv6=off;
server {
  set \$upstream_service http://$SERVICE_HOST:$SERVICE_PORT;
  server_name _;
  listen [::]:$SERVICE_PORT;
  listen $SERVICE_PORT;
  location / {

    rewrite ^ \$request_uri;
    rewrite ^//?(.*) /$1 break;
    return 400;
    
    proxy_pass \$upstream_service\$uri;
    proxy_read_timeout 9000;
    proxy_http_version 1.1;

  }
}
EOT
