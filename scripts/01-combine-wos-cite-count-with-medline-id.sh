#!/bin/bash

psql -h dbdev.cns.iu.edu -d medline_2016 -f ~/map4sci-data/src/med_id_to_wos_id.sql 

psql -h dbdev.cns.iu.edu -d wos_2017 -f ~/map4sci-data/src/wos_cite.sql 

