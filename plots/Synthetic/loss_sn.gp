load 'common.gp'
load 'common_sn.gp'
load 'subplot_common.gp'

set key Right right top #reverse
#plot_points = points_common

if (title == 1){
set title 'Итоговое значение функции потерь'
}
set xlabel 'Размерность кода'
set ylabel 'Функция потерь'

file_path(i) = exp_data_path . sprintf("%d", Ns[i]) . '_10000/val_losses.csv'

set xtics 2

set logscale y 10
set yrange [*:*]
set format y "10^{%L}"

set logscale x 2
set xrange [*:*]
#set format x "2^{%L}"

set output '/dev/null'
plot for [i=1:total] file_path(i) using 1:2
set xrange [GPVAL_DATA_X_MIN / 2.0 : GPVAL_DATA_X_MAX * 2.0]

set output 'images/log_loss_sn' . extension
plot for [i=1:total] file_path(i) using 1:2 with @plot_points t sprintf("%d", Ns[i])
