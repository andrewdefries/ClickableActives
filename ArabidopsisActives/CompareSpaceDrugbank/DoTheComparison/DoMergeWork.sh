rm -r *.temp

for i in *.sdf

do
#######################
mkdir $i.temp
cp hide/ClickableArabidopsisActives.sdf .
babel $i ClickableArabidopsisActives.sdf -O $i.merge.sdf
####
rm ClickableArabidopsisActives.sdf
####
mv $i.merge.sdf $i.temp/
######################

cp *.R $i.temp/

#cp $i $i.temp/
#merge here

cd $i.temp
######################
babel $i.merge.sdf $i.frag.sdf -m 

find . -exec grep -q '\*' '{}' \; -delete
find . -exec grep -q 'R#' '{}' \; -delete
find . -exec grep -q 'A   0  0' '{}' \; -delete

rm $i.merge.sdf
babel *.frag.sdf $i.merge.sdf
#####################
#rm $i.fra*
######################
#R CMD BATCH fmcsRthis.R
R CMD BATCH hwriteMoreNow.R
#####
cd ..
cd ..
#######################
done

