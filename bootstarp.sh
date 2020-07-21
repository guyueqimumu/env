#!/usr/bin/bash
readonly LIBXML2_VERSION="2.7.1"
readonly NGINX_VERSION="1.18.0"
readonly PHP_VERSION="7.2.29"
readonly INSTALL_PATH=`pwd`/software
readonly DOWNLOAD_FOLDER=`pwd`/download


#Install PHP dependencies
#if [ ! -e ${DOWNLOAD_FOLDER}/libxml2-${LIBXML2_VERSION}.tar.gz ]
#then
#  wget -P ${DOWNLOAD_FOLDER} http://xmlsoft.org/sources/old/libxml2-${LIBXML2_VERSION}.tar.gz
#fi
#tar -zxvf ${DOWNLOAD_FOLDER}/libxml2-${LIBXML2_VERSION}.tar.gz && cd libxml2-${LIBXML2_VERSION}
#./configure
#make -j4 && make install

#cd ../

yum install -y libxml2-devel  libxml2

# Install PHP
if [ ! -e ${DOWNLOAD_FOLDER}/php-${PHP_VERSION}.tar.gz ]
then
  wget -P ${DOWNLOAD_FOLDER} https://www.php.net/distributions/php-${PHP_VERSION}.tar.gz
fi
tar -zxvf ${DOWNLOAD_FOLDER}/php-${PHP_VERSION}.tar.gz && cd php-${PHP_VERSION}
./configure --prefix=${INSTALL_PATH}/php
make -j4 && make install
cp php-${PHP_VERSION}/php.ini-development ${INSTALL_PATH}/php/etc/php.ini
echo "alias php-${PHP_VERSION}='${INSTALL_PATH}/php/bin/php'" >> ~/.bashrc
cd ../

#Install nginx dependencies
yum install -y zlib-devel pcre-devel

#Install nginx

if [ ! -e ${DOWNLOAD_FOLDER}/nginx-${NGINX_VERSION}.tar.gz ]
then
  wget -P ${DOWNLOAD_FOLDER} http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz
fi
tar -zxvf ${DOWNLOAD_FOLDER}/nginx-${NGINX_VERSION}.tar.gz && cd nginx-${NGINX_VERSION}
./configure --prefix=${INSTALL_PATH}/nginx --sbin-path=${INSTALL_PATH}/nginx/sbin/nginx --conf-path=${INSTALL_PATH}/nginx/config/nginx.conf --error-log-path=${INSTALL_PATH}/nginx/logs/error.log --pid-path=${INSTALL_PATH}/nginx/runtime/nginx.pid --http-log-path=${INSTALL_PATH}/nginx/logs/success.log
make -j4 && make install
echo "alias nginx-${NGINX_VERSION}='${INSTALL_PATH}/nginx/sbin/nginx'" >> ~/.bashrc
cd ../

# execute bashrc file

source  ~/.bashrc

# delete folder

rm -rf libxml2-${LIBXML2_VERSION}  php-${PHP_VERSION}  nginx-${NGINX_VERSION}

