#!/usr/bin/env bash
#===============================================================================
#
#    AUTHOR: Peter Haza <peter.haza@gmail.com>
#
#===============================================================================

echo "Starting mysql:"
/usr/bin/mysqld_safe &
#-------------------------------------------------------------------------------
until $(mysqladmin ping > /dev/null 2>&1)
do
    :
done
#-------------------------------------------------------------------------------

echo "Setting root password:"
mysqladmin -u $USER password $PASS
mysql -u $USER -p$PASS <<EOF
GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' IDENTIFIED BY '$PASS' WITH GRANT OPTION;
EOF
#-------------------------------------------------------------------------------

mysql -u $USER -p$PASS <<EOF
CREATE DATABASE $WP_DB;
GRANT ALL PRIVILEGES ON $WP_DB.* TO '$WP_USER'@'localhost' IDENTIFIED BY '$WP_PASS';
EOF
#===============================================================================

echo "Restarting mysql:"
mysqladmin -p$PASS shutdown

