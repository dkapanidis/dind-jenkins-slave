dind-jenkins-slave
==================

Docker-in-Docker Jenkins Slave

[![Docker Container](http://img.shields.io/badge/container-spiddy%2Fdind--jenkins--slave-blue.svg)](https://registry.hub.docker.com/u/spiddy/dind-jenkins-slave/)

Contains:

* Docker
* Java

Can be used as Jenkins slave that can launch containers.

Requirements
------------

* Docker installed
* Jenkins master running inside Docker in same Host as Slaves (Can be scaled with Ambassador pattern to other hosts)
* Jenkins master with open JNLP port (you may want to fix the port at "Manage Jenkins - Configure Global Security - TCP port for JNLP slave agents")
* Jenkins master with Swarm Plugin installed

Run Docker-in-Docker Jenkins Slave
---------------------

To run the Docker-in-Docker Jenkins Slave:

```
docker run --privileged --link=jenkins:master -v /var/run/docker.sock:/var/run/docker.sock -d spiddy/dind-jenkins-slave bash
```

It will:

* launch the container in `privileged` mode
* Connect the docker socket inside the container to reuse the running docker service
* Link jenkins master container
* Run in the background
