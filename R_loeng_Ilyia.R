#### R as a calculator ####
2 + 2
3.4/2
x = 3
x + 2
2*x^2
pi

5^2-7*2

#### use of functions, help inside R ####
log(100)
log(100, base=10)

?log
apropos("log") #search for functions with this word
help.search("log")
example(log)


######## Vectors ############

x = c(1,3,4,7) #assigning names. this vector will be stored in your directory
x
y = x + 1
y
c(48,56,79) #this will not

z = rep(1,4)
z
rep(0,10)

1:4
4:1
-1:3
year = 2003:2007
year
seq(1,4)
seq(2, 8, by=2)
v = seq(0, 1, by=.1)
class(v)

seq(0, 1, length=5)
fruits = c("apples","oranges","kiwis","mangos")

as.numeric(c("1","2","3"))
m = c("1","2","3", 4)
m = c(1,2,3,4,"5")

fruits[1] #first element of a vector

length(fruits) #vector length

fruits[length(fruits)]#last element of a vector

fruits[c(1,2)]
fruits[1:3]

fruits[-3]
c(x,z) #concatinate

sin(x[x>=4]+2)^2 + c(3,4)
c(3,4)/2
c(3,4)/c(8,9)

x+3
rev(y) #reverse
y = c(10,6,8,2,10)
sort(y)
order(y)

y[order(y, decreasing=TRUE)]

c(1,2,3,4)/2    
c(1,2,3,4)/c(4,3,2,1)
log(c(0.1,1,10,100), 10)

c(1,2,3,4) + c(4,3,2) #lengthes mismatch


###### Exercise 2 ########
#Add to the fruit vector another vector with pear, repeated 7 times

#Answer:
pears = rep("pear",7)
c(fruits,pears)


######## Matrices ##############

mx = matrix(fruits,2,2)
matrix(c(1,2,4,3,2,5,6,7,5,11,2,3),3,4)
mx2 = matrix(c(1,2,4,3,2,5,6,7,5,11,2,3),3,4, byrow=TRUE)
matrix(rep(10,10), ncol = 5)

mx2[,c(1,2)]
mx2[c(1,2),]

mxnew=mx2[1,]*2
mx2[,2]


mx2[1,3]

mx2*7
mx2[,3]/2
mx2[1,] = mx2[1,]/2


mx3 = cbind(mx2,rep(0,3))

mx2[,2] = rep(3,3)
mx2[,3] = 3
cbind(mx2[,1:2],rep(3,3), mx2[,3:4])

rbind(mx2,c(0,0,0)) #why warning

rbind(mx2,c(0,0,0,0))


###### Exercise 3 #########
#Make a matrix 3x5, with a first row consisting of 1, second - 2 and third - 3s

#Answer:
z = matrix(c(rep(1,5),rep(2,5),rep(3,5)),ncol = 5, byrow = TRUE)


#################Lists#############################
person = list(name="Mike", x=2, y=9, year=1990)
person
person$name #dollar sign
person$x

complicated_list = list("a"= 1:4, "b"=1:3, "c"=matrix(1:4, nrow=2), "d"=search)

complicated_list[[1]]
complicated_list[[1]][2]

complicated_list$a = matrix(1, 2, 2)     # replacing a list element
complicated_list$title ='an arbitrary list' # adding an element
complicated_list$d = NULL                  # removing an element
complicated_list


################# Data frames #############################
#empty one
empty_df = data.frame()

df = data.frame(names = c("Tom","Jerry","Spike"), year=c(1994,1998,2000), x=rep(1,3), y=c(3,5,6))
df$sum = df$x + df$y
df[,1]
df[1,3]
cbind.data.frame(df, m = c(1,2,4))
rbind.data.frame(df,df)
class(df)

####### Exercise 5 ########
#create your own data frame, so that the first column is vector from 1:10, 
#second is the first squared and third is the first + 10

#Answer:
new_df = data.frame(x = 1:10)
new_df$y = new_df$x^2
new_df$z = new_df$x + 10


####### data generation ########
x = runif(100, min = 1, max = 5)
y = rnorm(100)
z = sample(x, size = 5, replace =FALSE) #random sampling
set.seed(1)

