################################################################################
# Quantitative Economics - Data Management
# Project: Internet coverage on digitally deliverable services trade between EU countries 

################################################################################
library(tidyverse)
library(readxl)
library(data.table)
library(here)
################################################################################

#Use API call to download raw trade in services data from OECD.

here::i_am("eu-services-trade-analysis-qe-2024.Rproj")

start_time <- Sys.time()
ITS_OECD <- read_csv("https://sdmx.oecd.org/public/rest/data/OECD.SDD.TPS,DSD_BOP@DF_TIS,1.0?format=csv"
                     ,col_types = "cccccccccidccc")
elapsed_time <- Sys.time() - start_time

print(elapsed_time) #3.57 mins: good

# bilaterals_oecd <- ITS_OECD %>% select(c(2:5,8,10,11)) %>%
#   filter(UNIT_MEASURE == "USD_EXC") %>% 
#   select(-UNIT_MEASURE)

#Visual inspection
table(bilaterals_oecd$ACCOUNTING_ENTRY)
table(bilaterals_oecd$COUNTERPART_AREA)

partners <- bilaterals_oecd %>% select(COUNTERPART_AREA) %>% distinct()
reporters <- bilaterals_oecd %>% select(REF_AREA) %>% distinct()

#write

fwrite(ITS_OECD,here("raw_data/ITS_OECD_23112024"))

################################################################################
#                               End of script                                  #
################################################################################

