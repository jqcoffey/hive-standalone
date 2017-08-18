# A Standalone Hive Docker Image

A Cloudera pseudo-distributed Hadoop install with Hive and HiveServer2 on top.

We also provide a very small data sample from dvdstore (ref: https://github.com/dvdstore/ds21).

## Build and Run the Image

In one terminal start your docker container (you'll end up with a shell inside it):
```
$> cd docker
$docker> docker build -t jqcoffey/hive-standalone .
...
$docker> docker run -it -p10000:10000 -p8088:8088 jqcoffey/hive-standalone
... (this is going to take a while) ...
========= WELCOME TO YOUR HIVE/HADOOP ENV ===
 Try one of the following commands!

 > sudo -u joe hadoop jar /usr/lib/hadoop-mapreduce/hadoop-mapreduce-examples.jar grep input output23 'dfs[a-z.]+'
 > beeline -n root -p pass -u jdbc:hive2://localhost:10000/default\;auth=noSasl -e 'select count(0) from dvdstore.orders'
 > beeline -n root -p pass -u jdbc:hive2://localhost:10000/default\;auth=noSasl
=============================================
$>
```
