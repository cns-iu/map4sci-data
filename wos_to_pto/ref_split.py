import csv

with open('/people/maahutch/pto_to_wos/pto_samp') as f:
    csv_reader = csv.reader(f)
    for row in csv_reader:
        print row
