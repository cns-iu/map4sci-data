\COPY (SELECT * FROM med_and_wos RIGHT JOIN paper_meshname ON med_and_wos.pmid = paper_meshname.pmid) TO '~/map4sci-data/raw-data/medline_x_cite_count_reduced.csv' CSV HEADER; 