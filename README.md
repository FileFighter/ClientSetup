# FileFighter Setup
Setup Scripts for clients to download.  
![Release](https://img.shields.io/github/v/release/filefighter/clientsetup?color=dark-green&label=Latest%20Version&logo=github&style=for-the-badge)

## Requirements

### Operating Systems
Currently, we support only Unix-like operating systems like [Ubuntu](https://ubuntu.com). MacOs is still on our roadmap.  
For windows systems you could use [wsl](https://en.wikipedia.org/wiki/Windows_Subsystem_for_Linux). To set that up read more [here](https://docs.microsoft.com/en-us/windows/wsl/install-win10).

### Dependencies
One of the of goals of FileFighter is, that the client, that's you, only needs to met one single dependency.  
You need [Docker](https://www.docker.com/).    
Docker is a way to organise and run multiple applications. You can imagine it like a virtual machine (technical it`s a bit different), with a small file- and operating system within your machine.
Sounds more scary than it actually is. Different Applications run in different containers, these only contain the necessary software to run the application.  
The containers use the resources of the host machine, depending on the load.  
Advantages are security and the possibility to easily shutdown and update the services. See more under [Usage](#Usage).

#### Docker
First check whether you have Docker already installed.  
To do that run:  
```shell script
docker -v
```
If you see something like that (your version might be different):
```shell script
Docker version 19.03.13, build 4484c46d9f
```
You are good to go, and you can skip to [Usage](#Usage).

To install **Docker** on Unix you can either use [snap](https://www.howtogeek.com/660193/how-to-work-with-snap-packages-on-linux/) or [apt](https://en.wikipedia.org/wiki/APT_(software)) as a package manager.  
With snap its easier but of course it's not always possible to use snap.  

##### Install with Snap
To install Docker with [snap](https://www.howtogeek.com/660193/how-to-work-with-snap-packages-on-linux/) you can run:
```shell script
sudo snap install docker
```
##### Install with Apt
Installing with [apt](https://en.wikipedia.org/wiki/APT_(software)) is a bit more difficult you can read [here](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-Docker-on-ubuntu-20-04) more about it.

## Installing FileFighter
After successfully installing Docker you can start using FileFighter.  
Just download this repository as a zipfile [here](https://github.com/FileFighter/ClientSetup/releases/).  
This repository contains the *Install.sh* installation script.  
 ```shell script
 dev@filefighter:~/Downloads/FileFighter-1.3 $ ls
 config.cfg  ffighter  Install.sh  lib  README.md
 ```  
You can execute the script:
```shell script
dev@filefighter:~/Downloads/FileFighter-1.3 $ ./Install.sh
```
And you should see something like that:
```shell script
dev@filefighter:~/Downloads/FileFighter-1.3 $ ./Install.sh 
Adding FileFighter Application to PATH...
Adding FileFighter Application to PATH was successful.
Please run the following command to finish the installation.

source /home/dev/.bashrc
```
Running this command will add the FileFighter Application to your System.
## Running FileFighter
You can use the FileFighter Application with the command *ffighter*  
Running this command should show you something like that:
```shell script
dev@filefighter:~/Downloads/FileFighter-1.3 $ ffighter
  _____   _   _          _____   _           _       _                 
 |  ___| (_) | |   ___  |  ___| (_)   __ _  | |__   | |_    ___   _ __ 
 | |_    | | | |  / _ \ | |_    | |  / _` | | '_ \  | __|  / _ \ | '__|
 |  _|   | | | | |  __/ |  _|   | | | (_| | | | | | | |_  |  __/ | |   
 |_|     |_| |_|  \___| |_|     |_|  \__, | |_| |_|  \__|  \___| |_|   
                                     |___/                             
                   Version v1.3 Last updated: 08.11.20
              Developed by Gimleux, Valentin, Open-Schnick.            
             Development Blog: https://filefighter.github.io           
       The code can be found at: https://www.github.com/filefighter    

-------------------------< Show Usage >---------------------------

usage: ffighter <args>

  status    - show status of the FileFighter application.
  install   - install the FileFighter application.
  start     - start the services.
  stop      - stop the services.
  remove    - remove all services.
```
You can see all the available options to run with *ffighter*.  

| Option      | Description |
| :----:   |  :----:  |
| status | This command shows you information about the status of the application, like installation status, whether its running or not etc... | 
| install | Download and create all necessary services. |
| start | Start the services if already downloaded. |
| stop | Stop the services if running. |
| remove | Remove all services. |
| update | Update all the services that have a new version available. |

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

### Configuration
The script uses a [config.cfg](config.cfg) file that stores information in `key=value` format.  
Valid keys to configure how FileFighter behaves are listed here:

| Key      | Possible Values | Default | Description |
| :----:   | :----:          |  :----: |  :----:  |
| app_port | 0-65535  | 80 | The port of the application. You can visit the FileFighter application over this port. |
| db_user | any string | root | The name of the Database running in the background. |
| db_password | any string | none (see below) | The password of the database. (The database won't be exposed to the internet, but passwords never hurt.) |
| db_name | any string | filefighter | The name of the database. |
| use_stable_versions | true / false | true | When set to true the latest stable versions will be used. When set to false always the latest (possible unstable) versions will be used. |

All of these keys use the [default values](./lib/config.cfg.defaults) if you don't overwrite those values.  
It is also possible to have an empty [config.cfg](config.cfg) file as the default values will be used.
If the `db_password` key is empty, a random password will be generated.

Be carefully as the developers of FileFighter won't take responsibility when you are using the application or configuration options wrong or in a not intended way.

## Updating
To update us the update command:

```shell script
ffighter update
```
This will check if new versions of the different services are available and will apply the updates.
Depending on the configuration the update will either use the current stable version (recommended) or the newest latest version (experimental).

In case you are using the latest versions you will also need to install [regclient](https://github.com/regclient/regclient/releases).
Download the right version depending on your operating system and architecture, rename it to 'regctl', make it executable and move it to a folder that is in your path variable.

### Auto update
To achieve automatic updates you can set up a cron job as described in this [article](https://ostechnix.com/a-beginners-guide-to-cron-jobs/) with the update command.

## Other operation systems (Windows)

If you are not able to run the shell script for the installation you can still run FileFighter using [Docker Compose](https://docs.docker.com/compose/).
Just download the [docker-compose.yml](https://raw.githubusercontent.com/FileFighter/ClientSetup/master/docker-compose.yml) file or clone this repo and execute this command in the folder where the file is located: 

```shell script
docker-compose up
```
This will also start all services and make them available [here](http://localhost:80/).


## Remaining Files
All the remaining not explicitly explained files are important for the scripts to work and should not be changed manually.

## Help
For further help, feedback or questions write us an [email](mailto:dev@filefighter.de).
