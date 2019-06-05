#!/bin/bash


psql -h dbdev.cns.iu.edu -d wos_2017 -f ~/map4sci-data/src/wos_cite.sql 

psql -h dbdev.cns.iu.edu -d medline_2016 -f ~/map4sci-data/src/wos_cite_into_medline.sql 

psql -h dbdev.cns.iu.edu -d medline_2016 -f ~/map4sci-data/src/insert_meshname.sql 

psql -h dbdev.cns.iu.edu -d medline_2016 -f ~/map4sci-data/src/create_full_medline_cite_count.sql 

psql -h dbdev.cns.iu.edu -d medline_2016 -f ~/map4sci-data/src/create_red_medline_cite_count.sql 


rm ~/map4sci-data/raw-data/wos_cite.csv