#!/bin/bash
perl makeSheet.pl $1 $2
unoconv -f pdf conversions.xls
cp conversions.pdf ../www/conversions.pdf