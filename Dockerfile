FROM jpetazzo/dind
MAINTAINER spiddy

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get install -y software-properties-common
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java7-installer

RUN apt-get install -y make

