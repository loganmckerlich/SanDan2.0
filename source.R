library(dplyr)
library(ggplot2)
library(tidyverse)
library(maps)


desire<-read.csv("san.dan.csv")

desire<-desire %>% 
  rename("Time" = estimated.time..hours.,
         "Desire" = desire.1.10.,
         "Activity" = activity)

desire$Activity=str_to_title(desire$Activity)  

plot_desire<-ggplot(data = desire)+
  geom_point(mapping = aes(x=Time,
                           y=Desire,
                           color = Activity),
             size = 7)+
  ggtitle("To-Do List")

table<-kable(desire, caption = "To-Do List")
total<- nrow(desire)

tot.time<-sum(desire$Time)

want_most<-desire %>% 
  filter(Desire == max(Desire)) %>% 
  select(Activity)

time_in_sd<-107
free_time_in_sd<-time_in_sd-tot.time
free_time_df<- tibble("Time"=free_time_in_sd, "Activity"= "EXTRA TIME, for sleep or whatever")

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


#try to show data better
plot_desire_big<-ggplot(data = desire, aes(x=Activity, y=Time, fill = Activity))+
  geom_bar(stat = "identity")+
  ylim(0,5) +
  theme_linedraw() +
  coord_polar(start = 0)
  
  


