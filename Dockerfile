FROM nginx:alpine

# install curl (for healthchecks)
RUN apk --no-cache add curl

COPY scripts /scripts
RUN chmod a+x /scripts/*.sh

WORKDIR /scripts

ENV SERVICE_HOST dummy
ENV SERVICE_PORT 80

CMD ./start.sh
