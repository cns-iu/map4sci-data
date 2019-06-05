CREATE TABLE wos_cite(
wos_id varchar, 
wos_total varchar
)

\COPY wos_core FROM '~/map4sci-data/raw-data/med_id_to_wos_id.csv' CSV HEADER; 