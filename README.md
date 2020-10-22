# FileFighter Setup
Setup Scripts for clients to download.  
![Release](https://img.shields.io/github/v/release/filefighter/clientsetup?color=dark-green&label=Latest%20Version&logo=github&style=for-the-badge)

## Requirements

### Operating Systems
Currently, we support only Unix-like operating systems like [Ubuntu](https://ubuntu.com). MacOs is still on our roadmap.  
For windows systems you could use [wsl](https://en.wikipedia.org/wiki/Windows_Subsystem_for_Linux) to set that up read more [here](https://docs.microsoft.com/en-us/windows/wsl/install-win10).

### Dependencies
One of the of goals of FileFighter is, that the client, that's you, only needs to met only one single dependency.  
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

## Usage
After successfully installing Docker you can start using FileFighter.  
Just download this repository as a zipfile [here](https://github.com/FileFighter/ClientSetup/releases/).  
This repository contains one <!-- three --> important script:   
The [initial start](./init_setup.sh) script starts downloading all the services and starts them in different containers. Run it with 
```shell script
./init_setup
```
After starting the script you should see something like the following:
```shell script
-------------------------< FileFighter >--------------------------
|              Version 1.0 Last updated at 14.10.20              |
|         Developed by Gimleux, Valentin, Open-Schnick.          |
|       Development Blog: https://filefighter.github.io          |
|  The code can be found at: https://www.github.com/filefighter  |
--------------------< Started Initial Setup >---------------------
```
After the script succeeds you should be able to see the FileFighter application in your browser.  
Depending on your configuration file (see below), you should see the application after running the script [here](http://localhost:80/).  
You should see a login page. For the first setup you can use the credentials 
`username=admin password=admin`
To be sure everything is setup correctly click [here](http://localhost:80/health). If everything is green you are good to go.

### Configuration
The script uses a [config.cfg](./config.cfg) file that stores information in `key=value` format.  
Valid keys to configure how FileFighter behaves are listed here:

| Key      | Possible Values | Default | Description |
| :----:   | :----:          |  :----: |  :----:  |
| rest_port | 0-65535  | 8080 | The port of the restapi service that will be published for the frontend. |
| frontend_port | 0-65535  | 80 | The port of the webapp (frontend) service. You can visit the FileFighter application over this port. |
| db_user | any string | root | The name of the Database running in the background. |
| db_password | any string | none (see below) | The password of the database. (The database won't be exposed to the internet, but passwords never hurt.) |
| db_port | 0-65535 | 27017  | The port of the database.  |
| db_name | any string | filefighter | The name of the database. |
| use_stable_versions | true / false | true | When set to true the latest stable versions will be used. When set to false always the latest (possible unstable) versions will be used. |

All of these keys use the [default values](./lib/config.cfg.defaults) if you don't overwrite those values.  
It is also possible to have an empty [config.cfg](./config.cfg) file as the default values will be used.
If the `db_password` key is empty, a random password will be generated.

Be carefully as the developers of FileFighter won't take responsibility when you are using the application or configuration options wrong or in a not intended way.

## Remaining Files
All the remaining not explicitly explained files are important for the scripts to work.

## Help
For further help, feedback or questions write us an [email](mailto:filefighter@t-online.de).
