--Load wos_id, uspto_id table from wos_references table to uspto database
\COPY (SELECT id, patent_no, RIGHT(patent_no, -3)  FROM wos_references WHERE patent_no IS NOT NULL AND LEFT(patent_no, 2) ILIKE 'US') TO '/people/maahutch/wos_to_patent/wos_to_patent.csv' CSV;

CREATE TABLE uspto_wos_id
(
  wos_id varchar,
  document_id varchar,
  doc_num varchar
)
;

CREATE INDEX doc_num_idx ON uspto_wos_id (doc_num);

VACUUM ANALYZE uspto_wos_id;


--Count Records that match betweeen WoS and uspto
SELECT COUNT(uspto_wos_id.wos_id)
FROM uspto_wos_id
JOIN pubref
ON LEFT(uspto_wos_id.doc_num, 8) = pubref.doc_num
;


--Return first ten records that match between Wos and uspto
SELECT uspto_wos_id.wos_id, uspto_wos_id.document_id, LEFT(uspto_wos_id.doc_num, 8) AS wos_doc_num , pubref.doc_num AS uspto_doc_num
FROM uspto_wos_id
JOIN pubref
ON LEFT(uspto_wos_id.doc_num, 8) = pubref.doc_num
ORDER BY wos_id
LIMIT 10
;
