\COPY (SELECT id, wos_total FROM wos_times_cited) TO '~/map4sci-data/raw-data/wos_cite.csv' CSV HEADER;
