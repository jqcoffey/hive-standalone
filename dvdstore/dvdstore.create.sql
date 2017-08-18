CREATE DATABASE IF NOT EXISTS dvdstore;

CREATE TABLE IF NOT EXISTS dvdstore.cust_hist (
  customerid String,
  orderid String,
  prod_id String
)
ROW FORMAT SERDE
'org.apache.hadoop.hive.serde2.OpenCSVSerde'
STORED AS TEXTFILE;

LOAD DATA INPATH 'hdfs:///user/root/cust_hist.csv' into table dvdstore.cust_hist;

CREATE TABLE IF NOT EXISTS dvdstore.orderlines (
  orderlineid String,
  orderid String,
  prod_id String,
  quantity String,
  orderdate String
)
ROW FORMAT SERDE
'org.apache.hadoop.hive.serde2.OpenCSVSerde'
STORED AS TEXTFILE;

LOAD DATA INPATH 'hdfs:///user/root/orderlines.csv' into table dvdstore.orderlines;

CREATE TABLE IF NOT EXISTS dvdstore.orders (
  orderid String,
  orderdate String,
  customerid String,
  netamount String,
  tax String,
  totalamount String
)
ROW FORMAT SERDE
'org.apache.hadoop.hive.serde2.OpenCSVSerde'
STORED AS TEXTFILE;

LOAD DATA INPATH 'hdfs:///user/root/orders.csv' into table dvdstore.orders;
