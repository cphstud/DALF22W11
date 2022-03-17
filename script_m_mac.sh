#!/bin/bash -x
find ./matches/* -type f | while read x
do 
  egrep -l "\"male" $x
done | while read x
do 
  grep match_id $x 
done | cut  -d\: -f2 |  cut -d\, -f1 | sort | uniq > listofmalematches
mkdir maletmp
cat listofmalematches | while read x;
do
  cp events/$x.json maletmp;
done
for i in maletmp/*json; do sed -i '' -e 's/^  \"id/  \"_id/g' $i;done
for i in maletmp/*json; do mongoimport -d=statsbomb -c=events --jsonArray $i;done
