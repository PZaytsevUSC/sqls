drop table avails_intersec.avails_master;
create table avails_intersec.avails_master(serial_id int8, lat float8, lon float8, 
                                           mgrs_1m int8, mgrs_10m int8, mgrs_100m int8, 
                                           mgrs_1k int8, mgrs_10k int8, mgrs_100k int8, 
                                           stateid int4, state varchar(2), zip varchar(10), 
                                           udid varchar(64), net int4, imps int4, jgrs_10m int8, 
                                           jgrs_100m int8, jgrs_1k int8, jgrs_10k int8, postcodeid int4, 
                                           cityid int4, dmaid int4, regionid int4, hod int2, dow int2, 
                                           carrier varchar(64), sz varchar(64), iab varchar(500), os varchar(64), ds date);
