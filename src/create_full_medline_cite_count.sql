CREATE VIEW med_and_wos AS (
    SELECT id AS pmid, article_year, wosid FROM medline_article_date JOIN wosid_to_pmid ON medline_article_date.id = wosid_to_pmid.pmid::int WHERE article_year::int >= 2006 AND article_year::int <= 2016
)
;

\COPY (SELECT * FROM med_and_wos) TO '~/map4sci-data/raw-data/medline_x_cite_count.csv' CSV HEADER; 