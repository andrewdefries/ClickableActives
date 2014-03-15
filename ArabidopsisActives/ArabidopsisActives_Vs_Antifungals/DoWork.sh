for i in *.sdf

do

mkdir $i.temp

cp *.R $i.temp/

cp $i $i.temp/
#merge here

cd $i.temp

R CMD BATCH fmcsRthis.R
R CMD BATCH hwriteMoreNow.R

cd ..

done

