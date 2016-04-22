Title: Wordrpess on docker.
Author: Om Prakash Singh
Date: 2016-02-26
Category: How-To
Tags: Linux, docker, wordpress, configure


Setting up the environment for my wordpress. Virtual box make system slow. Docker is good to have.

Setting it up now&#x2026;

My system: its a macbook pro.
General system Requirement: 64Bit arch CPU, Windows/Linux/Mac will do. Install images are on the docker site.
Get Docker: Docker require to have a 64 bit system and I am glad I have one.

##### Install Boot2Docker<a id="sec-1" name="sec-1"></a>

1.  Go to the [boot2docker/osx-installer](https://github.com/boot2docker/osx-installer/releases/latest) release page.

2.  Download Boot2Docker by clicking Boot2Docker-x.x.x.pkg in the "Downloads" section.

3.  Install Boot2Docker by double-clicking the package.
    The installer places Boot2Docker in your "Applications" folder.

The installation places the docker and boot2docker binaries in your /usr/local/bin directory.

##### Start the Boot2Docker Application<a id="sec-2" name="sec-2"></a>

To run a Docker container, you first start the boot2docker VM and then issue docker commands to create, load, and manage containers. You can launch boot2docker from your Applications folder or from the command line.

NOTE: Boot2Docker is designed as a development tool. You should not use it in production environments.
From the Applications folder
When you launch the "Boot2Docker" application from your "Applications" folder, the application:

opens a terminal window

creates a $HOME/.boot2docker directory

creates a VirtualBox ISO and certs

starts a VirtualBox VM running the docker daemon

Once the launch completes, you can run docker commands. A good way to verify your setup succeeded is to run the hello-world container.

$ docker run hello-world
Unable to find image 'hello-world:latest' locally
511136ea3c5a: Pull complete
31cbccb51277: Pull complete
e45a5af57b00: Pull complete
hello-world:latest: The image you are pulling has been verified. Important: image verification is a tech preview feature and should not be relied on to provide security.
Status: Downloaded newer image for hello-world:latest
Hello from Docker.
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:

1.  The Docker client contacted the Docker daemon.
2.  The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (Assuming it was not already locally available.)
3.  The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
4.  The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

For more examples and ideas, visit:
 <http://docs.docker.com/userguide/>
A more typical way to start and stop boot2docker is using the command line.
