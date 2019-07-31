CREATE TABLE paper_meshname(
    pmid varchar, 
    mesh_code varchar,
    meshname varchar, 
    is_major_topic varchar
)
;

\COPY paper_meshname FROM '~/map4sci-data/raw-data/paper_10000_meshname.csv' CSV HEADER; 