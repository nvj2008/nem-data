
# Part 3. Exploratory Plots

# 3.A | Price and Demand

# all of nem
plot(nem$TOTALDEMAND,nem$RRP)

# split by state
par("mar")
par(mar=c(1,1,1,1))
par(mfrow=c(2,1))

plot(nem$RRP[nem$REGION=="NSW1"],nem$TOTALDEMAND[nem$REGION=="NSW1"],col=1,main="Price vs Demand by State")
points(nem$RRP[nem$REGION=="QLD1"],nem$TOTALDEMAND[nem$REGION=="QLD1"],col=2)
points(nem$RRP[nem$REGION=="SA1"],nem$TOTALDEMAND[nem$REGION=="SA1"],col=3)
points(nem$RRP[nem$REGION=="VIC1"],nem$TOTALDEMAND[nem$REGION=="VIC1"],col=4)
points(nem$RRP[nem$REGION=="TAS1"],nem$TOTALDEMAND[nem$REGION=="TAS1"],col=5)
points(nem$RRP[nem$REGION=="SNOWY1"],nem$TOTALDEMAND[nem$REGION=="SNOWY1"],col=6)

plot(nem$TOTALDEMAND[nem$REGION=="NSW1"],nem$RRP[nem$REGION=="NSW1"],col=1,main="Demand vs Price by State")
points(nem$TOTALDEMAND[nem$REGION=="QLD1"],nem$RRP[nem$REGION=="QLD1"],col=2)
points(nem$TOTALDEMAND[nem$REGION=="SA1"],nem$RRP[nem$REGION=="SA1"],col=3)
points(nem$TOTALDEMAND[nem$REGION=="VIC1"],nem$RRP[nem$REGION=="VIC1"],col=4)
points(nem$TOTALDEMAND[nem$REGION=="TAS1"],nem$RRP[nem$REGION=="TAS1"],col=5)
points(nem$TOTALDEMAND[nem$REGION=="SNOWY1"],nem$RRP[nem$REGION=="SNOWY1"],col=6)

legend("topright",c("NSW","QLD","SA","VIC","TAS","SNOWY"),lty=c(1,1),lwd=c(2.5,2.5),col=c(1,2,3,4,5,6))


# 3.B | Histogram
par("mar")
par(mar=c(1,1,1,1))
par(mfrow=c(7,1))
x_hist<-hist(nem$RRP,breaks=10000,cex.main=0.7)
x1_hist<-hist(nem$RRP[nem$REGION=="NSW1"],breaks=10000,cex.main=0.7)
x2_hist<-hist(nem$RRP[nem$REGION=="QLD1"],breaks=10000,cex.main=0.7)
x3_hist<-hist(nem$RRP[nem$REGION=="SA1"],breaks=10000,cex.main=0.7)
x4_hist<-hist(nem$RRP[nem$REGION=="VIC1"],breaks=10000,cex.main=0.7)
x5_hist<-hist(nem$RRP[nem$REGION=="TAS1"],breaks=10000,cex.main=0.7)
x6_hist<-hist(nem$RRP[nem$REGION=="SNOWY1"],breaks=10000,cex.main=0.7)

str(nem$RRP)
str(hist(nem$RRP))
str(hist(nem$RRP)$counts)
max(hist(nem$RRP)$counts)
x_max<-max(max(x1_hist$counts),max(x2_hist$counts),max(x3_hist$counts),max(x4_hist$counts),max(x5_hist$counts),max(x6_hist$counts))

par(mfrow=c(1,1))
plot(x1_hist,col=1,xlim=c(-100,400),ylim=c(0,x_max),main="Distribution of Price by State")
lines(x2_hist,col=2)
lines(x3_hist,col=3)
lines(x4_hist,col=4)
lines(x5_hist,col=5)
lines(x6_hist,col=6)
legend("topright",c("NSW","QLD","SA","VIC","TAS","SNOWY"),lty=c(1,1),lwd=c(2.5,2.5),col=c(1,2,3,4,5,6))

par(mfrow=c(1,1))
plot(x1_hist,col=1,xlim=c(-10,100),ylim=c(0,x_max),main="Distribution of Price by State - Zoomed In",cex=0.7)
lines(x2_hist,col=2)
lines(x3_hist,col=3)
lines(x4_hist,col=4)
lines(x5_hist,col=5)
lines(x6_hist,col=6)
legend("topright",c("NSW","QLD","SA","VIC","TAS","SNOWY"),lty=c(1,1),lwd=c(2.5,2.5),col=c(1,2,3,4,5,6))
