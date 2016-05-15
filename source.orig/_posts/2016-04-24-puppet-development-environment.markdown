---
layout: post
title: "Puppet Development with vagrant"
date: 2016-04-24 16:40:46 +0530
comments: true
categories: puppet
tages: #puppet, #howto, #development  
---

I started working DevOps which initiated me to learn the about the configuration management and automation tools, Though it does have a learning curve but it provides great oppurtunity to automate most of your tasks. Don't worry it will not make you redundant, learning automation may indeed inflate your profile. Searching on the internet for the same purpose I encountered with [Gary Larizza's](http://garylarizza.com/) blog on [Repeatable puppet development with vagrant](http://garylarizza.com/blog/2013/02/01/repeatable-puppet-development-with-vagrant/). Of course the blog being 3 years old, need some rework with the commands, I am hence updating this article as my updated version of his workflow. 
<!--more-->
In smaller organizations 'testing' and 'development' consist of making changes directly to the server, logging in to the running system and hoping the commands to just work. Once done we document the changes we made, but more OFTEN we happen to keep the information in our head to refer to it later. This is how the manual configuration works. In bigger organization though the things are pretty neat and ready, a centralized configuration management system with everything automated and well documented and code repositories to version control code. This is not a very likely situation while we are writing modules in a development environment and it really doesn't make sense that we put the code in production environment just to test. We need something smaller setup for ourselves, let it be either for the development environment or for my work setup on my personal laptop to automate the things, menial daily jobs, etc etc.. You never know when you find somethings interesting to automate and this can put us in to the good habit of automating things. 

And of course I want to keep these things separate from my laptop base configuration, without spending money for buying additional server HW just to test my development work. Vagrant and Virtualbox are boon for the developers who wanted to produce definitive work from anywhere without being dependent on network connection, any need for special physical hardware and a place to code. 

We would require ability to create vm's for the purpose of testing our automation workflow, before committing and pushing it to production nodes. 

[Puppet](http://www.puppetlabs.com/) is a configuration management tool which helps autotmates all the aspects of manual configuration. I won't be putting too much puppet in here, however we will be using it to describe the changes we are making to the system.

[Vagrant](http://www.vagrantup.com/) is a boon for developers and SA for testing their work without making changes to your comfortable laptop work env. It uses minimal VM's template and create virtualized environment on your workstation for the purpose of testing. While writing this Vagrant has support for almost all the major virtualization providers such as Virtualbox, VMware Fusion, Hyper - V, docker.

## Getting Ready for work.

The only thing which get installed on your system is Vagrant and Virtualbox(if your dones't have one already installed). If you have never used Vagrant before and NOT an ruby developer, it's good to opt of native installaton, its the easiest method to get Vagrant Installed. 

### Installing vagrant

http://downloads.vagrantup.com/ should provide one pre-packaged binary for your OS.

For ruby developers or those who knows RVM and gem installation

    $ gem install vagrant --no-ri --no-rdoc
    
**Note:** stick with [native installers](http://downloads.vagrantup.com/) for now, if you are not much aware about RVM and Rbenv.

We will be installing puppet only of to the VM's and not on our system.

### Living in the box

Vagrant uses box files as templates from which it creates new virtual machine for development machine. [There are sites that host boxes available for download](http://vagrantbox.es/), OR, you could use to build your box using virtualbox. Building your box file is outside the scope of this article, so just make sure you download a box with an OS that’s to your liking. This box DOES NOT need to have Puppet preinstalled – in fact, it’s probably better that it doesn’t (because the version will probably be old, and we’re going to work around this anyways). I’m going to choose a CentOS 7 box, but, and again, it’s up to you. 

I usually create my own [box from the exiting vagrant box](http://www./blog/2016/04/25/create-box-from-vagrant-virtualmachines/), my primary purpose is so that I do not have to download the box and reconfigure it again if I plan to destroy existing vagrant environment.

https://atlas.hashicorp.com/boxes/search maintains a list of boxes which are very up to date, you might want to download the latest box, incase you haven't downloaded any.

### Fixing your vagrantfile.

We need to create a VM for the project and a `Vagrantfile` to direct vagrant on how it should setup your VM. You can create any directory in your home area which you can use for work with puppet.

```sh 
$ mkdir -p ~/puppet-vagrant
$ cd ~/puppet-vagrant
```

Open Vagrantfile in your favorite editor.

Below is the Sample Vagrantfile which I used to get puppet installed on my box.

```ruby
Vagrant.configure(2) do |config|
  config.vm.box = "centos/7"
  config.vm.hostname = "development.puppetlabs.vm"
  config.vm.network "private_network", ip: "172.31.0.202"
  config.vm.network "forwarded_port", guest: 80, host: 8084
  config.vm.provision :shell, :path => "centos_7_x.sh"
end
```

the first two config.vm lines establish the box we want to use for our development VM. Because, initially, this box will NOT be known to Vagrant, it will attempt to reach out to that [Atlas](https://atlas.hashicorp.com/boxes/search) site and download it. The next three lines define the machine’s hostname, the network type, and the IP address for this VM. In this case, I’m using a private network and giving it an IP address on a made-up 172.31.0.0/24 subnet (feel free to use your own private IP range as long as it doesn’t conflict with anything). The next line is forwarding port 80 on the VM to port 8084 on my local laptop – this allows you to test out web services by simply navigating to http://localhost:8084 from your web browser. I’ll save explaining the last line for the next section.

NOTE: For more documentation on these settings, [visit Vagrant’s documentation](http://docs.vagrantup.com/v1/docs/vagrantfile.html) site as it’s quite good. The post I referred to create my dev environment and the post I am writing has many changes may be because of Vagrant version changes. Please refer to the Vagrant docs in case you are reading in near future. 


### Installing virtualbox

Vagrant needs an underlying provider for it to run, the provider is an application which allows your system to run virtual machine. By default vagrant does comes with VirtualBox but in case yours didn't please feel free to download one from [Virtualbox Download](https://www.virtualbox.org/wiki/Downloads) site and install it according to your system.


### Installing virtualbox Guest Additions

While setting up all this, I did got lots of issue with some or the other feature not working, different OSes threw me different errors. But it is always good to have it installed. We may in further be taking about how to share folders with your virtual machine and the host machine. The Virtualbox tools is to be installed on to the Virtual Machine only. So, you may need to do it once box is created. Its an ISO image and can be downloaded from the [Virtualbox page](http://download.virtualbox.org/)

or you can just do.

    vagrant plugin install vagrant-vbguest

### Getting started with puppet on your VM.
The final line of the `Vagrantfile` runs the 'Shell Provisioner' for vagrant. Essentially, this runs a shell script on the VM once its been booted and configured. 

{% include_code vagrant/centos_7_x.sh %}

With this script, I setup the puppetlabs el7 repo containing the current package for Puppet/Facter/Hiera/PuppetDB and install the most recent version of puppet and facter present in the repository. This will ensure you get the latest version of puppet, and you don't need to worry about creating a new box everytime, puppet releases a new verion.

This code is from [Mitchell's puppet bootstrap repo](https://github.com/hashicorp/puppet-bootstrap/blob/master/centos_6_x.sh). This code is working for me, but keep checking the repo for any updates. If you maintaining your **own** provisioning script, consider filling a pull request so we can take the benefit from good-code.

### Action time

Once the `Vagrantfile` is created the next logical thing is to start the VM and test out vagrant. 

```sh
$ vagrant status
Current machine states:

default                   not created (virtualbox)

The environment has not yet been created. Run `vagrant up` to
create the environment. If a machine is not created, only the
default provider will be shown. So if a provider is not listed,
then the machine is not created for that environment.
```

Good, so there is no VM created, so lets create one by starting vagrant.

```sh
$ vagrant up
Bringing machine 'default' up with 'virtualbox' provider...
==> default: Importing base box 'centos/7'...
==> default: Matching MAC address for NAT networking...
==> default: Checking if box 'centos/7' is up to date...
==> default: Setting the name of the VM: octopressnotes_default_1461604478526_97058
==> default: Clearing any previously set network interfaces...
==> default: Preparing network interfaces based on configuration...
    default: Adapter 1: nat
    default: Adapter 2: hostonly
==> default: Forwarding ports...
    default: 80 (guest) => 8084 (host) (adapter 1)
    default: 22 (guest) => 2222 (host) (adapter 1)
==> default: Booting VM...
==> default: Waiting for machine to boot. This may take a few minutes...
==> default: Machine booted and ready!
==> default: Checking for guest additions in VM...
==> default: Setting hostname...
==> default: Configuring and enabling network interfaces...
==> default: Mounting shared folders...
==> default: Machine already provisioned. Run `vagrant provision` or use the `--provision`
==> default: flag to force provisioning. Provisioners marked to run always will still run.
```

Vagrant first noticed and checked for the centos/7 box locally, since I already have the box added into my Vagrant it didn't redownload it but used the same box to create a custom VM, if the machine is not present locally, Vagrant will download the box from hashicorp site. Next Vagrant moves to configuring the hostname and the network as per our Vagrantfile, and Lastly it runs the script it for provisioning the VM. 

We have got the VM with puppet installed. Let's login to the VM and check the puppet version.

```sh
$ vagrant ssh

Last login: Wed Apr 13 13:11:28 2016 from 10.0.2.2
[vagrant@development ~]$ puppet --version
3.8.6
[vagrant@development ~]$ hostname
development.puppetlabs.vm
[vagrant@development ~]$ exit
logout
Connection to 127.0.0.1 closed.
```

So now we know how to SSH into the VM, check the Puppet version, check the hostname to check we are on the correct host. Now we go ahead and confiure puppet to do something with this machine.

### Working with puppet

Now we have got a clean VM, and were able to set up as well, the purpose of this doc was to set up a puppet development environment using vagrant. For writing puppet modules, [puppet cookbook](http://www.amazon.com/Puppet-Cookbook-Third-Thomas-Uphill/dp/1784394882/ref=sr_1_1?ie=UTF8&qid=1461809235&sr=8-1&keywords=puppet+cookbook) is a good beginning point.

More on putting things in order and avoid messing up.

I Locally use git to be for version controlling and source code management, with time to time push to remote. Use Github for storing repositories remotely.

My final Vagrantfile contains as below.

```ruby Vagrantfile
Vagrant.configure(2) do |config|
  config.vm.box = "dev-env"
  config.vm.hostname = "development.puppetlabs.vm"
  config.vm.network "private_network", ip: "172.31.0.202"
  config.vm.network "forwarded_port", guest: 80, host: 8084
  config.vm.provision :shell, :path => "centos_7_x.sh"

  # Puppet shared folder
  config.vm.synced_folder "puppet", "/puppet"

  #puppet provision setup
  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "puppet/manifests"
    puppet.module_path = "puppet/modules"
    puppet.manifest_file = "site.pp"
  end
end
```

I ensured to share my local dir with my vagrant machine, so that my download modules can be directly available to the vagrant machine for work.

