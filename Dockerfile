FROM nginx:1.16-alpine

COPY scripts /scripts
RUN chmod a+x /scripts/*.sh

WORKDIR /scripts

ENV SERVICE_HOST dummy
ENV SERVICE_PORT 80

CMD ./start.sh
