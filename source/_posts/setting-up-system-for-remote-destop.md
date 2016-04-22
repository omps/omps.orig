Title: remote destop on arch linux.
Author: Om Prakash Singh
Date: 2016-02-26
Category: How-To
Tags: Linux, arch linux, java, citrix, icaclient, yaourt, rdesktop, plugin, icedtea-web

I need 4 things to be present on my Linux system to successfully connect over the rdp for my work.

##### web browser
installed firefox and started my work.

```pacman -S firefox```


##### java
unable to figure out the latest firefox plugin path on arch linux so moved ahead with icedtea-web plugin which install openjdk8 on arch linux.

* install icedtea-web plugin.
The IcedTea-Web Javaws_splash project provides a Free Software web browser plugin running applets written in the Java programming language and an implementation of Java Web Start, originally based on the NetX project.

the package can be installed on arch linux using.
```
pacman -s icedtea-web
```

this will install all the required dependencies, restart your browser and jump to http://java.com/en/download/testjava.jsp

* while researching, here are some links which can help other linux user to configure thir firefox to use Java.
http://stackoverflow.com/questions/14491322/how-to-add-java-plugin-for-firefox-on-linux
http://java.com/en/download/help/linux_install.xml

##### citrix receviver client
install the icaclient from the aur repository.
to install seamlessly from aur repository i need to install the yaourt package, which again wanted me to go through a set of steps which I did but once the yaourt is installed my package istallation from aur repositories were a breeze.

* install yaourt
Yaourt runs all the necessary manual steps for us like downloading package from (https://aur.archlinux.org/)[AUR] repository, compiling it and installing the software using pacman -S command.

To install yaourt we need to ensure our dependecies are covered up.

```
$ pacman -Ss base-devel  # check whether the base development package is installed
$ pacman -Ss yajl        # check whether the required JSON package is installed
$ sudo pacman -S base-devel yajl  # install if necessary
```

dowload and install the package in a seperate temp location.
```$ mkdir -p ~/temp/AUR/ && cd ~/temp/AUR/```

yaourt depends on another package called as ackage-query, so we are going to install package-query first.

```
$ wget https://aur.archlinux.org/cgit/aur.git/snapshot/package-query.tar.gz  # download source tarball
$ tar xfz package-query.tar.gz  # unpack tarball
$ cd package-query  &&  makepkg  # cd and create package from source
$ sudo pacman -U package-query*.pkg.tar.xz  # install package - need root privileges
```

similarly goes for **yaourt...**

```
$ wget https://aur.archlinux.org/cgit/aur.git/snapshot/yaourt.tar.gz
$ tar xzf yaourt.tar.gz
$ cd yaourt  &&  makepkg
$ sudo pacman -U yaourt*.pkg.tar.xz
```

now our **yaourt** is installed, time now for go ahead with citrix client installation.

- install icaclient using yaourt.

installing **AUR** packages using *yaourt* is as simple as doing it with *pacman -S*, the *yaourt* takes care of the required dependecies.

```
$ yaourt -S icaclient
```

This will download the packages and install it. It will keep asking questions which can be answered in simple **Y** and move ahead.

We need to manually create the cache directories and copy the configurations files to every user home area.
```
mkdir -p $HOME/.ICAClient/cache
cp
/opt/Citrix/ICAClient/config/{All_Regions,Trusted_Region,Unknown_Region,canonicalization,regions}.ini
$HOME/.ICAClient/
```

##### rdesktop
Despite the successful installation of the ica client, it failed with some kerberos ticket, now here is the tragedy I had this issue some couple of months back and somehow I had fixed that too, but since I thought I am too smart to write such this i eventually forgot and now once again I am doing the same things, which is trying to figure out How did I fixed the issue. Well, this time I raised a case with the developers for this issue. I read a lot of places for downloading the latest branch from github for this particualr package, I did that as well, but that didn't help much.

Here's the case info.
https://github.com/rdesktop/rdesktop/issues/28

Finally, figured out the fix.

1. Dowload the latest source tarball of rdesktop
2. Compile the source code with

``` ./configure --prefix=/opt --disable-smartcard --disable-credssp ```

rdesktop works like a charm.

``` /usr/local/bin/rdesktop -u username servername:portno. -PKD -fz -p - ```

Complete!!
