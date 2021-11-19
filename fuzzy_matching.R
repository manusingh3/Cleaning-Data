###fuzzy match 2011 with ref sheet 
##final version 

df_2015 = read.csv("C:\\Users\\manus\\Dropbox (ESOC - Princeton)\\Politics of Consumption\\Data Analysis\\Clean_voting_data\\PS_Clean_Ref\\PS_final_23Feb.csv")
df_2015 = df_2015[,1:3]
colnames(df_2015) = c("s1.i_2015", "2.i_2015", "s1name_2015")
df_2011 = read.csv("C:\\Users\\manus\\Dropbox (ESOC - Princeton)\\Politics of Consumption\\Code\\Fuzzy matching\\2011_ref_names.csv")
df_2011 = df_2011[,-(1:4)]

####Make these anmes characters 
df_2011$final_name_2011 = as.character(df_2011$final_name_2011)
df_2015$s1name_2015 = as.character(df_2015$s1name_2015)

# df_2011 = df_2011[1:100, ]
# df_2015 = df_2015[1:75, ]

library(stringdist)

distance.methods<-c('jw')
dist.methods<-list()
for(m in 1:length(distance.methods))
{
  dist.name.enh<-matrix(NA, ncol = length(df_2011$final_name_2011),nrow = length(df_2015$s1name_2015))
  for(i in 1:length(df_2011$final_name_2011)) {
    for(j in 1:length(df_2015$s1name_2015)) { 
      dist.name.enh[j,i]<-stringdist(tolower(df_2011[i,]$final_name_2011),tolower(df_2015[j,]$s1name_2015),method = distance.methods[m])      
      #adist.enhance(source2.devices[i,]$name,source1.devices[j,]$name)
    }  
  }
  dist.methods[[distance.methods[m]]]<-dist.name.enh
}

match.s1.s2.enh<-NULL
for(m in 1:length(dist.methods))
{
  
  dist.matrix<-as.matrix(dist.methods[[distance.methods[m]]])
  min.name.enh<-apply(dist.matrix, 1, base::min)
  for(i in 1:nrow(dist.matrix))
  {
    s2.i<-match(min.name.enh[i],dist.matrix[i,])
    s1.i<-i
    match.s1.s2.enh<-rbind(data.frame(s2.i=s2.i,s1.i=s1.i,s2name=df_2011[s2.i,]$final_name_2011, s1name=df_2015[s1.i,]$s1name_201, adist=min.name.enh[i],method=distance.methods[m]),match.s1.s2.enh)
  }
}
# Let's have a look at the results
library(reshape2)
matched.names.matrix<-dcast(match.s1.s2.enh,s2.i+s1.i+s2name+s1name~method, value.var = "adist")
View(matched.names.matrix)
write.csv(matched.names.matrix, "matched_names_matrix.csv")
