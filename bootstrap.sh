#!/bin/bash

service hadoop-hdfs-datanode start
service hadoop-hdfs-namenode start
service hadoop-hdfs-secondarynamenode start
service hadoop-yarn-resourcemanager start
service hadoop-yarn-nodemanager start 
service hadoop-mapreduce-historyserver start
#service mysql start

#mysql -e "create database hive; GRANT ALL ON hive.* TO hive@'localhost' identified by 'metastore'; flush privileges;"

sudo -u hdfs hadoop fs -mkdir /user/joe 
sudo -u hdfs hadoop fs -chown joe /user/joe

sudo -u joe hadoop fs -mkdir input
sudo -u joe hadoop fs -put /etc/hadoop/conf/*.xml input

service hive-server2 start

cd /root
hdfs dfs -put *.csv hdfs:///user/root/ 
hdfs dfs -chmod 666 /user/root/*.csv

echo "Waiting for hive server 2 to really start on port 10000..."
while ! nc -z localhost 10000; do   
  sleep 0.1 # wait for 1/10 of the second before check again
done
echo "go!"

beeline -n root -p pass -u jdbc:hive2://localhost:10000/default\;auth=noSasl -f dvdstore.create.sql

echo "========= WELCOME TO YOUR HIVE/HADOOP ENV ==="
echo " Try one of the following commands!"
echo ""
echo " > sudo -u joe hadoop jar /usr/lib/hadoop-mapreduce/hadoop-mapreduce-examples.jar grep input output23 'dfs[a-z.]+'"
echo " > beeline -n root -p pass -u jdbc:hive2://localhost:10000/default\;auth=noSasl -e 'select count(0) from dvdstore.orders'"
echo " > beeline -n root -p pass -u jdbc:hive2://localhost:10000/default\;auth=noSasl"
echo "============================================="

bash
