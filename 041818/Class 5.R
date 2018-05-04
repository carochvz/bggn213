#' ---
#' title: "Bioinformatics Class 5"
#' author: "Carolina Chavez"
#' date: "041818"
#' ---
#' 
#'output:
html_document:
  code_folding: hide


#Bioinformatics Class 041818
#plots

x <- rnorm(1000, 0)
summary(x)

#lets see this data as a graph
boxplot(x)

#Good old histogram
hist(x)

# Section 1 from lab sheet
baby <- read.table("bggn213_05_rstats/weight_chart.txt", header = TRUE)

plot(baby, type="b", pch=15, cex=1.5, lwd=2, ylim=c(2,10), main="hello")

#Section 1B
feat <- read.table("bggn213_05_rstats/feature_counts.txt", sep="\t",
                   header = TRUE)

par(mar=c(6, 12, 5, 3))
barplot(feat$Count, names.arg=feat$Feature, horiz=TRUE, las=2, ylab="Calolina")

#Section 2
#read.table("bggn213_05_rstats/male_female_counts.txt", sep="\t", header=TRUE)

mfcount <- read.delim("bggn213_05_rstats/male_female_counts.txt")
#barplot(mfcount$Count, col = c("purple", "blue"))
#barplot(mfcount$Count, col=rainbow(10))
barplot(mfcount$Count, col=c("purple2", "pink"))

mycols <- rainbow(nrow(mfcount))
barplot(mfcount$Count, col=mycols)

#Section 2B
expr <- read.delim("bggn213_05_rstats/up_down_expression.txt")
#bottom is purple, middle is yellow, top is pink
palette(c("purple", "yellow", "pink"))
plot(expr$Condition1, expr$Condition2, col=expr$State)

#How may genes went up down and around?
table(expr$State)


