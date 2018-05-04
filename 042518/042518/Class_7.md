---
title: "Bioinformatics 042518"
author: "CC"
date: "April 25, 2018"
output: 
  html_document: 
    keep_md: yes
---



#Functions again

We can source any file of R code with the 'source'() function


```r
source("http://tinyurl.com/rescale-R")
```

Let's make sure things are here


```r
ls()
```

```
##  [1] "both_na"         "both_na2"        "both_na3"       
##  [4] "df1"             "df2"             "df3"            
##  [7] "gene_intersect"  "gene_intersect2" "gene_intersect3"
## [10] "gene_intersect4" "rescale"         "rescale2"
```

Check okur 'rescale()' is working


```r
rescale(1:10)
```

```
##  [1] 0.0000000 0.1111111 0.2222222 0.3333333 0.4444444 0.5555556 0.6666667
##  [8] 0.7777778 0.8888889 1.0000000
```


```r
rescale(c(1:10, "string"))
```


Let's check if 'rescale2()' does any better


```r
rescale2(c(1:10, "string"))
```



##Function for finding missing values in two datasets

Write a 'both_na()' function to do this...


```r
x <- c( 1, 2, NA, 3, NA)
y <- c(NA, 3, NA, 3, 4)

is.na(x)
```

```
## [1] FALSE FALSE  TRUE FALSE  TRUE
```

```r
which(is.na(x))
```

```
## [1] 3 5
```


##The exclamation mark will give the inverse results

```r
which(!is.na(x))
```

```
## [1] 1 2 4
```

##How many total values are we missing

```r
sum(is.na(x))
```

```
## [1] 2
```



```r
is.na(x)
```

```
## [1] FALSE FALSE  TRUE FALSE  TRUE
```

```r
is.na(y)
```

```
## [1]  TRUE FALSE  TRUE FALSE FALSE
```

##LIke in biology the use of AND

```r
is.na(x) & is.na(y)
```

```
## [1] FALSE FALSE  TRUE FALSE FALSE
```


How many TRUE things in total for both x and y in this vector

```r
sum( is.na(x) & is.na(y) )
```

```
## [1] 1
```

My first function can start from this snippet


```r
jboth_na <- function(x, y) {
  sum( is.na(x) & is.na(y))
}
```


Test it

```r
both_na(x, y)
```

```
## [1] 1
```


Testing and failing


```r
x <- c(NA, NA, NA)
y1 <- c( 1, NA, NA)
y2 <- c( 1, NA, NA, NA)

both_na(x, y2)
```

```
## Warning in is.na(x) & is.na(y): longer object length is not a multiple of
## shorter object length
```

```
## [1] 3
```



```r
#both_na2( x, y2 )
```




```r
x <- c( 1, 2, NA, 3, NA)
y <- c(NA, 3, NA, 3, 4)

ans <- both_na3(x, y)
```

```
## Found 1 NA's at position(s):3
```



```r
ans$which
```

```
## [1] 3
```

##Last function that is actually useful


```r
x <- df1$IDs
y <- df2$IDs

x
```

```
## [1] "gene1" "gene2" "gene3"
```

```r
y
```

```
## [1] "gene2" "gene4" "gene3" "gene5"
```


Try the 'intersect()' function and the %in% 

```r
intersect(x, y)
```

```
## [1] "gene2" "gene3"
```

```r
x %in% y
```

```
## [1] FALSE  TRUE  TRUE
```


We can use the logical output in %in%  


```r
x [x %in% y]
```

```
## [1] "gene2" "gene3"
```

```r
y [y %in% y]
```

```
## [1] "gene2" "gene4" "gene3" "gene5"
```

lets put these together as columns of a matrix


```r
cbind(x[x %in% y], y[y %in% x])
```

```
##      [,1]    [,2]   
## [1,] "gene2" "gene2"
## [2,] "gene3" "gene3"
```

Make it into a first function


```r
gene_intersect <- function(x, y) {
cbind( x[ x %in% y ], y[ y %in% x ] )
}
```


Test it

```r
gene_intersect(x, y)
```

```
##      [,1]    [,2]   
## [1,] "gene2" "gene2"
## [2,] "gene3" "gene3"
```


Lets try with data.frame input rather than vectors


```r
gene_intersect2(df1, df2)
```

```
##     IDs exp df2[df2$IDs %in% df1$IDs, "exp"]
## 2 gene2   1                               -2
## 3 gene3   1                                1
```


```r
gene_intersect3(df1, df2)
```

```
##     IDs exp exp2
## 2 gene2   1   -2
## 3 gene3   1    1
```

Use the 'merge()' function for this


```r
merge(df1, df2, by="IDs")
```

```
##     IDs exp.x exp.y
## 1 gene2     1    -2
## 2 gene3     1     1
```


```r
gene_intersect4(df1, df2)
```

```
##     IDs exp exp2
## 2 gene2   1   -2
## 3 gene3   1    1
```