sample(c(0,1), 100, replace = TRUE) # sampling with replacement, 0 and 1

hist(x)
hist(y)


######## Just useful commands #############

#-------#
ls()
rm(empty_df)
ls()
getwd()
#setwd("/home/coderus/Education/teach/Rtutorial/")
library()   # see all packages installed 
search()    # see packages currently loaded


#writing your own function
f = function(x,y,z)
{
  res = sqrt(x^2 + y^2 + z^2)
  return(res)
}

f(2,3)


######## Iris data mining #############
#Reading in data
Iris = read.table("iris_na.csv", header=TRUE, sep=',')
colnames(Iris)
# names(Iris) = c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width", "Species") #assign column names
head(Iris)
class(Iris)
str(Iris)
dim(Iris)
nrow(Iris)

#Factor (categorical) variables
levels(Iris$Species)


#manipulating with the data
#illustration with missing data
mean(Iris$Sepal.Width)
mean(Iris$Petal.Length) # returns NA
Iris[!complete.cases(Iris),] # find observations with missing values
mean(Iris$Petal.Length, na.rm=TRUE) # fixed
iris = na.omit(Iris) #case-sensitive!

#Writing data
write.table(iris, "iris.data.csv", col.names = TRUE, row.names = FALSE, sep =',')

#Subsetting data
subset(iris, Sepal.Width >= 4)
subset(iris, Sepal.Width >= 4 & Petal.Length>1.4)
subset(iris, Sepal.Width >= 4 | (Species == 'Iris-versicolor' & Sepal.Width < 3))
subset(iris, Species!="Iris-versicolor" & Sepal.Width <5)

#Add new column
iris$flower = ifelse(iris$Sepal.Length<5, "small_flower","big_flower")
table(iris$flower) # dfrequency of values


#library(Hmisc)
iris$Sepal.Length.bins = cut(iris$Sepal.Length, breaks = 3)
table(iris$Sepal.Length.bins, iris$Species)

aggregate(data = iris, Petal.Length ~ Sepal.Length.bins, mean)


#for loop vs apply
for(i in 1:ncol(iris[,c(1:4)])) {
  print(c(median(iris[,i]), mean(iris[,i]), sd(iris[,i]))) 
}

apply(iris[,c(1:4)], 2, median) 
apply(iris[,c(1:4)], 2, mean)
apply(iris[,c(1:4)], 2, sd) 

summary(iris[,c(1:4)])

####### Plotting basics ##########
#scatterplot
plot(iris$Sepal.Length, iris$Sepal.Width) #spot an outlier
IQR = quantile(iris$Sepal.Width,0.75) - quantile(iris$Sepal.Width,0.25) # interquartile range
outliers = which( iris$Sepal.Width > (quantile(iris$Sepal.Width,0.75) + 1.5*IQR) )
iris[outliers,] # not all are truly outliers
iris = iris[-outliers[2],]
plot(iris$Sepal.Length, iris$Sepal.Width) # plot again without an outlier

plot(iris$Sepal.Length, iris$Sepal.Width, type = 'l')
plot(iris$Sepal.Length, iris$Sepal.Width, col = 'red')
plot(iris$Sepal.Length, iris$Sepal.Width, xlab = "Sepal length", ylab = 'Sepal Width', main = 'Scatterplot', xlim = c(5.5, 8))

##### Dependencies between variables #####
plot(iris[,1:4]) # all-vs-all plotting
cor(iris[,1:4],method = "pearson")

par(mfrow = c(2,2))
plot(iris$Sepal.Length, iris$Sepal.Width)
hist(iris$Petal.Length)
boxplot(iris$Species, iris$Petal.Length)
hist(iris$Petal.Width, freq = FALSE)
lines(density(iris$Petal.Width), col ='red')
par(mfrow=c(1,1))

hist(iris$Sepal.Width)

#install.packages("ggplot2")
library(ggplot2)
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width))+ geom_point()
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width,color = Species))+ geom_point()
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width,color = Species, size = Petal.Width))+ geom_point()
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width))+ geom_point()+facet_grid(Species~.)
