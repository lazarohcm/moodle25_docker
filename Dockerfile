############################################################
# Dockerfile to build Moodle_25 container images
# Based on Ubuntu
############################################################

FROM ubuntu:16.04
MAINTAINER Lazaro Marues "lazarohcm@gmail.com"
ENV REFRESHED_AT 2016-06-19

RUN apt-get update
RUN apt-get -y install software-properties-common
RUN apt-add-repository -y ppa:ondrej/php
RUN apt-get update

RUN apt-get -y install apache2
RUN mkdir -p /var/lock/apache2 /var/run/apache2

RUN apt-get -y --allow-unauthenticated install php5.6
RUN apt-get -y --allow-unauthenticated install php5.6-mysql
RUN apt-get -y --allow-unauthenticated install php5.6-mcrypt
RUN apt-get -y --allow-unauthenticated install php5.6-dev
RUN apt-get -y --allow-unauthenticated install php5.6-xml
RUN apt-get -y --allow-unauthenticated install php5.6-curl
RUN apt-get -y --allow-unauthenticated install php5.6-zip
RUN apt-get -y --allow-unauthenticated install php5.6-gd
RUN apt-get -y --allow-unauthenticated install php5.6-soap
RUN apt-get -y --allow-unauthenticated install php5.6-intl 
RUN apt-get -y --allow-unauthenticated install php5.6-xmlrpc 

RUN apt-get -y install curl
RUN apt-get -y install vim

RUN a2enmod rewrite

#Xdebug
RUN apt-get -y --allow-unauthenticated install php-xdebug
RUN echo "xdebug.remote_enable=1" >> /etc/php/5.6/mods-available/xdebug.ini
RUN echo "xdebug.remote_connect_back=1" >> /etc/php/5.6/mods-available/xdebug.ini

# SSH
RUN apt-get -y install openssh-server
RUN echo 'root:root' |chpasswd
RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN mkdir -p /var/run/sshd

#Supervisor
RUN apt-get -y install supervisor
COPY config/supervisor/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN mkdir -p /var/log/supervisor

#ssh apache2
EXPOSE 22 80

CMD ["/usr/bin/supervisord"]