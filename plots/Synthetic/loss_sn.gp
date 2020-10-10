load 'common.gp'

if (title == 1){
set title 'Итоговое значение функции потерь'
}
set xlabel 'Размерность кода'
set ylabel 'Значение функции потерь'

file_path_30000 = exp_data_path . '30000_10000/val_losses.csv'
file_path_60000 = exp_data_path . '60000_10000/val_losses.csv'
file_path_120000 = exp_data_path . '120000_10000/val_losses.csv'

set xtics 2

set logscale y 2
set yrange [*:*]
set format y "2^{%L}"

set logscale x 2
set xrange [*:*]
#set format x "2^{%L}"

set output '/dev/null'
plot file_path_30000, file_path_60000, file_path_120000
set xrange [GPVAL_DATA_X_MIN / 2.0 : GPVAL_DATA_X_MAX * 2.0]

set output 'images/log_loss_sn' . extension
plot file_path_30000 using 1:2 with @plot_points t 'N = 30000', file_path_60000 using 1:2 with @plot_points t 'N = 60000', file_path_120000 using 1:2 with @plot_points t 'N = 120000'
