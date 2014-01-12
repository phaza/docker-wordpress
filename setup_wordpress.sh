#!/usr/bin/env bash
#===============================================================================
#
#    AUTHOR: Peter Haza <peter.haza@gmail.com>
#
#===============================================================================
echo "Creating database:"
./create_db.sh
#-------------------------------------------------------------------------------
sed -e "s/database_name_here/$WP_DB/
s/username_here/$WP_USER/
s/password_here/$WP_PASS/
s/localhost/$MYSQL_PORT_3306_TCP_ADDR/
/'AUTH_KEY'/s/put your unique phrase here/$(pwgen -c -n -1 65)/
/'SECURE_AUTH_KEY'/s/put your unique phrase here/$(pwgen -c -n -1 65)/
/'LOGGED_IN_KEY'/s/put your unique phrase here/$(pwgen -c -n -1 65)/
/'NONCE_KEY'/s/put your unique phrase here/$(pwgen -c -n -1 65)/
/'AUTH_SALT'/s/put your unique phrase here/$(pwgen -c -n -1 65)/
/'SECURE_AUTH_SALT'/s/put your unique phrase here/$(pwgen -c -n -1 65)/
/'LOGGED_IN_SALT'/s/put your unique phrase here/$(pwgen -c -n -1 65)/
/'NONCE_SALT'/s/put your unique phrase here/$(pwgen -c -n -1 65)/"             \
$APP_ROOT/wp-config-sample.php > $APP_ROOT/wp-config.php

chown -R www-data: $APP_ROOT
#-------------------------------------------------------------------------------

mv /etc/php5/apache2/php.ini /etc/php5/apache2/php.ini.orig
sed "s/upload_max_filesize = 2M/upload_max_filesize = 20M/" /etc/php5/apache2/php.ini.orig > /etc/php5/apache2/php.ini
