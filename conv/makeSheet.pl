#!/usr/bin/perl
use Spreadsheet::WriteExcel;
use DBI;

my $workbook = Spreadsheet::WriteExcel->new('conversions.xls');
$worksheet = $workbook->add_worksheet();
$worksheet->set_column('A:B', 30);

@a = (0..23);

$worksheet->write(A1, @ARGV[0]);
# Fills first column with times at hour intervals from 00:00 to 23:00
for(@a) {
    $i = $_+2;
    $coord = "A$i";
    $worksheet->write($coord, sprintf("%02d:00", $val));
}

# Sets up connection with mysql database
$db_host   = '192.168.2.12';
$db_name   = 'timezones';
$db_user   = 'webuser';
$db_passwd = 'insecure_db_pw';
$connection = DBI->connect("DBI:mysql:$db_name:$db_host", $db_user, $db_passwd);

# Finds the offset value from the database
$statement = $connection->prepare("SELECT offset_val FROM locations WHERE code = '@ARGV[0]'");
$statement->execute();
$old_time_val = $statement->fetchrow_array;

$statement = $connection->prepare("SELECT offset_val FROM locations WHERE code = '@ARGV[1]'");
$statement->execute();
$new_time_val = $statement->fetchrow_array;

# Calculates hours and minutes differences
$hours_diff = int(($new_time_val - $old_time_val) / 60);
$mins_diff = ($new_time_val - $old_time_val) % 60;

# If true then hour needs to be corrected
if ($mins_diff ne 0 && $hours_diff < 0) {
    $hours_diff = $hours_diff -1;
}

# Comparing the day that the new timezone is in
if ($hours_diff >= 0) {
    if ($hours_diff < 24) {
        $append = "";
    } else {
        $append = "- the next day";
    }
} else {
    if ($hours_diff > -24) {
        $append = "- the previous day";
    } else {
        $append = "- two days behind";
    }
}

$worksheet->write(B1, @ARGV[1]);
# Fills the second column with converted times
for(@a) {
    $i = $_+2;
    $coord = "B$i";
    $val = ($_+$hours_diff)%24;
    $worksheet->write($coord, sprintf("%02d:%02d %s", $val, $mins_diff, $append));
    if ($val == 23) {
        if ($append eq "- two days behind") {
            $append = "- the previous day";
        } elsif ($append eq "- the previous day") {
            $append = "";
        } elsif ($append eq "") {
            $append = "- the next day";
        } elsif ($append eq "- the next day") {
            $append = "- two days ahead";
        }
    }
}
