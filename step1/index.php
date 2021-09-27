<?php
date_default_timezone_set('Europe/Moscow');

//Сделать веб-страничку запроса курса USD. На странице — форма. В форме поле даты и кнопка "запросить".
//После отправки формы скрипт ищет курс на эту дату в локальной БД. Если его нет — идёт в API ЦБ РФ https://www.cbr.ru/development/SXML/ и 
//вытаскивает курс доллара. Потом сохраняет в локальную БД и выводит пользователю.

if (!isset($_POST['qdate'])){
?>

    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>$$$</title>
        <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    </head>
    <body>
        <form method="post" action="">
            <input class="form-control qdate" type="text" name="qdate">
            <button type="submit">Запросить на дату</button>
        </form>

        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
        <script>
            $(function(){
                $('.qdate').datepicker({
                    dateFormat : "dd-mm-yy"
                });
            });
        </script>
    </body>
    </html>

<?php } else {

    require_once('./config.php');
    
    $cdate = strtotime($_POST['qdate']);

    $dbh = new PDO('mysql:host=' . DBHOST . ';dbname=' . DBNAME, DBUSER, DBPASS);
    $dbh->setAttribute( PDO::ATTR_ERRMODE, PDO::ERRMODE_WARNING );
    
    $stmt = $dbh->prepare("SELECT cval FROM t_curces WHERE cdate = $cdate");
    $stmt->execute();
    $val = $stmt->fetchAll();
    
    if (!$val){
        //echo 'НЕТ ДАННЫХ';

        $qdate = $_POST['qdate'];
        $xmlFile = file_get_contents("https://www.cbr.ru/scripts/XML_daily.asp?date_req=$qdate");
        if(preg_match("%<ValCurs.*?>(.*?)<\/ValCurs>%is", $xmlFile, $m)){
            preg_match_all("%<Valute(.*?)<\/Valute>%is", $xmlFile, $r);

            foreach($r[0] as $row){
                if (strpos($row, 'USD') !== false){
                    preg_match("%<Value>(.*?)<\/Value>%is", $row, $curs);
                    break;
                }
            }

            if (isset($curs[1])){
                $cval  = str_replace(',', '.',  $curs[1]);
                $q = $dbh->prepare("INSERT INTO t_curces (cdate, cval) VALUES ('$cdate', '$cval')");
                $q->execute();                
            }
            else{
                throw new Exception('Что то пошло не так...');
            }

            echo 'КУРС $ на дату [ ' . $_POST['qdate'] . ' ] - <strong>' . $cval . '</strong><br>';
            echo '<a href = "javascript:history.back()">вернуться</a>';
        }        
    }
    else{
        echo 'КУРС $ на дату [ ' . $_POST['qdate'] . ' ] - <strong>' . $val[0]['cval'] . '</strong><br>';
        echo '<a href = "javascript:history.back()">вернуться</a>';
    }
} ?>

