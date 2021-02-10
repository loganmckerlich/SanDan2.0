library(dplyr)
library(ggplot2)
library(tidyverse)
library(maps)


desire<-read.csv("san.dan.csv")

desire<-desire %>% 
  rename("Time" = estimated.time..hours.,
         "Desire" = desire.1.10.,
         "Activity" = activity)

plot_desire<-ggplot(data = desire)+
  geom_point(mapping = aes(x=Time,
                           y=Desire,
                           color = Activity),
             size = 7)+
  ggtitle("To-Do List")

table<-kable(desire)

total<- nrow(desire)

tot.time<-sum(desire$Time)

want_most<-desire %>% 
  filter(Desire == max(Desire)) %>% 
  select(Activity)

time_in_sd<-107
free_time_in_sd<-time_in_sd-tot.time
free_time_df<- tibble("Time"=free_time_in_sd, "Activity"= "EXTRA TIME")

desire_for_pie<-desire %>% 
  subset(select = c("Time", "Activity")) %>% 
  full_join(free_time_df)

pie<-ggplot(data = desire_for_pie)+
  geom_col(mapping = aes(x="",
                         y=Time, 
                         fill = Activity),color="white")+
  coord_polar("y", start=0)+
  theme_void()+
  ggtitle("Pie chart of allocation of all 107 hours in San Diego")



