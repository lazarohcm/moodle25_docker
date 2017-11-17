# Docker Image to run a Moodle 25 enviroment
** Experimental project

## How to
To build the image from source:

    git clone https://github.com/lazarohcm/moodle25_docker.git
    cd moodle25_docker
    docker build -t lazarohcm/moodle25

Then run the container

    sudo docker run -it --add-host=database:172.17.0.1 --name=php56 -p 3030:3030 -v /var/www:/var/www lazarohcm/moodle25 bash


The `--add-host=database` is the host that you gonna set when configuring the moodle database address
The directory mapping `/var/www:/var/www` is the one that contain the moodle source code and where moodle will create the moodledata folder

## After Running the container
Make sure you start the Apache server (`service apache2 start`)

