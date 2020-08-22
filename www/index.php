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
        <form action="/convert.php">
        <label for="convert">Select timezones to convert: </label>
        <select id="from" name="from">
            <?php
                $q = $pdo->query("SELECT * FROM locations");
                while($row = $q->fetch()) {
                    echo "<option value=\"".$row["code"]."\">".$row["code"]."</option>\n";
                }
            ?>
        </select>
        to
        <select id="to" name="to">
            <?php
                $q = $pdo->query("SELECT * FROM locations");
                while($row = $q->fetch()) {
                    echo "<option value=\"".$row["code"]."\">".$row["code"]."</option>\n";
                }
            ?>
        </select>
        <input type="submit">
        </form>
    </body>
</html>