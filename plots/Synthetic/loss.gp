load 'common.gp'

if (title == 1){
set title 'Итоговое значение функции потерь'
}
set xlabel 'Размерность кода'
set ylabel 'Значение функции потерь'

file_path = autoencoders_results_path . 'losses.csv'
file_val_path = autoencoders_results_path . 'val_losses.csv'

set output '/dev/null'
plot file_path, file_val_path
set xrange [0:GPVAL_DATA_X_MAX + 2.0]

set output 'images/loss_all' . extension
plot file_val_path using 1:2:(3.8 * $3) with @plot_errbars t 'Валидация', file_path using 1:2:(3.8 * $3) with @plot_errbars t 'Обучение'

set output 'images/loss' . extension
plot file_val_path using 1:2:(3.8 * $3) with @plot_errbars t 'Валидация'

set xtics 2

set logscale y 2
set yrange [*:*]
set format y "2^{%L}"

set logscale x 2
set xrange [*:*]
#set format x "2^{%L}"

set output '/dev/null'
plot file_path, file_val_path
set xrange [GPVAL_DATA_X_MIN / 2.0 : GPVAL_DATA_X_MAX * 2.0]

set output 'images/log_loss_all' . extension
plot file_val_path using 1:2:(3.8 * $3) with @plot_errbars t 'Валидация', file_path using 1:2:(3.8 * $3) with @plot_errbars t 'Обучение'

set output 'images/log_loss' . extension
plot file_val_path using 1:2:(3.8 * $3) with @plot_errbars t 'Валидация'