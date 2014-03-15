library(ChemmineR)
files<-list.file(pattern=".sdf", recursive=F)

FixNames<-function(t){
#############################
sdfset<-read.SDFset(files[t])
#############################
cid(sdfset)<-datablocktag(sdfset, tag="DRUGBANK_ID")
write.SDF(sdfset, file=files[t], sig=T, cid=T)
#############################
}
t<-1:length(files)
lapply(t, FixNames)
