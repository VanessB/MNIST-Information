load 'common.gp'
load 'common_sn.gp'
load 'subplot_common.gp'

if (title == 1){
set title 'Оценка энтропии'
}
set xlabel 'Размерность кода'
set ylabel 'Энтропия, нат'

set mxtics 5

file_path(i) = exp_data_path . sprintf("%d", Ns[i]) . '_10000/entropy.csv'

set output '/dev/null'
plot for [i=1:total] file_path(i) using 1:4
set xrange [0:GPVAL_DATA_X_MAX + 2.0]

set output 'images/entropy_sn' . extension
plot for [i=1:total] file_path(i) using 1:4 with @plot_points t sprintf("%d", Ns[i])
