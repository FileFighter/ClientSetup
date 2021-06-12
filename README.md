# FileFighter Setup

Setup Scripts for clients to install FileFighter.  
![Release](https://img.shields.io/github/v/release/filefighter/clientsetup?color=dark-green&label=Latest%20Version&logo=github&style=for-the-badge)

**Table of Contents**
- [Requirements](#requirements)
  * [Operating Systems](#operating-systems)
    + [Linux Distributions](#linux-distributions)
    + [mac OS](#macos)
    + [Windows](#windows)
  * [Dependencies](#dependencies)
    + [Docker](#docker)
- [Installing FileFighter](#installing-filefighter)
  * [Installing the command line application](#installing-the-command-line-application)
  * [Installing with docker-compose](#installing-with-docker-compose)
- [Running FileFighter](#running-filefighter)
  * [Configuration](#configuration)
- [Updating](#updating)
  * [Auto update](#auto-update)
- [Removing FileFighter](#removing-filefighter)
  * [Remving the command line application](#remving-the-command-line-application)
  * [Removing docker-compose version of FileFighter](#removing-docker-compose-version-of-filefighter)
- [Troubleshooting](#troubleshooting)
- [Remaining Files](#remaining-files)
- [Help](#help)

<small><i><a href='http://ecotrust-canada.github.io/markdown-toc/'>Table of contents generated with markdown-toc</a></i></small>

# Requirements

## Operating Systems

### Linux Distributions

We support all common Linux Distributions with `unzip`, `wget` and `curl`.  
This code was tested under Linux Mint, Ubuntu 12, and Pop_!OS.

### macOS

Currently macOS is on our roadmap. You will still be able to run FileFigther with [docker-compose](https://docs.docker.com/compose/).

### Windows

Currently, we support only Unix-like operating systems like [Ubuntu](https://ubuntu.com). 
For windows systems you could use [wsl](https://en.wikipedia.org/wiki/Windows_Subsystem_for_Linux). To set that up read more [here](https://docs.microsoft.com/en-us/windows/wsl/install-win10).  
Alternativly you can use [docker-compose](https://docs.docker.com/compose/) to run the application. 

## Dependencies

One of the of goals of FileFighter is, that the client, that's you, only needs to met one single dependency.  
You need [Docker](https://www.docker.com/), or if you are using [docker-compose](https://docs.docker.com/compose/) you will need that too.  
Docker is a way to organise and run multiple applications. You can imagine it like a virtual machine (technical it`s a bit different), with a small file- and operating system within your machine.
Sounds more scary than it actually is. Different Applications run in different containers, these only contain the necessary software to run the application.  
The containers use the resources of the host machine, depending on the load.  
Advantages are security and the possibility to easily shutdown and update the services. See more under [Running FileFighter](#Running-FileFighter).

### Docker

First check whether you have Docker already installed.  
To do that run:

```shell script
docker -v
```

If you see something like that (your version might be different):

```shell script
Docker version 19.03.13, build 4484c46d9f
```

You are good to go, and you can skip to [Installing FileFighter](#Installing-FileFighter).

To install **Docker** on Unix you can either use [snap](https://www.howtogeek.com/660193/how-to-work-with-snap-packages-on-linux/) or [apt](<https://en.wikipedia.org/wiki/APT_(software)>) as a package manager.  
With snap its easier but of course it's not always possible to use snap.

#### Install with Snap

To install Docker with [snap](https://www.howtogeek.com/660193/how-to-work-with-snap-packages-on-linux/) you can run:

```shell script
sudo snap install docker
```

#### Install with Apt

Installing with [apt](<https://en.wikipedia.org/wiki/APT_(software)>) is a bit more difficult you can read [here](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-Docker-on-ubuntu-20-04) more about it.

# Installing FileFighter

When your docker is ready to go you can install FileFighter.  
You can install FileFighter as a commandline tool with many features, or if you are using a non linux operating system like Windows or MacOs, with docker-compose.

## Installing the command line application

When you are running a linux distribution you can either use this command

```shell script
curl https://raw.githubusercontent.com/FileFighter/ClientSetup/master/Download.sh | bash
```

or you can download the necessary scripts as a zipfile [here](https://github.com/FileFighter/ClientSetup/releases/).  
You can ignore the docker-compose.zip and download the first zip.  
It should be named like _FileFighter-v1.\*_  
Unpack the zip file, navigate into the folder and you should see this README.md, and a _Install.sh_ script.

```shell script
dev@filefighter:~/Downloads/FileFighter-1.6 $ ls
config.cfg  ffighter  Install.sh  lib  README.md
```

You can execute the script:

```shell script
dev@filefighter:~/Downloads/FileFighter-1.6 $ ./Install.sh
```

And you should see something like that:

```shell script
dev@filefighter:~/Downloads/FileFighter-1.6 $ ./Install.sh
  _____   _   _          _____   _           _       _
 |  ___| (_) | |   ___  |  ___| (_)   __ _  | |__   | |_    ___   _ __
 | |_    | | | |  / _ \ | |_    | |  / _` | | '_ \  | __|  / _ \ | '__|
 |  _|   | | | | |  __/ |  _|   | | | (_| | | | | | | |_  |  __/ | |
 |_|     |_| |_|  \___| |_|     |_|  \__, | |_| |_|  \__|  \___| |_|
                                     |___/
                   Version v1.6 Last updated: 24.01.21
              Developed by Gimleux, Valentin, Open-Schnick.
             Development Blog: https://blog.filefighter.de
       The code can be found at: https://www.github.com/filefighter

-------------------------< Initial Install >---------------------------

Creating Install Location under /home/dev/filefighter
Copying Scripts to new location...
Copying FileFighter Application to /usr/bin...
This may need administrator rights (sudo) if you are not root.
[sudo] password for dev:

Successfully installed FileFighter!
You can delete the downloaded files (/home/dev/Downloads/ClientSetup) if you want.

usage: ffighter <args>

  status    - show status of the FileFighter application.
  install   - install the FileFighter application.
  start     - start the services.
  stop      - stop the services.
  remove    - remove all services.
  update    - update all the services that have a new version available.
```

Running this command will add the FileFighter Application to your System.

## Installing with docker-compose

Installing with docker-compose is very easy. First you need the command line tool [_docker-compose_](https://docs.docker.com/compose/install/) if it isn't already installed.  
Then download the latest zipfile [here](https://github.com/FileFighter/ClientSetup/releases/).
Be carefull to download only the zip that is named like _FileFighter-v1.\*-docker-compose_  
Unpack the zip file, navigate into the filder and you should see this README.md, and a _docker-compose.yml_ file.
Open this file in any text editor of your choice and you will see a lot of configuration stuff.
The only things that are important for you, are the keys _MONGO_INITDB_ROOT_PASSWORD_ and _DB_PASSWORD_ change these to a password of your choice but make sure its the same one on both keys. Also keep in mind, that choosing a strong password is very important and we wont take any responsibilities for possible inconveniences.
After that you can just run the following command:

```shell script
docker-compose up
```

You can stop FileFighter with this command:

```shell script
docker-compose stop
```

Read more about _docker-compose_ [here](https://docs.docker.com/compose/).  
<b>Note: All steps below are only for users of the command line application.</b>

# Running FileFighter

You can use the FileFighter Application with the command _ffighter_  
Running this command should show you something like that:

```shell script
dev@filefighter:~/Downloads/FileFighter-1.6 $ ffighter
  _____   _   _          _____   _           _       _
 |  ___| (_) | |   ___  |  ___| (_)   __ _  | |__   | |_    ___   _ __
 | |_    | | | |  / _ \ | |_    | |  / _` | | '_ \  | __|  / _ \ | '__|
 |  _|   | | | | |  __/ |  _|   | | | (_| | | | | | | |_  |  __/ | |
 |_|     |_| |_|  \___| |_|     |_|  \__, | |_| |_|  \__|  \___| |_|
                                     |___/
                   Version v1.6 Last updated: 24.01.21
              Developed by Gimleux, Valentin, Open-Schnick.
             Development Blog: https://blog.filefighter.de
       The code can be found at: https://www.github.com/filefighter

-------------------------< Show Usage >---------------------------

usage: ffighter <args>

  status    - show status of the FileFighter application.
  install   - install the FileFighter application.
  start     - start the services.
  stop      - stop the services.
  remove    - remove all services.
  update    - update all the services that have a new version available.
```

You can see all the available options to run with _ffighter_.

| Option  |                                                             Description                                                             |
| :-----: | :---------------------------------------------------------------------------------------------------------------------------------: |
| status  | This command shows you information about the status of the application, like installation status, whether its running or not etc... |
| install |                                             Download and create all necessary services.                                             |
|  start  |                                              Start the services if already downloaded.                                              |
|  stop   |                                                    Stop the services if running.                                                    |
| remove  |                                                        Remove all services.                                                         |
| update  |                                     Update all the services that have a new version available.                                      |

To start the Application just run:

```shell script
ffighter install
```

And after that

```shell script
ffighter start
```

After the script succeeds you should be able to see the FileFighter application in your browser.  
Depending on your configuration file (see below), you should see the application after running the script [here](http://localhost:80/).  
You should see a login page. For the first setup you can use the credentials.
`username=admin` and `password=admin`
To be sure everything is setup correctly click [here](http://localhost:80/health). If everything is green you are good to go.

## Configuration

The script uses a [config.cfg](config.cfg) file that stores information in `key=value` format.  
Valid keys to configure how FileFighter behaves are listed here:

|         Key         | Possible Values |     Default      |                                                               Description                                                                |
| :-----------------: | :-------------: | :--------------: | :--------------------------------------------------------------------------------------------------------------------------------------: |
|      app_port       |     0-65535     |        80        |                          The port of the application. You can visit the FileFighter application over this port.                          |
|       db_user       |   any string    |       root       |                                           The name of the Database running in the background.                                            |
|     db_password     |   any string    | none (see below) |                 The password of the database. (The database won't be exposed to the internet, but passwords never hurt.)                 |
|       db_name       |   any string    |   filefighter    |                                                        The name of the database.                                                         |
| use_stable_versions |  true / false   |       true       | When set to true the latest stable versions will be used. When set to false always the latest (possible unstable) versions will be used. |

All of these keys use the [default values](./lib/config.cfg.defaults) if you don't overwrite those values.  
It is also possible to have an empty [config.cfg](config.cfg) file as the default values will be used.
If the `db_password` key is empty, a random password will be generated.

Be carefully as the developers of FileFighter won't take responsibility when you are using the application or configuration options wrong or in a not intended way.

# Updating

To update us the update command:

```shell script
ffighter update
```

This will check if new versions of the different services are available and will apply the updates.
Depending on the configuration the update will either use the current stable version (recommended) or the newest latest version (experimental).

In case you are using the latest versions you will also need to install [regclient](https://github.com/regclient/regclient/releases).
Download the right version depending on your operating system and architecture, rename it to 'regctl', make it executable and move it to a folder that is in your path variable.

## Auto update

To achieve automatic updates you can set up a cron job as described in this [article](https://ostechnix.com/a-beginners-guide-to-cron-jobs/) with the update command.

This will also start all services and make them available [here](http://localhost:80/).

# Removing FileFighter

## Removing the command line application

The application is installed under _/usr/bin/ffighter_.
Remove it by typing:

```shell script
sudo rm /usr/bin/ffighter
```

Remove the remaining scripts by removing the folder _filefighter_ in your home directory (/home/YOUR_USERNAME/filefighter) by typing

```shell script
rm-rf /home/YOUR_USERNAME/filefighter
```

<b>Be aware of the fact that the default location of uploaded files and folders will also be in this directory, and thus also deleted!</b>

## Removing docker-compose version of FileFighter

Navigate to the location of the _docker-compose_ file and type:

```shell script
docker-compose down
```

<small>Hint: This command won't remove the files uploaded.</small>

# Troubleshooting

If you encounter error messages like _"No Permission"_ try giving you the permission to execute files for all scripts (/home/YOUR_USERNAME/filefighter).

# Remaining Files

All the remaining not explicitly explained files are important for the scripts to work and should not be changed manually.

# Help

For further help, feedback or questions write us an [email](mailto:dev@filefighter.de).
