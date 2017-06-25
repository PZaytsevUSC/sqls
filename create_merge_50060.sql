CREATE TEMP TABLE avails_v2_50060 DISTSTYLE KEY DISTKEY (udid) AS
SELECT mds.*
FROM mgrs.mgrs_daily_udid_v2 mds
INNER JOIN profiles.user_keywords_current_wide ukcw ON ukcw.udid = mds.udid
WHERE mds.ds = '2017-04-01'
  AND mds.dmaid IN (602)
  AND ((ukcw.pf_h_ds IS NOT NULL))
LIMIT 50000;

CREATE TEMP TABLE avails_v5_50060 DISTSTYLE KEY DISTKEY (udid) AS
SELECT mds.*
FROM mgrs.jgrs_udid_daily_hourly_v5 mds
INNER JOIN profiles.user_keywords_current_wide ukcw ON ukcw.udid = mds.udid
WHERE mds.ds = '2017-04-01'
  AND mds.dmaid IN (602)
  AND ((ukcw.pf_h_ds IS NOT NULL))
LIMIT 300000;

CREATE TEMP TABLE avails_merge_50060 DISTSTYLE KEY DISTKEY (udid) AS
SELECT v2.mgrs_10m, v2.mgrs_100m, v2.mgrs_1k, v2.mgrs_10k, v2.mgrs_100k,
        v2.stateid, v2.state, v2.zip, v5.udid, v5.net, v5.imps, v5.jgrs_10m,
        v5.jgrs_100m, v5.jgrs_1k, v5.jgrs_10k, v5.postcodeid, v5.cityid, v5.dmaid,
        v5.regionid, v5.hod, v5.dow, v5.carrier, v5.sz, v5.iab, v5.os, v5.ds
FROM avails_v2_50060 v2 INNER JOIN avails_v5_50060 v5
ON v2.udid = v5.udid
LIMIT 300000;

SELECT count(DISTINCT udid) from avails_merge_50060;

INSERT INTO avails_intersec_2.jgrs_udid_daily_hourly_v5
SELECT * FROM avails_merge_50060;

select count(*) from avails_intersec_2.jgrs_udid_daily_hourly_v5;