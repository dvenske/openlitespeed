FROM debian:jessie
MAINTAINER Deane Venske <deane@venske.net>

# update apt repo
RUN apt-get update

# install dev env
RUN apt-get -y install wget build-essential libssl-dev libpcre3-dev libgeoip-dev libexpat1-dev libxml2

# Fetch Openlistespeed
RUN cd /usr/src && \
	wget http://open.litespeedtech.com/packages/openlitespeed-1.4.14.tgz && \
	tar xf openlitespeed-1.4.14.tgz && \
	cd openlitespeed-1.4.14

# Build
RUN cd /usr/src/openlitespeed-1.4.14 && ./configure && \
	make && \
	make install && \
	chown nobody -R /usr/local/lsws

# openlite config
VOLUME /usr/local/lsws

# set admin password
#RUN ENCRYPT_PASS=`$CUR_DIR/../fcgi-bin/admin_php -q $CUR_DIR/htpasswd.php $PASS_ONE`
#echo "$ADMIN_USER:$ENCRYPT_PASS" > $CUR_DIR/../conf/htpasswd

COPY httpd_conf:/usr/local/lsws/conf/httpd_config

# expose admin
EXPOSE 80

#ENTRYPOINT ["/usr/bin/lswsctrl"]
CMD ["/usr/local/lsws/bin/openlitespeed","-d"]
