import pandas


med_id_to_wos_id = pandas.read_csv('~/map4sci-data/raw-data/med_id_to_wos_id.csv', header=None)


wos_cite = pandas.read_csv('~/map4sci-data/raw-data/wos_cite.csv', header=None)



med_and_wos = pandas.merge(med_id_to_wos_id, wos_cite, on='pmid', how='left')


med_and_wos.to_csv('~/map4sci-data/raw-data/medline_x_cite_count_reduced.csv',index=False)


meshname = pandas.read_csv('~/map4sci-data/raw-data/paper_10000_meshname.csv')




