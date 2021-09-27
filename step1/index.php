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
                $('.qdate').datepicker();
            });
        </script>
    </body>
    </html>

<?php } else {

    require_once('./config.php');    

    $dbh = new PDO('mysql:host=' . DBHOST . ';dbname=' . DBNAME, DBUSER, DBPASS);
    $query = $dbh->prepare("SET NAMES utf8");
    $query->execute();

    $stmt = $dbh->prepare('SELECT cval FROM t_curces WHERE cdate = ?');
    $stmt->execute([1001]);
    $val = $stmt->fetchAll();
    
    if (!$val){
        //echo 'НЕТ ДАННЫХ';

        $qdate = $_POST['qdate'];
        $xmlFile = file_get_contents("https://www.cbr.ru/scripts/XML_daily.asp?date_req=$qdate");
        if(preg_match("%<ValCurs.*?>(.*?)<\/ValCurs>%is", $xmlFile, $m)){
            preg_match_all("%<Valute(.*?)<\/Valute>%is", $xmlFile, $r);

            $curs = null;
            foreach($r[0] as $row){
                if (strpos($row, 'USD') !== false){
                    preg_match("%<Value(.*?)<\/Value>%is", $row, $curs);
                    break;
                }
            }

            if (isset($curs[0])){
                $cdate = strtotime($_POST['qdate']);
                $cval  = floatval($curs[0]);

                echo $cval . '<br>';
                echo $curs[0] . '<br>';
                die;

                $sql = "INSERT INTO t_curces (`cdate`, `cval`) VALUES ($cdate, $cval)";
                $stm = $dbh->prepare($sql);

                try{
                    echo $sql;
                    $stm->execute($values);
                }
                catch(Exception $exp){
                    print_r($exp);
                }
            }
            else{
                throw new Exception('Что то пошло не так...');
            }
        }
        
    }
    else{
        echo 'ДАННЫЕ';
    }
} ?>

