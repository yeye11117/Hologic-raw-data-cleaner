# Load Libraries
#install.packages("tidyverse")
library(tidyverse)

# Load File
raw_df <- read.csv("./Hologic_A10960_Cepheid_Results_20230119.csv")

# Init Variables
clean_df <- data.frame( sample_id = ""
                        ,assay = ""
                        ,test = ""
                        ,start_time = ""
                        ,end_time = "" )[-1,] #[-1,] is to start the df at row 1
end_tag = FALSE

# Start For Loop
for( i in 1:length(raw_df[,1]) ){
  
  if(grepl("^sample(.*)id$", raw_df[i,1], ignore.case = TRUE)){
    
    sample_id <- raw_df[i,2]
    
  }else if(grepl("^assay$", raw_df[i,1], ignore.case = TRUE) == TRUE ){
    
    assay <- raw_df[i,2]
    
  }else if(grepl("^test(.*)result$", raw_df[i,1], ignore.case = TRUE) == TRUE){
    
    test <- raw_df[i,2]
    
  }else if(grepl("start(.*)time$", raw_df[i,1], ignore.case = TRUE) == TRUE){
    
    start_time <- raw_df[i,2]
    
  }else if(grepl("end(.*)time$", raw_df[i,1], ignore.case = TRUE) == TRUE){
    
    end_time <- raw_df[i,2]
    
    end_tag = TRUE
    
  }else if(end_tag == TRUE){
    clean_df <- clean_df %>% add_row( sample_id = sample_id
                                      ,assay = assay
                                      ,test = test
                                      ,start_time = start_time
                                      ,end_time = end_time )
    end_tag = FALSE
  }# End If
}# End For Loop

write.csv(clean_df,"./GX_Result.csv")