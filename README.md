# K-Means Clustering

## Task 

Write R code from scratch for a K-Means Clustering algorithm using Euclidean distances, which prints the total within-cluster sum of squares and displays a graph using the Elbow Method to determine an appropriate K.

Compare the algorithm’s output of clusters to the algorithms in R using kmeans(). Feel free to experiment with alternative measurements but at least one method must employ Euclidean distances.

## K-Means Clustering Algorithm steps
1. Create random cluster 
2. Assign each observation to their closest centroid based on the Euclidean distance. 
3. For each of the K clusters update the cluster centroid by calculating the new mean values.
4. Repeat until the dataset cluster assignments don't change.

## elbow method steps:
1. Compute clustering algorithm for different values of k.
2. for each k, calculate the total within-cluster sum of square(wss)
3. Plot the curve of wss according to the number of clusters k.
4. the location of a bend(knee) in the plot is considered as an indicator of the appropriate number of clusters.
