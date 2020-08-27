#!/usr/bin/perl
# http://manpages.ubuntu.com/manpages/xenial/man3/Spreadsheet::WriteExcel.3pm.html
use Spreadsheet::WriteExcel;
use DBI;

my $workbook = Spreadsheet::WriteExcel->new('conversions.xls');
$worksheet = $workbook->add_worksheet();
$worksheet->set_column('A:B', 30);

@a = (0..23);

$worksheet->write(A1, @ARGV[0]);
for(@a) {
    $i = $_+2;
    $coord = "A$i";
    if ($_ < 10) {
        $worksheet->write($coord, "0$_:00");
    } else {
        $worksheet->write($coord, "$_:00");
    }
}

$db_host   = '192.168.2.12';
$db_name   = 'timezones';
$db_user   = 'webuser';
$db_passwd = 'insecure_db_pw';

$connection = DBI->connect("DBI:mysql:$db_name:$db_host", $db_user, $db_passwd);

$statement = $connection->prepare("SELECT offset_val FROM locations WHERE code = '@ARGV[0]'");
$statement->execute();
$old_time_val = $statement->fetchrow_array;

$statement = $connection->prepare("SELECT offset_val FROM locations WHERE code = '@ARGV[1]'");
$statement->execute();
$new_time_val = $statement->fetchrow_array;

$hours_diff = ($new_time_val - $old_time_val) / 60;

if ($new_time_val > $old_time_val) {
    $append = "";
} else {
    $append = " the previous day";
}

$worksheet->write(B1, @ARGV[1]);
for(@a) {
    $i = $_+2;
    $coord = "B$i";
    $val = ($_+$hours_diff)%24;
    if ($val < 10) {
        $worksheet->write($coord, "0$val:00$append");
    } else {
        $worksheet->write($coord, "$val:00$append");
    }
    if ($val == 23) {
        if ($append eq "") {
            $append = " the next day";
        } elsif ($append eq " the previous day") {
            $append = "";
        }
    }
}
