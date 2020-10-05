load 'common.gp'

set title 'Итоговое значение функции потерь'
set xlabel 'Размерность кода'
set ylabel 'Значение функции потерь'
set xtics 2

file_path = directory_path . 'losses.csv'
file_val_path = directory_path . 'val_losses.csv'

set output '/dev/null'
plot file_path, file_val_path
set xrange [0:GPVAL_DATA_X_MAX + 2.0]

set output 'images/loss_all.png'
plot file_val_path using 1:2:(3.8 * $3) with @errbars t 'Валидация', file_path using 1:2:(3.8 * $3) with @errbars t 'Обучение'

set output 'images/loss.png'
plot file_val_path using 1:2:(3.8 * $3) with @errbars t 'Валидация'

set logscale y 2
set yrange [*:*]
set format y "2^{%L}"

set logscale x 2
set xrange [*:*]
#set format x "2^{%L}"

set output '/dev/null'
plot file_path, file_val_path
set xrange [GPVAL_DATA_X_MIN / 2.0 : GPVAL_DATA_X_MAX * 2.0]

set output 'images/log_loss_all.png'
plot file_val_path using 1:2:(3.8 * $3) with @errbars t 'Валидация', file_path using 1:2:(3.8 * $3) with @errbars t 'Обучение'

set output 'images/log_loss.png'
plot file_val_path using 1:2:(3.8 * $3) with @errbars t 'Валидация'