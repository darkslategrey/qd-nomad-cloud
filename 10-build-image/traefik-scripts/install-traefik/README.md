# Traefik Install Script

This folder contains a script for installing Traefik and its dependencies. You can use this script, along with the
[run-traefik script](https://github.com/hashicorp/terraform-google-traefik/tree/master/modules/run-traefik) it installs, to create a Traefik [Google Image](
https://cloud.google.com/compute/docs/images) that can be deployed in [Google Cloud](https://cloud.google.com) across a
Managed Instance Group using the [traefik-cluster module](https://github.com/hashicorp/terraform-google-traefik/tree/master/modules/traefik-cluster).

This script has been tested on the following operating systems:

* Ubuntu 16.04

There is a good chance it will work on other flavors of Debian as well.



## Quick start

To install Traefik, use `git` to clone this repository at a specific tag (see the [releases page](../../../../releases) 
for all available tags) and run the `install-traefik` script:

```
git clone --branch <VERSION> https://github.com/hashicorp/terraform-google-traefik.git
terraform-google-traefik/modules/install-traefik/install-traefik --version 0.5.4
```

The `install-traefik` script will install Traefik, its dependencies, and the [run-traefik script](https://github.com/hashicorp/terraform-google-traefik/tree/master/modules/run-traefik).
You can then run the `run-traefik` script when the server is booting to start Traefik.

We recommend running the `install-traefik` script as part of a [Packer](https://www.packer.io/) template to create a
Traefik [Google Image](https://cloud.google.com/compute/docs/images) (see the [traefik-consul-image example](
/examples/traefik-consul-image) for sample code). You can then deploy the Image across a Managed Instance Group using the
[traefik-cluster module](https://github.com/hashicorp/terraform-google-traefik/tree/master/modules/traefik-cluster) (see the [traefik-cluster-public](https://github.com/hashicorp/terraform-google-traefik/tree/master/examples/traefik-cluster-public) and 
[traefik-cluster-private](https://github.com/hashicorp/terraform-google-traefik/tree/master/examples/traefik-cluster-private) examples for fully-working sample code).




## Command line Arguments

The `install-traefik` script accepts the following arguments:

* `version VERSION`: Install Traefik version VERSION. Required. 
* `path DIR`: Install Traefik into folder DIR. Optional.
* `user USER`: The install dirs will be owned by user USER. Optional.

Example:

```
install-traefik --version 0.8.2
```



## How it works

The `install-traefik` script does the following:

1. [Create a user and folders for Traefik](#create-a-user-and-folders-for-traefik)
1. [Install Traefik binaries and scripts](#install-traefik-binaries-and-scripts)
1. [Configure mlock](#configure-mlock)
1. [Install supervisord](#install-supervisord)
1. [Follow-up tasks](#follow-up-tasks)


### Create a user and folders for Traefik

Create an OS user named `traefik`. Create the following folders, all owned by user `traefik`:

* `/opt/traefik`: base directory for Traefik data (configurable via the `--path` argument).
* `/opt/traefik/bin`: directory for Traefik binaries.
* `/opt/traefik/data`: directory where the Traefik agent can store state.
* `/opt/traefik/config`: directory where the Traefik agent looks up configuration.
* `/opt/traefik/log`: directory where the Traefik agent will store log files.
* `/opt/traefik/tls`: directory where the Traefik will look for TLS certs.


### Install Traefik binaries and scripts

Install the following:

* `traefik`: Download the Traefik zip file from the [downloads page](https://www.traefikproject.io/downloads.html) (the 
  version number is configurable via the `--version` argument), and extract the `traefik` binary into 
  `/opt/traefik/bin`. Add a symlink to the `traefik` binary in `/usr/local/bin`.
* `run-traefik`: Copy the [run-traefik script](https://github.com/hashicorp/terraform-google-traefik/tree/master/modules/run-traefik) into `/opt/traefik/bin`. 


### Configure mlock

Give Traefik permissions to make the `mlock` (memory lock) syscall. This syscall is used to prevent the OS from swapping
Traefik's memory to disk. For more info, see: https://www.traefikproject.io/docs/configuration/#disable_mlock.


### Install supervisord

Install [supervisord](http://supervisord.org/). We use it as a cross-platform supervisor to ensure Traefik is started
whenever the system boots and restarted if the Traefik process crashes.


### Follow-up tasks

After the `install-traefik` script finishes running, you may wish to do the following:

1. If you have custom Traefik config (`.hcl`) files, you may want to copy them into the config directory (default:
   `/opt/traefik/config`).
1. If `/usr/local/bin` isn't already part of `PATH`, you should add it so you can run the `traefik` command without
   specifying the full path.
   


## Why use Git to install this code?

<!-- TODO: update the package managers URL to the final URL when this Blueprint is released -->

We needed an easy way to install these scripts that satisfied a number of requirements, including working on a variety 
of operating systems and supported versioning. Our current solution is to use `git`, but this may change in the future.
See [Package Managers](https://github.com/hashicorp/terraform-google-consul/blob/master/_docs/package-managers.md) for 
a full discussion of the requirements, trade-offs, and why we picked `git`.
