# K- Means Clustering
# written by KARIMA TAJIN
# Date 2/4/2019

# Write R code from scratch for a K-Means Clustering algorithm
# using Euclidean distances.
# display the plot to visualize where is the elbow point

# K-Means Clustering algorithm steps:
#1. Create random cluster 
#2. Assign each observation to their closest centroid based on the Euclidean distance. 
#3. For each of the K clusters update the cluster centroid by calculating the new mean values.
#4. Repeat until the dataset cluster assignments don't change.



# elbow method steps:
#1. Compute clustering algorithm for different values of k.
#2. for each k, calculate the total within-cluster sum of square(wss)
#3. Plot the curve of wss according to the number of clusters k.
#4. the location of a bend(knee) in the plot is considered as an indicator of the appropriate number of clusters.


# set the working directory:
setwd("/Users/karimaidrissi/Desktop/DSSA 5201 ML")

# import the necessary libraries:
library(tidyverse)
### Importing the data ###
# import the data where there's no header:
Tajin1 <- read.csv("KMeansData_Group1.csv", header = FALSE)
#summary of the data:
summary(Tajin1)
# dimension of the data where there'r 533 rows and 2 columns:
dim(Tajin1)
# header of the data, there'r two variable V1 and V2 
head(Tajin1)

# plotting the relationship between the v1 and v2 in Tajin1 dataset by using ggplot library:
ggplot(data = Tajin1, mapping = aes(x = V1, y= V2)) + geom_point()

### K-MEANS function###      
# k-means function is used to find groups which have not been explicitly labeled in the dataset. 
kmeanstajin <- function(V1,V2,ncluster) {
##1.Create random cluster 
  # start with random cluster x and y centers where there's the number of clusters,
  # the minimum and the maximum value of two vectors V1 and V2.
  xcenter <- runif(n=ncluster, min=min(V1), max=max(V1))
  ycenter <- runif(n=ncluster, min=min(V2), max=max(V2))
  
  # Create a data points and cluster assignment in "Tajin1"
  # cluster coordinates in "clus.coordinate"
  Tajin1 <- data.frame( V1, V2, clus.coordinate =1)
  clus.coordinate <- data.frame(name= 1:ncluster, xcenter = xcenter, ycenter=ycenter)
  
  finish <- FALSE 

  while(finish == FALSE) {
##2.Assign each observation to their closest centroid based on the Euclidean distance. 
    # assign cluster with minimum distance to each data point
    for(i in 1:length(V1)) {
      dist <- sqrt((V1[i]-clus.coordinate$xcenter)^2 + (V2[i]-clus.coordinate$ycenter)^2)
      Tajin1$clus.coordinate[i] <- which.min(dist)
    }
  xcen_old <- clus.coordinate$xcenter
  ycen_old <- clus.coordinate$ycenter
##3.For each of the K clusters update the cluster centroid by calculating the new mean values.
  # calculate new cluster centers
  for(i in 1:ncluster) {
    clus.coordinate[i,2] <- mean(subset(Tajin1$V1, Tajin1$clus.coordinate == i))
    clus.coordinate[i,3] <- mean(subset(Tajin1$V2, Tajin1$clus.coordinate == i))
  } #end for cluster 
##4. Repeat until the dataset cluster assignments don't change.
  if(identical(xcen_old, clus.coordinate$xcenter) & identical(ycen_old, clus.coordinate$ycenter)) 
    finish <- TRUE # stop loop if there's no change in cluster coordinates
  } # end while condition
Tajin1
} # closes kmeans() from scratch 

#  run k-means function with 8 clusters
cluster <- kmeanstajin(Tajin1$V1, Tajin1$V2,8)
cluster
# aggregate the 4 coordinate cluster at the center.
cluster.centers <- aggregate(.~clus.coordinate, cluster,mean)
cluster.centers
# plot K means cluster with 4 clusters
ggplot(cluster, aes(V1, V2, color = as.factor(clus.coordinate))) + 
  geom_point(size=2) + 
  geom_point(data=cluster.centers, aes(V1, V2, col=as.factor(clus.coordinate)), pch=8, size=2) + 
  ggtitle(  "K Means cluster From Scratch by KARIMA TAJIN") + xlab("Variable1") + ylab("Variable2") +
  theme(plot.title = element_text(size = 30, face = "bold"))


# trying another cluster value that is equal to 5
cluster <- kmeanstajin(Tajin1$V1, Tajin1$V2,5)
cluster
cluster.centers <- aggregate(.~clus.coordinate, cluster, mean)
ggplot(cluster, aes(V1, V2, color = as.factor(clus.coordinate))) + 
  geom_point(size=2) + 
  geom_point(data=cluster.centers, aes(V1, V2, col=as.factor(clus.coordinate)), pch=8, size=2) +
  ggtitle(  "K Means cluster From Scratch by KARIMA TAJIN") + xlab("Variable1") + ylab("Variable2") +
  theme(plot.title = element_text(size = 30, face = "bold")) 
# as we can see, after several runs 4 might be the optimal cluster but we will check that with elbow method.

### ELBOW GRAPH ###

# the elbow method is one of the most popular methods used to determine the optimal value of k
# set the seed equal to 123 for reproducible results
set.seed(123)
# function to compute total within-cluster sum of square 
wss <- function(k) {
  kmeans(Tajin1, k, nstart = 10 )$tot.withinss
}
#1. Compute clustering algorithm for different values of k.
# Compute and plot wss for k = 1 to k = 10
k.values <- 1:10
#2. for each k, calculate the total within-cluster sum of square(wss)
# extract wss for 2-10 clusters
wss_values <- map_dbl(k.values, wss)
#3. Plot the curve of wss according to the number of clusters k.
plot(k.values, wss_values,
     type="b", pch = 19, frame = FALSE, 
     xlab="Number of clusters K",
     ylab="Total within-clusters sum of squares",
     main="Optimal Number of Clusters using Elbow Method")

#4. the location of a bend(knee) in the plot is considered as an indicator of the appropriate number of clusters.
# after creating the Elbow method, the graph suggest that 4 is the optimal number of cluster.
# as it appears to be the bend in the knee(or elbow)
# I think the Elbow Method is more accurate than KMeanstajin code that was created from scratch.



       
       