CREATE TEMP TABLE avails_v2_50059 DISTSTYLE KEY DISTKEY (udid) AS
SELECT mds.*
FROM mgrs.mgrs_daily_serial_id_v2 mds
INNER JOIN keywords.kwg_cid cid0 ON cid0.serial_id = mds.serial_id
AND cid0.ds = '2017-04-01'
WHERE mds.ds = '2017-04-01'
  AND ((cid0.kwv = '17340'))
LIMIT 50000;

CREATE TEMP TABLE avails_v5_50059 DISTSTYLE KEY DISTKEY (udid) AS
SELECT mds.*
FROM mgrs.jgrs_udid_daily_hourly_v5 mds
WHERE mds.ds BETWEEN '2017-04-01' AND '2017-04-01'
  AND ((mds.cityid = 17340))
LIMIT 50000;


CREATE TEMP TABLE avails_merge_50059 DISTSTYLE KEY DISTKEY (udid) AS
SELECT v2.serial_id, v2.lat, v2.lon, v2.mgrs_1m, v2.mgrs_10m, v2.mgrs_100m, v2.mgrs_1k, v2.mgrs_10k, v2.mgrs_100k,
        v2.stateid, v2.state, v2.zip,
        v5.udid, v5.net, v5.imps, v5.jgrs_10m, v5.jgrs_100m, v5.jgrs_1k, v5.jgrs_10k,
        v5.postcodeid, v5.cityid, v5.dmaid, v5.regionid, v5.hod, v5.dow, 
        v5.carrier, v5.sz, v5.iab, v5.os, v5.ds

FROM avails_v2_50059 v2 INNER JOIN avails_v5_50059 v5
ON v2.udid = v5.udid
LIMIT 300000;


INSERT INTO avails_intersec.jgrs_udid_daily_hourly_v5
SELECT * FROM avails_merge_50059;