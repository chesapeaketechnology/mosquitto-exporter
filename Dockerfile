FROM alpine:3.12

LABEL maintainer="ChesapeakeTechnology <devops@>ctic.us" \
    description="Mosquitto Exporter with Consul CLI"

RUN apk add --no-cache libc6-compat

RUN set -x && \
    wget https://releases.hashicorp.com/consul/1.8.0/consul_1.8.0_linux_amd64.zip -O /tmp/consul.zip && \
    unzip /tmp/consul.zip -d /usr/local/bin && \
    consul --version && \
    rm -f /tmp/consul.zip

COPY bin/mosquitto_exporter /mosquitto_exporter

EXPOSE 9234

COPY start.sh /
RUN chmod +x /start.sh
ENTRYPOINT [ "/start.sh" ]
