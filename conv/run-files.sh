#!/bin/bash
# Makes folder for storing pdfs
if [ ! -d /vagrant/www/conversions ];
then
    mkdir /vagrant/www/conversions
fi

# Makes pdfs
# Check that the pdf doesn't already exist
if [ ! -f /vagrant/www/conversions/$1to$2.pdf ]; 
then
    # Creates spreadsheet using arguments from webserver
    perl makeSheet.pl $1 $2
    # Sometimes unoconv will fail, so repeats until success
    while [ ! -f $1to$2.pdf ]
    do 
        # Converts the spreadsheet to a pdf
        unoconv -f pdf $1to$2.xls
    done  
    cp $1to$2.pdf ../www/conversions/$1to$2.pdf
    rm $1to$2.xls
    rm $1to$2.pdf
fi