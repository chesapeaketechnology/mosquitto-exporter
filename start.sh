#!/bin/sh

if [[ ! -z "${CONSUL_SERVER}" ]]; then
  consul agent -retry-join $CONSUL_SERVER --data-dir /consul/data &
fi

until consul kv put ruok iamok; do
  >&2 echo "Consul is unavailable - sleeping"
  sleep 20
done

# Start the MQTT broker
MQTT_PASS=`consul kv get mqtt/user/$MQTT_USER` /mosquitto_exporter
