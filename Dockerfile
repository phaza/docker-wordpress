FROM phaza/docker-base
MAINTAINER Peter Haza <peter.haza@gmail.com>

ENV USER root
ENV PASS shefeiheiriehohyohzeequahdieneub
ENV WP_USER wordpress
ENV WP_PASS feteiliwieGh9ai9ahmohZeesa4Iejoe
ENV WP_DB wordpress
ENV APP_ROOT /var/www

RUN apt-get -qqy install apache2 libapache2-mod-php5 mysql-server-5.5 php5-mysql mysql-client-5.5 pwgen
RUN rm -rf /var/www/*

ADD my.cnf /etc/mysql/my.cnf
ADD setup_wordpress.sh setup_wordpress.sh
ADD create_db.sh create_db.sh
ADD apache_foreground.sh apache_foreground.sh
ADD supervisor.conf /etc/supervisor/conf.d/wordpress.conf

ADD http://wordpress.org/latest.tar.gz wordpress.tar.gz
RUN tar xzf wordpress.tar.gz -C $APP_ROOT --strip-components 1
RUN rm wordpress.tar.gz
RUN a2enmod rewrite
RUN sed -i 's/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf

EXPOSE 80
RUN rm /usr/sbin/policy-rc.d
RUN /setup_wordpress.sh

CMD ["/usr/bin/supervisord"]