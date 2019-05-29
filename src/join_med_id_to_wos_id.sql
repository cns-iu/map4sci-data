SELECT id AS pmid,
       article_year,
       wosid
FROM medline_article_date
JOIN wosid_to_pmid
ON
medline_article_date.id = wosid_to_pmid.pmid::int
;
