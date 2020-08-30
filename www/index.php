<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML//EN">
<?php
    // set up connection to mysql database
    $db_host   = '192.168.2.12';
    $db_name   = 'timezones';
    $db_user   = 'webuser';
    $db_passwd = 'insecure_db_pw';

    $pdo_dsn = "mysql:host=$db_host;dbname=$db_name";

    $pdo = new PDO($pdo_dsn, $db_user, $db_passwd);
?>
<html>
    <head>
        <title>Timezone Converter</title>
        <link rel="stylesheet" type="text/css" href="style.css">
    </head>
    <body>
        <h1><a href="index.php">Timezone Converter</a></h1>
        <h2>Timezone Conversion Form</h2>
        <form action="/index.php">
        <label for="convert">Select time to convert: </label>
        <!-- For date and time inputs, they shouldn't need input validation but on some older browers (and safari) the date and time 
        inputs devolve to basic text inputs. While the small amount of javascript here should help with formatting it is still possible
        to enter invalid data of which output will spew bad data -->
        <input type="time" id="time" name="time" oninvalid="this.setCustomValidity('Please match the 24-hour time format: [HH:MM]')" 
        onchange="try{setCustomValidity('')}catch(e){}" oninput="setCustomValidity('')" pattern="[0-9]{2}:[0-9]{2}" required value=<?php echo $_GET['time']?>>
        <input type="date" id="date" name="date" oninvalid="this.setCustomValidity('Please match the date format: [YYYY-MM-DD]')" 
        onchange="try{setCustomValidity('')}catch(e){}" oninput="setCustomValidity('')" pattern="[0-9]{4}-[0-9]{2}-[0-9]{2}" required value=<?php echo $_GET['date']?>>
        <select id="from" name="from">
            <!-- The first option is only showed after submitting the form, gives the illusion that previously selected inputs are the same, similarily used in 
            time, date where 'value=<\?php echo $_GET[...]?>' is used -->
            <option value="<?php echo $_GET['from']?>" selected hidden><?php echo $_GET['from']?></option>
            <?php
                $q = $pdo->query("SELECT * FROM locations");
                while($row = $q->fetch()) {
                    echo "<option value=\"".$row["code"]."\">".$row["code"]."</option>\n";
                }
            ?>
        </select>
        to
        <select id="to" name="to">
            <!-- Refer to previous comment -->
            <option value="<?php echo $_GET['to']?>" selected hidden><?php echo $_GET['to']?></option>
            <?php
                $q = $pdo->query("SELECT * FROM locations");
                while($row = $q->fetch()) {
                    echo "<option value=\"".$row["code"]."\">".$row["code"]."</option>\n";
                }
            ?>
        </select>
        <input type="submit">
        </form>
        <div id="phpout">
            <?php
                // checks that the form has been used
                if (!is_null($_GET['from'])) {
                    // gets the offset values from the database
                    $from = $_GET['from'] ?: 'GMT';
                    $q = $pdo->query("SELECT offset_val FROM locations WHERE code = '$from'");
                    $old_time_val = $q->fetch()["offset_val"];
                    
                    $to = $_GET['to'] ?: 'GMT';
                    $q = $pdo->query("SELECT offset_val FROM locations WHERE code = '$to'");
                    $new_time_val = $q->fetch()["offset_val"];
                    
                    // calculates time difference
                    $time_diff = $new_time_val - $old_time_val;

                    // processes new date and time
                    $new_date_time = $_GET['time']." ".$_GET['date'];
                    $new_date_time = date('H:i Y-m-d', strtotime($time_diff.' minutes', strtotime($new_date_time)));
                    $new_time = date('H:i', strtotime($new_date_time));
                    $new_date = date('Y-m-d', strtotime($new_date_time));

                    // displays dates and times in a table
                    echo "<table id=\"output\"><tr><th>".$_GET['from']."</th><th>".$_GET['to']."</th></tr>";
                    echo "<tr><td>".$_GET['time']."</td><td>".$new_time."</td></tr>";
                    echo "<tr><td>".$_GET['date']."</td><td>".$new_date."</td></tr>";
                    echo "</table>";
                    
                    // runs a script using ssh onto the pdfserver vm using the arguments of the two timezones
                    $command = "ssh -i /home/vagrant/.ssh/pdf_private_key vagrant@192.168.2.13 'cd /vagrant/conv/; ./run-files.sh ".$_GET['from']." ".$_GET['to']."'";
                    shell_exec($command);

                    echo "<p id=\"aside\">Note that times may not be correct due to daylight savings observed in certain regions.</p>";

                    // displays a pdf file created from the running the above command and a link to it.
                    echo "<object data=\"conversions/".$_GET['from']."to".$_GET['to'].".pdf\" type=\"application/pdf\" width=\"100%\" height=\"100%\">";
                    echo "</object>";
                    echo "<br><a href=\"conversions/".$_GET['from']."to".$_GET['to'].".pdf\">Open Conversion Table</a>";
                }
            ?>
        </div>

        <h2>Current Timezone Conversions</h2>
        <table id="conversions">
            <tr><th>Code</th><th>Name</th><th>Offset</th></tr>
            <?php
                $q = $pdo->query("SELECT * FROM locations");
                // displays all the timezones currently in the database.
                while($row = $q->fetch()) {
                    echo "<tr><td>".$row["code"]."</td><td>".$row["name"]."</td><td>".$row["offset"]."</td></tr>\n";
                }
            ?>
        </table>
    </body>
</html>
