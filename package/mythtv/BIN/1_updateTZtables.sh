#!/bin/sh
sudo mysql_tzinfo_to_sql /usr/share/zoneinfo|mysql -uroot mysql
