library(data.table)
library(RPostgreSQL)
library(stringr)
library(parallel)

cleanFun <- function(htmlString) {
  return(gsub("<.*?>", "", htmlString))
}

#pat_ref <- fread('/N/dc2/scratch/maahutch/patent_to_wos/uspto_ref.csv', sep = ',')

#saveRDS(pat_ref, '/N/dc2/scratch/maahutch/patent_to_wos/uspto_ref.Rds')

pat_ref <- readRDS('/N/dc2/scratch/maahutch/patent_to_wos/uspto_ref.Rds')

drv <- dbDriver("PostgreSQL")

con <- dbConnect(drv, 
                 dbname = "core_data",
                 host = "localhost",
                 user = "cadre_admin"
)


#pat_ref_min <- pat_ref[1:500,]


search_wos <- function(i, con, pat_ref) {
  one.rec <- pat_ref$othercit[i]
  
  
  title <- strsplit(one.rec, '“')
  
  if (length(title[[1]]) > 1) {
    title.2 <- strsplit(title[[1]][[2]], '”')
    
    title.2 <- strsplit(title.2[[1]][1], ' ')
    
    
    # title.3 <- str_replace(title.2[[1]],
    #                        "[[:punct:]]",
    #                        '')
    # 
    # title.3 <- str_replace(title.3, 
    #                       "[^[:alnum:]]", 
    #                        "")
    #title.3 <- str_remove(title.3,
       #                   "[^[:alnum:]]")
    
   
    #title.3 <- str_remove(title.3,
     #                     "[[:punct:]]")
  
    
    #title.3 <- cleanFun(title.3)
    
    title.3 <- gsub("[^\\w\\-\\s]|\\d","",
                    title.2[[1]],
                    perl = TRUE)
    
    title.3 <- paste(title.3, collapse = ' ')
    
    title.3 <- str_squish(title.3)
    
    
    # title.3 <- str_remove(title.3,"<sub>")
    # title.3 <- str_remove(title.3,"<sup>")
    # title.3 <- str_remove(title.3,"<i>")
    # title.3 <- str_remove(title.3,"<u>")
    # title.3 <- str_remove(title.3,"<u")
    # title.3 <- str_remove(title.3,"\+")
    # title.3 <- str_remove(title.3,"\=")
    # title.3 <- str_remove(title.3,"\μ")
    # title.3 <- str_remove(title.3,"<")
    # title.3 <- str_remove(title.3,">")
    # title.3 <- str_remove(title.3,")")
    # title.3 <- str_remove(title.3,"(")
    # title.3 <- str_remove(title.3,"[")
    # title.3 <- str_remove(title.3,"]")
    
    author <- strsplit(title[[1]][[1]], '”')
    
    if (length(author[[1]]) > 0) {
      author.split     <- strsplit(author[[1]], ",")
      author.last.name <- author.split[[1]][1]
      author.last.name <- str_replace_all(author.last.name, "[[:punct:]]", "")
    
    if(is.null(title.3)){  
     
      title.3 <- " "
  
    }
      
      if(is.na(title.3)){  
        
        title.3 <- " "
        
      }
      
      
      if (str_count(title.3, " ") > 1) {
        split.title <- strsplit(title.3, ' ')
        
        
        combo <- paste(split.title[[1]], '', sep = " ")
        
        combo <- str_squish(combo)
        
        combo <- combo[combo != '']
        
        combo <- paste(combo, '<->')
        
        combo[length(combo)] <- gsub(' <->', '', combo[length(combo)])
        
        search.title <- paste(combo, collapse = " ")
        
        
        
        
        query <-
          paste0(
            "WITH title_match AS (
            SELECT id, title, authors_full_name, authors_last_name
            FROM wos_core.interface_table
            WHERE title_tsv @@ to_tsquery('",
            search.title,
            "'
            )
            )
            SELECT id, title, authors_full_name
            FROM title_match
            WHERE authors_last_name ILIKE '%",
            author.last.name,
            "%'"
            )
        
        
        res.df <- dbGetQuery(con, query)
        
        if (nrow(res.df) > 0) {
          res.df <- data.frame(
            res.df,
            pto_auth  = author.last.name,
            pto_id    = pat_ref$doc_num[i],
            pto_title = title.3
          )
          fwrite(
            res.df,
            '/N/dc2/scratch/maahutch/patent_to_wos/first_run.csv',
            col.names = F,
            row.names = F,
            append = T
          )
          
         
        }
      }
    }
  }
}

start <- Sys.time()
lapply(1:nrow(pat_ref), 
       search_wos, 
       con = con, 
       pat_ref)
end <- Sys.time()
print(end-start)








result.df <- as.data.frame(result.l)

fwrite(result.df,
          '/N/dc2/scratch/maahutch/patent_to_wos/first_run.csv', 
       col.names = T, 
       row.names = F)
