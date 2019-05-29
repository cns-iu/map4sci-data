library('RPostgreSQL')


drv <- dbDriver("PostgreSQL")

pwd <- read.csv("C:/Users/maahutch/Documents/db_pwd.csv", header =F, stringsAsFactors = F)

med_con <- dbConnect(drv, 
                 host = "dbdev.cns.iu.edu",
                 dbname = "medline_2016", 
                 port = 5432, 
                 user = "maahutch", 
                 password = pwd[1,1]
                 )

med_date <- dbGetQuery(med_con, "SELECT id, article_year FROM medline_article_date")

crosswalk <- dbGetQuery(med_con, "SELECT * FROM wosid_to_pmid")


wos_con <- dbConnect(drv, 
                 host = "dbdev.cns.iu.edu",
                 dbname = "wos_2017", 
                 port = 5432, 
                 user = "maahutch", 
                 password = pwd[1,1]
                 )

wos_cite <- dbGetQuery(wos_con, "SELECT id, wos_total FROM wos_times_cited")





med_and_id <- merge(med_date, crosswalk, by.x = "id", by.y = "pmid_id")


med_and_wos <- merge(med_and_id, wos_cite, by.x = "wos_id", by.y = "id")


combo <- data.frame(med_and_wos[1])


write.csv(combo,
          "C:/Users/maahutch/Documents/medline_x_cite_count.csv", 
          sep = ",",
          header = T)