#!/usr/bin/perl
# http://manpages.ubuntu.com/manpages/xenial/man3/Spreadsheet::WriteExcel.3pm.html
use Spreadsheet::WriteExcel;

my $workbook = Spreadsheet::WriteExcel->new('conversions.xls');
$worksheet   = $workbook->add_worksheet();

my @a = (1..24);
for(@a) {
    my $i = $_+1;
    my $coord = "A$i";
    if ($_ < 10) {
        $worksheet->write($coord, "0$_:00");
    } else {
        $worksheet->write($coord, "$_:00");
    }
}