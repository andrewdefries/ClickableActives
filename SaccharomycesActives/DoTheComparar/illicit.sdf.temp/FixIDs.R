library(ChemmineR)

files<-list.files(pattern=".sdf", recursive=F)

FixIDs<-function(z){
######
sdfset<-read.SDFset(files[z])
######
valid<-validSDF(sdfset)
sdfset<-sdfset[valid]
apset<-sdf2ap(sdfset)
sdfset<-sdfset[!sapply(as(apset,"list"),length)==1]
######
#cid(sdfset)<-datablocktag(sdfset, tag="Click_ID")
cid(sdfset)<-datablocktag(sdfset, tag="DRUGBANK_ID")
write.SDF(sdfset, file=files[z], sig=T, cid=T)
######
}
z<-1:length(files)
lapply(z, FixIDs)
