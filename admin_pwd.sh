#/bin/sh
ENCRYPT_PASS=`/usr/local/lsws/admin/fcgi-bin/admin_php -q /usr/local/lsws/admin/misc/htpasswd.php admin`
echo "admin:$ENCRYPT_PASS" > /usr/local/lsws/conf/htpasswd