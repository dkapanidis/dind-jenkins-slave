dind-jenkins-slave
==================

Docker-in-Docker Jenkins Slave

[![Docker Container](http://dockeri.co/image/spiddy/dind-jenkins-slave)](https://registry.hub.docker.com/u/spiddy/dind-jenkins-slave/)

Contains:

* Java
* [Docker](https://github.com/docker/docker)
* [Docker Compose](https://github.com/docker/compose) 1.3.3
* [Fig](http://www.fig.sh/) 1.0.1 - this is kept for backward compatibility for some time
* [Captain](https://github.com/harbur/captain) 0.5.0

Can be used as Jenkins slave that can compile containers with Captain and run with docker or docker-compose.

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
docker run --privileged --link=jenkins:master -v /var/run/docker.sock:/var/run/docker.sock -d spiddy/dind-jenkins-slave
```

It will:

* launch the container in `privileged` mode
* Connect the docker socket inside the container to reuse the running docker service
* Link jenkins master container
* Run in the background

In case more parameters are needed to be passed to swarm plugin CLI use **EXTRA_PARAMS** variable. Possible variables:

```
 -autoDiscoveryAddress VAL : Use this address for udp-based auto-discovery
                             (default 255.255.255.255)
 -description VAL          : Description to be put on the slave
 -disableSslVerification   : Disables SSL verification in the HttpClient.
 -executors N              : Number of executors
 -fsroot FILE              : Directory where Jenkins places files
 -help (--help)            : Show the help screen
 -labels VAL               : Whitespace-separated list of labels to be assigned
                             for this slave. Multiple options are allowed.
 -master VAL               : The complete target Jenkins URL like 'http://server
                             :8080/jenkins'. If this option is specified,
                             auto-discovery will be skipped
 -mode MODE                : The mode controlling how Jenkins allocates jobs to
                             slaves. Can be either 'normal' (utilize this slave
                             as much as possible) or 'exclusive' (leave this
                             machine for tied jobs only). Default is normal.
 -name VAL                 : Name of the slave
 -password VAL             : The Jenkins user password
 -username VAL             : The Jenkins username for authentication
```

Example:

```
docker run --privileged --link=jenkins:master -v /var/run/docker.sock:/var/run/docker.sock -e EXTRA_PARAMS="-description 'Jenkins Slave' -executors 2" -d spiddy/dind-jenkins-slave
```

# Run A Jenkins Master + Slave

To run a complete Jenkins Master + Slave pack, clone this project and use docker-compose inside the clonned directory:

```
docker-compose up -d
```

If you get a permissions error on startup, you need to give ownership to uid 1000 the /opt/jenkins directory where the docker engine runs.

For example if you use docker-machine and your machine name is 'dev', do:

```
docker-machine ssh dev 'chown -R 1000:1000 /opt/jenkins'
```

Once the stack is up with docker-compose (master+slave) then open a browser on port 8080 to connect with Jenkins:
- Manage Jenkins -> Manage Plugins -> Available: Install "Self-Organizing Swarm Plug-in Modules" (no restart needed)

Once install is finished, the slave will automatically be connected.

To test it:
- Create new Jobs -> Freestyle project
  - Restrict where this project can be run: swarm
  - Add Build Step -> Execute Shell: docker ps
- Build Now

On the job result you'll be able to see that slave has connected with the docker engine and shows the running containers.

