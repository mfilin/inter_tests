<style>
    .row{ display: flex; flex-wrap: wrap;}
    .q {padding:30px; border: 1px solid #e3e3e3; text-align: center; min-width: 80px; }
    .q:hover { border: 1px solid #e3e;}
</style>

<?php 

    $m = 4;
    $n = 3;
    $data = matrix($m, $n);
    display($data, $m, $n);

    echo '<br><br>';

    $m = 7;
    $n = 6;
    $data = matrix($m, $n);
    display($data, $m, $n);

    function display($data, $m, $n){
        echo '<div class="matrix">';
        for ($j = 0; $j < $n; $j++) {
            echo '<div class="row">';
            for ($i = 0; $i < $m; $i++) {
                
                echo '<div class="q">' . $data[$i . '_' . $j] . '</div>';
            }
            echo '</div>';
        }
        echo '</div>';
    }

    function matrix($m, $n){

        $arr = [];
        $s = 1;

        // заполнить весь массив нолями
        for ($j = 0; $j < $n; $j++) {
            for ($i = 0; $i < $m; $i++) {
                $arr[ $i . '_' .$j ] = 0;
            }
        }
    
        // периметр массива по часовой стрелке значениями $s
        // горизонтальное расширение - $x
        // вертикальное   расширение - $y
        for ($i = 0; $i < $m; $i++) {
            $arr[$i . '_0'] = $s;
            $s++;
        }
        for ($j = 1; $j < $n; $j++) {
            $arr[($m-1) . '_' . $j] = $s;
            $s++;
        }
        for ($i = $m - 2; $i >= 0; $i--) {
            $arr[$i . '_' . ($n - 1)] = $s;
            $s++;
        }
        for ($j = $n - 2; $j > 0; $j--) {
            $arr['0_' . $j] = $s;
            $s++;
        }

        // заполняем остальное, нолевое
        $x = 1; 
        $y = 1; 
        
        while ($s < $m * $n) {
            // вправо
            while ($arr[($x+1). '_' . $y] == 0) {
                $arr[$x. '_' . $y] = $s;
                $s++;
                $x++;
            }
            // вниз
            while ($arr[$x. '_' . ($y+1)] == 0) {
                $arr[$x. '_' . $y] = $s;
                $s++;
                $y++;
            }
            // влево
            while ($arr[($x-1). '_' . $y] == 0) {
                $arr[$x. '_' . $y] = $s;
                $s++;
                $x--;
            }
            // вверх
            while ($arr[$x. '_' . ($y-1)] == 0) {
                $arr[$x. '_' . $y] = $s;
                $s++;
                $y--;
            }
        }

        for ($j = 0; $j < $n; $j++) {
            for ($i = 0; $i < $m; $i++) {
                if ($arr[ $i . '_' .$j ] == 0){
                    $arr[ $i . '_' .$j ] = $s;
                }
            }
        }
        
        
        // echo '<pre>';
        // print_r($arr);
        // echo '</pre>';

        return $arr;
    }

?>