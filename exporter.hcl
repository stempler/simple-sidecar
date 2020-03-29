# see https://github.com/martin-helmich/prometheus-nginxlog-exporter

listen {
  port = 6387
}

enable_experimental = true

namespace "nginx" {
  format = "$remote_addr - $remote_user [$time_local] \"$request\" $status $body_bytes_sent \"$http_referer\" \"$http_user_agent\" rt=$request_time uct=\"$upstream_connect_time\" uht=\"$upstream_header_time\" urt=\"$upstream_response_time\""
  source {
    files = [
      "/var/log/nginx/access.log"
    ]
  }
  labels {
    source = "sidecar"
  }
  # custom histogram (buckets in seconds) - we are also interested in long running requests [cap at 5 minutes]
  histogram_buckets = [.01, .025, .05, .1, .25, .5, 1, 2.5, 5, 10, 25, 60, 150, 300]
  relabel "request_from" {
    from = "remote_addr"
  }
}
