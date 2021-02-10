library(dplyr)
library(ggplot2)
library(tidyverse)
library(maps)
desire<-read.csv("san.dan.csv")
colnames(desire)

desire<-read.csv("san.dan.csv")

desire<-desire %>% 
  rename("Time" = estimated.time..hours.,
         "Desire" = desire.1.10.,
         "Activity" = activity)

plot_desire<-ggplot(data = desire)+
  geom_point(mapping = aes(x=Time,
                           y=Desire,
                           color = Activity),
             size = 7)

table<-kable(desire)

total<- nrow(desire)

tot.time<-sum(desire$Time)

want_most<-desire %>% 
  filter(Desire == max(Desire)) %>% 
  select(Activity)


