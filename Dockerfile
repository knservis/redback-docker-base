FROM ubuntu:14.04
MAINTAINER Konstantinos Servis <knservis@gmail.com>

RUN apt-get -qq update
RUN apt-get -qqy install software-properties-common
RUN add-apt-repository -y ppa:webupd8team/java
RUN apt-get -qq update
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get -qqy install oracle-java7-installer
RUN update-alternatives --display java

ENV AWS_CONNECTOR_VERSION 1.1.1
ENV REDBACK_VERSION 1.0.0

RUN apt-get -qqy install git maven
RUN git clone https://github.com/knservis/amazon-kinesis-connectors /tmp/amazon-kinesis-connectors && cd /tmp/amazon-kinesis-connectors && git checkout $AWS_CONNECTOR_VERSION && mvn install && rm -rf /tmp/amazon-kinesis-connectors
RUN git clone https://bitbucket.org/knservis/redback.git /app/redback && cd /app/redback && git checkout $REDBACK_VERSION
RUN cd /app/redback && mvn package && mvn dependency:purge-local-repository
