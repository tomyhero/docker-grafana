FROM ubuntu:latest


RUN apt-get update
RUN apt-get install -y wget vim
RUN wget https://grafanarel.s3.amazonaws.com/builds/grafana_2.1.3_amd64.deb
RUN sudo apt-get install -y adduser libfontconfig
RUN sudo dpkg -i grafana_2.1.3_amd64.deb
RUN apt-get install -y apt-transport-https

RUN echo "deb https://packagecloud.io/grafana/stable/debian/ wheezy main" >> /etc/apt/sources.list
RUN apt-get update
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 37BBEE3F7AD95B3F
RUN apt-get install grafana


VOLUME ["/app/grafana"]

EXPOSE 3000

COPY assets /app/assets
RUN chmod 755 /app/assets/entrypoint.sh
ENTRYPOINT ["/app/assets/entrypoint.sh"]
