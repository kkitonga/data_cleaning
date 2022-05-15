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
install.packages("AER")
install.packages("labelled")


#===================LOAD FROM LIBRARY========================#

#SECTION 3:loading packages----

library(janitor)                    #data cleaning
library(tidyverse)                  #cleaning and visualization
library(AER)                        #To use house price data
library(labelled)                   #attaching labels


#========================DATA=================================#

#SECTION 3 :LOAD DATA:----
#I am using HousePrices data

data(HousePrices)

#======================DATA OVERVIEW=========================#

#SECTION 4: Data preliminaries----

View(HousePrices)                        #viewing data
names(HousePrices)                       #column names
str(HousePrices)                         #data structures
HousePrices %>% glimpse()   #col names,observations,micro overview
head(HousePrices)                        #first 6 observations
tail(HousePrices)                        #last six observations
summary(HousePrices)                     #summary for each variable


#=======================DATA DUPLICATION======================#

#SECTION 5:Create a data copy----
#always good practice to create a copy for manipulation
#you can make edits on the copy and preserve original
#that way yo do not lose original data

# i call my copy : copy_housing_prices

copy_housing_prices <-HousePrices

#=================NAMING CONVENTION===========================#

#SECTION 6 :Naming convention----

#Tip 1:Be consistent 
#Tip 2: variable names to be concise and make SENSE!
#i prefer snake so i will stick to that

#1.snake convention:copy_housing_prices        
#2.camel convention:copyHousingPrices    
#3.pascal:CopyHousingPrices  


#======================RENAMING COLUMNS=======================#

#SECTION 7:RENAMING COLUMNS----

                       #i.Using DPLYR

#method 1 :df %>% rename (new column name=old column name)
#*One column at a time
copy_housing_prices %>% rename(price_today=price)

#method 2 : Many columns at same time
copy_housing_prices %>% rename(bedrooms_chp=bedrooms,
                    bathrooms_chp=bathrooms,
                    stories_chp=stories,
                    driveway_chp=driveway)


                  #ii.using : BASE R

# METHOD 1: names (df) [position of variable]
names(copy_housing_prices) [7] <- "recreation_chp"

# METHOD 2:referencing by column name
names(copy_housing_prices)[names(copy_housing_prices) == 'bathrooms'] <- "bathrooms_chp"


#=================ADDING A COLUMN TO DATAFRAME=================#

#SECTION 8:ADDING A COLUMN----

                     #1.using DPLYR

#e.g creating a variable= garage_two
copy_housing_prices <- mutate(copy_housing_prices,garage_two=0)

                         #OR#

#2.using BASE R
#e.g creating a variable: garage_three

copy_housing_prices$garage_three <-0


#=============RENAMING COLUMNS :USING BASE R==================#

#SECTION 9: Renaming columns(variables)----

#1.adding variable name to a variable
#e.g bedrooms: "no of bedrooms"

var_label(copy_housing_prices$bedrooms) <- "No of bedrooms"

#2.generating variable label
var_label(copy_housing_prices$bedrooms)

#============================================================#
