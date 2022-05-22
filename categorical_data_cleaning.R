#====================INTRODUCTION===========================#

# SECTION 1 :Script details----
#:Author,content,date of preparation,contact
#See below an example        

#Author (s): kkitonga
#script content :Data cleaning 
#Date of authorship:15/05/2022

#====================PACKAGES================================#

#SECTION 2 :Install Packages----
#*these four dashes(----) in line will create a section

install.packages("janitor")
install.packages("tidyverse")
install.packages("labelled")
install.packages("epiDisplay")


#===================LOAD FROM LIBRARY========================#

#SECTION 3:loading packages----

library(janitor)                    #data cleaning
library(tidyverse)                  #cleaning and visualization
library(labelled)                   #attaching labels
library(epiDisplay)                 #tabulations

#========================DATA=================================#

#SECTION 3 :DATA:----
#Generating a data set

hhid <- rep(c(576,577,578,579,678,708,709,808,809,900),times=c(5,15,
             13,7,12,8,11,9,14,6))

age_of_hhead <- round(runif(100, min=25, max=78), digits = 0)

gender_of_head <- rep(c(0,1),each=50)

educ_of_hhead <- round(runif(100, min=0, max=20), digits = 0)

income_of_head <- round(runif(100, min=10000, max=100000), digits = 0)

identify_striga <- rep(c(1:4),times=25)

non_agric_income <- rep(c(1, 0, "n/a", "." ),times=c(30,30,20,20))


agric_df <- data.frame(hhid,age_of_hhead,gender_of_head,educ_of_hhead,
                       income_of_head,identify_striga,non_agric_income)


#=========================DATA OVERVIEW========================#

#SECTION 4: Data preliminaries----

View(agric_df)                        #viewing data
names(agric_df)                       #column names
str(agric_df)                         #data structures
agric_df %>% glimpse()   #col names,observations,micro overview
head(agric_df)                        #first 6 observations
tail(agric_df)                        #last six observations
summary(agric_df)                     #summary for each variable

#=======================DATA DUPLICATION======================#

#SECTION 5:Create a data copy----
#always good practice to create a copy for manipulation
#you can make edits on the copy and preserve original
#that way yo do not lose original data

# i call my copy : copy_agric_df
copy_agric_df <-agric_df

#=================NAMING CONVENTION===========================#

#SECTION 6 :Naming convention----

#Tip 1:Be consistent 
#Tip 2: variable names to be concise and make SENSE!
#i prefer snake so i will stick to that

#1.snake convention:copy_agric_df       
#2.camel convention:copyAgricDf    
#3.pascal:CopyAgricDf 

#============LABELLING VARIABLE COLUMNS========================#

#SECTION 7:Labeling columns----

 var_label (copy_agric_df) <- list(hhid = "household id",
                               age_of_hhead = "age of household head",
                               gender_of_head ="gender of household head",
                               educ_of_hhead = "education of household head",
                               income_of_head = "income of household head",
                            
                               identify_striga= "if household identified striga",
                               non_agric_income= "if household earned non-agric income"
                               )
                               
#viewing variable labels
var_label(copy_agric_df )

#===========================TABULATIONS=======================#                               

# SECTION 8: TABULATIONS----

             # Univariate tabulations

#Variable 1:gender
tab1(gender_of_head, decimal = 1, sort.group = FALSE, 
     cum.percent = !any(is.na(ward))) 

#variable 2: hhid
tab1(hhid, decimal = 1, sort.group = FALSE, 
     cum.percent = !any(is.na(ward))) 

            # Cross Tabulations

#tabpct( var 1,var 2)
tabpct(identify_striga, gender_of_head)

#==============Generating categorical variables===============#

#SECTION 8 :Generating categorical variables ----

                        #AGE#

# a.age categories from age_of_hhead

#b.Also attaching value labels
copy_agric_df$age_category <- cut(copy_agric_df$age_of_hhead ,
              breaks=c(20, 40, 60, 80),
              labels=c('youth', 'middleaged', 'old'))


#c.label variable age category
var_label(copy_agric_df) <- list(age_category="age categories 
                                 of household head")

#d.check data type of age_category
str(copy_agric_df $age_category)

#f.view count household count in each category
table(copy_agric_df$age_category)

                    #EDUCATION#

# a.EDUCATION categories from educ_of_hhead
#create 3 categories:
#illiterate,
#primary,
#secondary
#tertiary

#b.Also attaching value labels
copy_agric_df$educ_category <- as.factor(ifelse(copy_agric_df$educ_of_hhead < 1, 'Illiterate',
                            ifelse(copy_agric_df$educ_of_hhead < 9, 'Primary', 
                                          ifelse(copy_agric_df$educ_of_hhead < 17, 'secondary', 'tertiary'))))
#c.check data type of age_category
str(copy_agric_df $educ_category)

#d.view count household count in each category
table(copy_agric_df$educ_category)

                     #INCOME#

#a.INCOME categories from income_of_hhead
#create 3 categories:
#resource constrained,
#rich,
#wealthy

copy_agric_df$income_category <- cut(copy_agric_df$income_of_head ,
                                  breaks=c(0, 30000, 60000, 100000),
                                  labels=c('resource constrained', 'rich', 'wealthy'))

#b.datatype  of var income_category
str(copy_agric_df$income_category)

#c.view count household count in each category
table(copy_agric_df$income_category)

#=============RECODE EXISTING CATEGORICAL VARIABLE============#

#SECTION 9:Re-coding an existing categorical variable----

#i.recode gender_of_head (0 to 1,1 to 2)
#generate a variable (Gender label to store that)

copy_agric_df $Gender_label <-ifelse(copy_agric_df $gender_of_head==0,1,2)

#ii.VERIFY:cross tab
tabpct(gender_of_head,Gender_label)

#iii.View Gender_label in data frame
View(copy_agric_df)


#iv.Variable labels for new variables ======#

var_label (copy_agric_df) <- list(educ_category = "household head education category",
                                  income_category = "household head income category",
                                  Gender_label ="recoded gender variable")


#viewing variable labels
var_label(copy_agric_df )
#=============================================================#