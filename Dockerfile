FROM alpine:3.12

LABEL maintainer="ChesapeakeTechnology <devops@>ctic.us" \
    description="Mosquitto Exporter with Consul CLI"

ENV CONSUL_VERSION=1.9.5

RUN apk add --no-cache libc6-compat

RUN set -x && \
    wget https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip -O /tmp/consul.zip && \
    unzip /tmp/consul.zip -d /usr/local/bin && \
    consul --version && \
    rm -f /tmp/consul.zip

COPY bin/mosquitto_exporter /mosquitto_exporter

EXPOSE 9234

VOLUME ["/consul/data"]

COPY start.sh /
RUN chmod +x /start.sh
ENTRYPOINT [ "/start.sh" ]
