DOCKER GRAFANA
===========


```

docker build -t tomyhero/grafana .
docker run --name grafana -it -d -p 13000:3000 \
	-v /opt/grafana/data:/app/grafana \
	-e "GRAFANA_ADMIN_USER=teranishi" \
	-e "GRAFANA_ADMIN_PASSWORD=tomohiro" \
  	-e "GRAFANA_AUTH_BASIC_ENABLED=false" \
	tomyhero/grafana bash 

```

