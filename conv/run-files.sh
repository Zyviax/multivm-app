#!/bin/bash
rm conversions.xls
rm conversions.pdf
# Creates spreadsheet using arguments from webserver
perl makeSheet.pl $1 $2
# Sometimes unoconv will fail, so repeats until success
while [ ! -f conversions.pdf ]
do 
    # Converts the spreadsheet to a pdf
    unoconv -f pdf conversions.xls
done  
cp conversions.pdf ../www/conversions.pdf