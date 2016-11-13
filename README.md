# Zimbra
In this Repository you will find how to install Zimbra on Docker

# Docker
## Install Docker
* Keep posted of the changes in the next Zimbra Wiki - https://wiki.zimbra.com/wiki/Deploy_Zimbra_Collaboration_using_docker

Depend of your OS, you need to install Docker in different ways, take a look into the official Website - https://docs.docker.com/installation/#installation

One of the advantages of using docker is that the host OS does not matter, the containers will work on any platform.
##Creating the Zimbra Image

The content of the Dockerfile and the start.sh is based on the next Script - ZimbraEasyInstall. The Dockerfile creates a Ubuntu Server 14.04 image and install on it all the OS dependencies which Zimbra needs, then when the container is launched, automatically starts with the start.sh script which creates an autoconfig file which is injected during the zimbra Installation:
###Using git
Download from github, you will need git installed on your OS

```bash
git clone https://github.com/Zimbra-Community/zimbra-docker.git
```
####Using wget
For those who want to use wget, follow the next instructions to download the Zimbra-docker package. You might need wget and unzip installed on your OS
```bash
wget https://github.com/Zimbra-Community/zimbra-docker/archive/master.zip
unzip master.zip
```

##Build the image using the Dockerfile
The `Makefile` in the docker/ directory provides you with a convenient way to build your docker image. You will need make on your OS. Just run

```bash
cd zimbra-docker/docker
sudo make
```

The default image name is zimbra_docker. You can specify a different image name by setting the `Image` variable:

```bash
cd zimbra-docker/docker
sudo IMAGE=your_image_name make
```
##Deploy the Docker container
Now, to deploy the container based on the previous image. As well as publish the Zimbra Collaboration ports, the hostname and the proper DNS, as you want to use bind as a local DNS nameserver within the container, also we will send the password that we want to our Zimbra Server like admin password, mailbox, LDAP, etc.: Syntax:
```bash
docker run -p PORTS -h HOSTNAME.DOMAIN --dns DNSSERVER -i -t -e PASSWORD=YOURPASSWORD NAMEOFDOCKERIMAGE
```
Example:
```bash
docker run -p 25:25 -p 80:80 -p 465:465 -p 587:587 -p 110:110 -p 143:143 -p 993:993 -p 995:995 -p 443:443 -p 8080:8080 -p 8443:8443 -p 7071:7071 -p 9071:9071 -h zimbra86-docker.zimbra.io --dns 127.0.0.1 --dns 8.8.8.8 -i -t -e PASSWORD=Zimbra2015 zimbra_docker
```
This will create the container in few seconds, and run automatically the start.sh:

* Install a DNS Server based in bind9 and the dnsutils package
* Configure all the DNS Server to resolve automatically internal the MX and the hostname that we define while launch the container.
* Install the OS dependencies for Zimbra Collaboration 8.6
* Create 2 files to automate the Zimbra Collaboration installation, the keystrokes and the config.defaults.
* Launch the installation of Zimbra based only in the .install.sh -s
* Inject the config.defaults file with all the parameters that is autoconfigured with the Hostname, domain, IP, and password that you define before.

The script takes a few minutes, dependent on the your Internet Speed, and resources.
##Known issues##
After the Zimbra automated installation, the docker container will exit and keep in stopped state, you just need to run the next commands to start your Zimbra Container:

```bash
docker ps -a 
docker start YOURCONTAINERID
docker exec -it YOURCONTAINERID bash
su - zimbra
zmcontrol restart
```