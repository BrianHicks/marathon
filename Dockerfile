# Marathon Dockerfile
FROM ubuntu
MAINTAINER TODO

## DEPENDENCIES ##
RUN apt-get update && apt-get install --assume-yes python-software-properties curl default-jdk

# install maven from a PPA, it doesn't seem to be in the Docker Ubuntu distro.
RUN add-apt-repository ppa:natecarlson/maven3
RUN apt-get update && apt-get install --assume-yes maven3

# install mesos (for libs) from mesosphere downloads
RUN curl http://downloads.mesosphere.io/master/ubuntu/12.04/mesos_0.14.2_amd64.deb > mesos.deb && dpkg --install mesos.deb && rm mesos.deb

## MARATHON ##
ADD . /etc/marathon
RUN cd /etc/marathon && mvn3 package

EXPOSE 8080
CMD ["--help"]
ENTRYPOINT ["/etc/marathon/bin/start"]