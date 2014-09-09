FROM jpetazzo/dind
MAINTAINER spiddy

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -qq && \
  apt-get install -qqy software-properties-common && \
  echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -qqy oracle-java7-installer && \
  apt-get clean

RUN apt-get install -y make
RUN wget http://maven.jenkins-ci.org/content/repositories/releases/org/jenkins-ci/plugins/swarm-client/1.16/swarm-client-1.16-jar-with-dependencies.jar
CMD java -jar swarm-client-1.16-jar-with-dependencies.jar -master http://$MASTER_PORT_8080_TCP_ADDR:$MASTER_PORT_8080_TCP_PORT
