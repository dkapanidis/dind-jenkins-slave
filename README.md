dind-jenkins-slave
==================

Docker-in-Docker Jenkins Slave

Contains:

* Docker
* Java

Can be used as Jenkins slave that can launch containers.

Requirements
------------

* Docker installed
* Jenkins master with open JNLP port (you may want to fix the port at "Manage Jenkins - Configure Global Security - TCP port for JNLP slave agents")
* Jenkins configured `slave` node with "Launch slave agents via Java Web Start"

Run Docker-in-Docker Jenkins Slave
---------------------

To run the Docker-in-Docker Jenkins Slave:

```
docker run -privileged -p 2222:22 -v /var/run/docker.sock:/var/run/docker.sock -it spiddy/dind-jenkins-slave bash
```

It will:

* launch the container in `privileged` mode
* Connect the docker socket inside the container to reuse the running docker service
* Expose port 22
* Run in interactive mode

Launch the Jenkins Slave
------------------------

Once launched the container, run the following command:

```
wget http://JENKINS_HOST/jnlpJars/slave.jar && java -jar slave.jar -jnlpUrl http://JENKINS_HOST/computer/slave/slave-agent.jnlp -secret XXX&
```

* Replace JENKINS_HOST with the actual value
* Replace XXX with the secret (can be found at the Jenkins node page)

It will:

* Download the slave.jar binary
* Connect the container as slave to Jenkins
