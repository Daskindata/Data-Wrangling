use hch_data_compare;


CREATE TABLE mbs_0419_adj
SELECT D.measure, D.auditmonth, D.hchgroup, D.ha75plus, D.ha45to49, D.cdm_gpmp, D.cdm_tca, D.cdm_review, (D.indigenous_ha_55plus + D.indigenous_ha_15to54 + D.indigenous_ha_below15) AS ha715
FROM mbs_0419 D;

CREATE TABLE mbs_0420_adj
SELECT E.measure, E.auditmonth, E.hchgroup, E.ha75plus, E.ha45to49, E.cdm_gpmp, E.cdm_tca, E.cdm_review, (E.indigenous_ha_55plus + E.indigenous_ha_15to54 + E.indigenous_ha_below15) AS ha715
FROM mbs_0419 E;

CREATE TABLE mbs_0421_adj
SELECT F.measure, F.auditmonth, F.hchgroup, F.ha75plus, F.ha45to49, F.cdm_gpmp, F.cdm_tca, F.cdm_review, (F.indigenous_ha_55plus + F.indigenous_ha_15to54 + F.indigenous_ha_below15) AS ha715
FROM mbs_0419 F;

CREATE TABLE hch_all AS
SELECT A.measure, A.auditmonth, A.hchgroup, J.total_population, A.totalcd, D.cdm_gpmp, D.cdm_tca, D.cdm_review, G.mhnumber, 
G.gp_mhtp, G.gp_mhtp_review, A.indigenous, D.ha715 , J.45to49,
D.ha45to49, J.75plus, D.ha75plus
FROM diab_0419 A
LEFT JOIN mbs_0419_adj D
ON A.measure = D.measure
INNER JOIN mbs_mh_0419 G
ON A.measure = G.measure
INNER JOIN pdq_0419 J
ON A.measure = J.measure;

insert into hch_all 
select B.measure, B.auditmonth, B.hchgroup, K.total_population, B.totalcd, E.cdm_gpmp, E.cdm_tca, E.cdm_review, H.mhnumber, 
H.gp_mhtp, H.gp_mhtp_review, B.indigenous, E.ha715, K.45to49,
E.ha45to49, K.75plus, E.ha75plus
from diab_0420 B
left join mbs_0420_adj E
on B.measure = E.measure
inner join mbs_mh_0420 H
on B.measure = H.measure
inner join pdq_0420 K
on B.measure = K.measure;

insert into hch_all
SELECT C.measure, C.auditmonth, C.hchgroup, L.total_population, C.totalcd, F.cdm_gpmp, F.cdm_tca, F.cdm_review, I.mhnumber, 
I.gp_mhtp, I.gp_mhtp_review, C.indigenous, F.ha715, L.45to49,
F.ha45to49, L.75plus, F.ha75plus
FROM diab_0421 C
LEFT JOIN mbs_0421_adj F
ON C.measure = F.measure
INNER JOIN mbs_mh_0421 I
ON C.measure = I.measure
INNER JOIN pdq_0421 L
ON C.measure = L.measure;

SELECT M.measure, M.auditmonth, M.hchgroup, M.total_population, M.totalcd, M.cdm_gpmp, M.cdm_tca, M.cdm_review, M.mhnumber, 
M.gp_mhtp, M.gp_mhtp_review, M.indigenous, M.ha715, M.45to49,
M.ha45to49, M.75plus, M.ha75plus
FROM hch_all M
ORDER BY measure ASC;


CREATE TABLE all_hch_perc
SELECT M.measure, M.auditmonth, M.hchgroup, M.total_population, M.totalcd, M.cdm_gpmp, M.cdm_tca, M.cdm_review, M.mhnumber, 
M.gp_mhtp, M.gp_mhtp_review, M.indigenous, M.ha715, M.45to49,
M.ha45to49, M.75plus, M.ha75Plus,
	   CONCAT(ROUND((M.totalcd / M.total_population * 100),0),'%') AS perc_popcd,
       CONCAT(ROUND((M.cdm_gpmp / M.totalcd * 100),0), '%') AS perc_gpmp,
       CONCAT(ROUND((M.cdm_tca / M.totalcd * 100),0), '%') AS perc_tca,
       CONCAT(ROUND((M.cdm_review / M.totalcd * 100),0), '%') AS perc_review,
       CONCAT(ROUND((M.mhnumber / M.total_population * 100),0), '%') AS perc_mh,
       CONCAT(ROUND((M.gp_mhtp / M.mhnumber * 100),0), '%') AS perc_mhtp,
       CONCAT(ROUND((M.gp_mhtp_review / M.mhnumber * 100),0), '%') AS perc_mhtp_review,
       CONCAT(ROUND((M.indigenous / M.total_population * 100),0), '%') AS perc_indigenous,
       CONCAT(ROUND(( M.ha715 / M.indigenous * 100),0), '%') AS perc_ha715,
       CONCAT(ROUND(( M.45to49 / M.total_population * 100),0), '%') AS perc_45_49,
       CONCAT(ROUND(( M.ha45to49 / M.45to49 * 100),0), '%') AS perc_ha45_49,
       CONCAT(ROUND(( M.75plus / M.total_population * 100),0), '%') AS perc_75plus,
       CONCAT(ROUND(( M.ha75Plus / M.75plus * 100),0), '%') AS perc_ha75plus
       FROM hch_all M
       ORDER BY measure ASC;
  
ALTER TABLE  all_hch_perc
MODIFY 
	perc_popcd varchar(20) AFTER totalcd,
	perc_gpmp varchar(20) AFTER cdm_gpmp,
	perc_tca varchar(20) AFTER cdm_tca,
	perc_review varchar(20) AFTER cdm_review,
	perc_mh varchar(20) AFTER mhnumber,
	perc_mhtp varchar(20) AFTER gp_mhtp,
	perc_mhtp_review varchar(20) AFTER gp_mhtp_review,
	perc_indigenous varchar(20) AFTER indigenous,
	perc_ha715 varchar(20) AFTER ha715,
	perc_45_49 varchar(20) AFTER 45to49,
	perc_ha45_49 varchar(20) AFTER ha45to49,
	perc_75plus varchar(20) AFTER 75plus,
	perc_ha75plus varchar(20) AFTER ha75Plus;
  
