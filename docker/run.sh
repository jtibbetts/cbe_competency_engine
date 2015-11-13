#!/bin/bash
#
# Starts the mysql database & runs the rails app.
#
service mysql start
mysql --user="cbeuser" --password="cbepswd" --execute="CREATE DATABASE cbe_competency_engine;"
mysql --user="cbeuser" --password="cbepswd" cbe_competency_engine < ./data/lti2_tc_mysql_init.sql

rails s -p 4000