setwd("~tomskawski/Dropbox/Data Science/Data Wrangling")

library("tidyr")
library("dplyr")

## Step 0 - Load data
mydata <- read.csv("refine_original.csv")

# check class of columns. s/b character; if not, convert
str(mydata)
mydata[] <- lapply(mydata, as.character) # [] keeps data.frame, also changes all columns

grep("^p", mydata$company, ignore.case = TRUE, value = TRUE) #value prints data, FALSE gives position
mydata$company <- gsub("\\b(p|f)\\w+", "philips", mydata$company, ignore.case = TRUE) #\\b is word boundary, \\w is word character + gets other characters | is or
grep("\\ba\\w+", mydata$company, ignore.case = TRUE, value = TRUE)
mydata$company <- gsub("\\ba\\w+", "akzo", mydata$company, ignore.case = TRUE)
mydata$company <- gsub("\\ba\\w+\\s\\w+", "akzo", mydata$company, ignore.case = TRUE)
grep("\\bv\\w+\\s\\w+", mydata$company, ignore.case = TRUE, value = TRUE) #\\s\\w+ is for extra word
mydata$company <- gsub("\\bv\\w+\\s\\w+", "van houten", mydata$company, ignore.case = TRUE) #\\s\\w+ is for extra word
grep("\\bu\\w+", mydata$company, ignore.case = TRUE, value = TRUE)
mydata$company <- gsub("\\bu\\w+", "unilever", mydata$company, ignore.case = TRUE)
mydata <- separate(mydata, Product.code...number, c("Prod.code", "Prod.number"), sep = "-")
mydata %>% group_by(company) %>% summarise(country = n())
Prod.code <- c("p", "q", "v", "x")
Prod.cat <- c("Smartphone", "Tablet", "TV", "Laptop")
merge = data_frame(Prod.code, Prod.cat)
mydata <- left_join(mydata, merge)
mydata <- unite(mydata, full_address, address:country, sep = ",") # not sure if this should be a new, combined column, or an additional column
mydata$company_philips <- as.numeric(mydata$company == "philips")
mydata$company_akzo <- as.numeric(mydata$company == "akzo")
mydata$company_unilever <- as.numeric(mydata$company == "unilever")
mydata$company_van_houten <- as.numeric(mydata$company == "van houten")
mydata$product_smartphone <- as.numeric(mydata$Prod.cat == "Smartphone")
mydata$product_tv <- as.numeric(mydata$Prod.cat == "TV")
mydata$product_laptop <- as.numeric(mydata$Prod.cat == "Laptop")
mydata$product_tablet <- as.numeric(mydata$Prod.cat == "Tablet")

