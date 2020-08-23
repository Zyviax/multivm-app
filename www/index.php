<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML//EN">
<html>
    <head>
        <title>Test page</title>
        <link rel="stylesheet" type="text/css" href="style.css">
        <style>
            
        </style>
    </head>
    <body>
        <h1>Test page</h1>
        <p>Showing current timezone conversions:</p>

        <table>
            <tr><th>Code</th><th>Name</th><th>Offset</th><th>Offset value (minutes)</th></tr>
            <?php
                $db_host   = '192.168.2.12';
                $db_name   = 'timezones';
                $db_user   = 'webuser';
                $db_passwd = 'insecure_db_pw';

                $pdo_dsn = "mysql:host=$db_host;dbname=$db_name";

                $pdo = new PDO($pdo_dsn, $db_user, $db_passwd);

                $q = $pdo->query("SELECT * FROM locations");

                while($row = $q->fetch()) {
                    echo "<tr><td>".$row["code"]."</td><td>".$row["name"]."</td><td>".$row["offset"]."</td><td>".$row["offset_val"]."</td></tr>\n";
                }
            ?>
        </table>

        <p>Timezone conversion form</p>
        <form action="/index.php">
        <label for="convert">Select timezones to convert: </label>
        <input type="time" id="time" name="time" pattern="[0-9]{2}:[0-9]{2}" required value=<?php echo $_GET['time']?>>
        <input type="date" id="date" name="date" pattern="[0-9]{4}-[0-9]{2}-[0-9]{2}" required value=<?php echo $_GET['date']?>>
        <select id="from" name="from">
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

        <?php
            if (!is_null($_GET['from'])) {
                echo "from=".$_GET['from']."<br>";
                echo "to=".$_GET['to']."<br>";
                echo "time=".$_GET['time']."<br>";
                echo "date=".$_GET['date']."<br>";

                $from = $_GET['from'] ?: 'GMT';
                $q = $pdo->query("SELECT offset_val FROM locations WHERE code = '$from'");
                $old_time = $q->fetch()["offset_val"];
                
                $to = $_GET['to'] ?: 'GMT';
                $q = $pdo->query("SELECT offset_val FROM locations WHERE code = '$to'");
                $new_time = $q->fetch()["offset_val"];

                $new_date;

                echo $_GET['time']." ".$_GET['date']." ".$_GET['from']." is [enter new time and date here] ".$_GET['to'];

                echo "<br>";
                echo $old_time." ".$new_time;

                
            }
        ?>
    </body>
</html>