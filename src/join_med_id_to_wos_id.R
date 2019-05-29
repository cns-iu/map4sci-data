med_id_to_wos_id <- "SELECT id, article_year, wosid
                     FROM medline_article_date
                     JOIN wosid_to_pmid 
                     ON
                     medline_article_date.id::varchar = wosid_to_pmid.wosid
                     WHERE medline_article_date.article_year > 2005 
                     AND medline_article_date.article_year   < 2016
                      "