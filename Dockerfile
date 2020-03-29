FROM wetransform/nginx-metrics

# install curl (for healthchecks)
RUN apk --no-cache add curl

COPY scripts /scripts
RUN chmod a+x /scripts/*.sh

WORKDIR /scripts

COPY nginx.conf /etc/nginx/nginx.conf
COPY exporter.hcl /exporter.hcl
ENV EXPORTER_CONFIG /exporter.hcl

ENV SERVICE_HOST dummy
ENV SERVICE_PORT 80

CMD ./start.sh
