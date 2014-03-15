for i in *.sdf

do
#######################
mkdir $i.temp

babel $i ClickableArabidopsisActives.sdf -O $i.merge.sdf

mv $i.merge.sdf $i.temp/


cp *.R $i.temp/

#cp $i $i.temp/
#merge here

cd $i.temp

R CMD BATCH fmcsRthis.R
R CMD BATCH hwriteMoreNow.R

cd ..
#######################
done

