#!/bin/bash

set -e

GRAFANA_ADMIN_USER=${GRAFANA_ADMIN_USER:-admin}
GRAFANA_ADMIN_PASSWORD=${GRAFANA_ADMIN_PASSWORD:-admin}
GRAFANA_AUTH_BASIC_ENABLED=${GRAFANA_AUTH_BASIC_ENABLED:-"true"}

cp /app/assets/grafana.ini /etc/grafana/grafana.ini

sed s/{{GRAFANA_ADMIN_USER}}/$GRAFANA_ADMIN_USER/g -i /etc/grafana/grafana.ini
sed s/{{GRAFANA_ADMIN_PASSWORD}}/$GRAFANA_ADMIN_PASSWORD/g -i /etc/grafana/grafana.ini
sed s/{{GRAFANA_AUTH_BASIC_ENABLED}}/$GRAFANA_AUTH_BASIC_ENABLED/g -i /etc/grafana/grafana.ini

service grafana-server start
update-rc.d grafana-server defaults 95 10

# DB Replace
sleep 5s # wait till grafana.db is generated (5s is just my choice)
service grafana-server stop

if [ -e "/app/grafana/grafana.db" ]; then
  rm /var/lib/grafana/grafana.db
  echo 'remove temp grafana.db'
else 
  mv /var/lib/grafana/grafana.db /app/grafana/grafana.db
  echo 'mv grafana.db as start database'
fi

ln -s /app/grafana/grafana.db /var/lib/grafana/grafana.db
chown grafana:grafana /app/grafana/grafana.db
chown grafana:grafana /var/lib/grafana/grafana.db

service grafana-server start


bash
