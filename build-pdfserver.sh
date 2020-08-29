# Update ubtuntu packages
apt-get update

# Installs packages so that perl can communicate with mysql database
apt-get install -y libdbi-perl libdbd-mysql-perl

# Installs packages for creating a spreadsheet in perl and converting the spreadsheet to a pdf
apt-get install -y libspreadsheet-writeexcel-perl python3-uno unoconv libreoffice-calc
