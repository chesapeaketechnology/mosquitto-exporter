#!/bin/sh

until consul kv put ruok iamok; do
  >&2 echo "Consul is unavailable - sleeping"
  sleep 20
done

# Start the MQTT broker
MQTT_PASS=`consul kv get mqtt/user/$MQTT_USER` /mosquitto_exporter
