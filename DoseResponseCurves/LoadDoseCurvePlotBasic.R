############
library(drc)
############


HypocotylValues<-read.table("CLK024F02_Dansyl_HighReplicateDoseCurve_HypocotylValues.txt", fill=T)

colnames(HypocotylValues)<-c("Plate", "Well", "Replicate", "Value")

RootValues<-read.table("CLK024F02_Dansyl_HighReplicateDoseCurve_RootValues.txt", fill=T)

colnames(RootValues)<-c("Plate", "Well", "Replicate", "Value")

#######
DoseValue<-c(0,1,5,25,50,75,100)   #in micromolar

PlateRange<-1:3

CellRange<-1:6

PlateCell<-paste(rep(LETTERS[1:4], 4), "0", CellRange, sep="")
#######

HypocotylValues$Well<-gsub("B0[1-6]", "0", HypocotylValues$Well)
HypocotylValues$Well<-gsub("D0[1-6]", "0", HypocotylValues$Well)

HypocotylValues$Well<-gsub("A06", "1", HypocotylValues$Well)
HypocotylValues$Well<-gsub("C06", "1", HypocotylValues$Well)

HypocotylValues$Well<-gsub("A05", "5", HypocotylValues$Well)
HypocotylValues$Well<-gsub("C05", "5", HypocotylValues$Well)

HypocotylValues$Well<-gsub("A04", "25", HypocotylValues$Well)
HypocotylValues$Well<-gsub("C04", "25", HypocotylValues$Well)

HypocotylValues$Well<-gsub("A03", "50", HypocotylValues$Well)
HypocotylValues$Well<-gsub("C03", "50", HypocotylValues$Well)

HypocotylValues$Well<-gsub("A02", "75", HypocotylValues$Well)
HypocotylValues$Well<-gsub("C02", "75", HypocotylValues$Well)

HypocotylValues$Well<-gsub("A01", "100", HypocotylValues$Well)
HypocotylValues$Well<-gsub("C01", "100", HypocotylValues$Well)

#######
RootValues$Well<-gsub("B0[1-6]", "0", RootValues$Well)
RootValues$Well<-gsub("D0[1-6]", "0", RootValues$Well)

RootValues$Well<-gsub("A06", "1", RootValues$Well)
RootValues$Well<-gsub("C06", "1", RootValues$Well)

RootValues$Well<-gsub("A05", "5", RootValues$Well)
RootValues$Well<-gsub("C05", "5", RootValues$Well)

RootValues$Well<-gsub("A04", "25", RootValues$Well)
RootValues$Well<-gsub("C04", "25", RootValues$Well)

RootValues$Well<-gsub("A03", "50", RootValues$Well)
RootValues$Well<-gsub("C03", "50", RootValues$Well)

RootValues$Well<-gsub("A02", "75", RootValues$Well)
RootValues$Well<-gsub("C02", "75", RootValues$Well)

RootValues$Well<-gsub("A01", "100", RootValues$Well)
RootValues$Well<-gsub("C01", "100", RootValues$Well)
	
#######

dose_df<-data.frame(HypocotylValues$Well, HypocotylValues$Value, RootValues$Value) ###, row.names=c("Dose", "Hypocotyl", "Root"))

write.table(dose_df, file="TableReady2Go.txt", quote=T)

dose_df<-read.table("TableReady2Go.txt")

#######

drm(HypocotylValues.Value ~ HypocotylValues.Well, data=dose_df, fct=LL.4())


CLK024F02Dansyl.m1a<-drm(HypocotylValues.Value ~ HypocotylValues.Well, data=dose_df, fct=LL.4(names=c("Slope", "Lower Limit", "Upper Limit", "ED50")))
CLK024F02Dansyl.m1b<-drm(RootValues.Value ~ HypocotylValues.Well, data=dose_df, fct=LL.4(names=c("Slope", "Lower Limit", "Upper Limit", "ED50")))

summary(CLK024F02Dansyl.m1a)
summary(CLK024F02Dansyl.m1b)


pdf(file="TestRun.pdf")

plot(CLK024F02Dansyl.m1a, broken=T)
plot(CLK024F02Dansyl.m1b, broken=T)



dev.off()
