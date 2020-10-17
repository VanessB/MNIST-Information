load 'common.gp'
load 'common_sn.gp'
load 'subplot_common.gp'

if (title == 1){
set title 'Ширина окна'
}
set xlabel 'Размерность кода'
set ylabel 'Ширина окна'

set mxtics 5

file_path(i) = exp_data_path . sprintf("%d", Ns[i]) . '_10000/bandwidth.csv'

set output '/dev/null'
plot for [i=1:total] file_path(i) using 1:2
set xrange [0:GPVAL_DATA_X_MAX + 2.0]

set output 'images/bandwidth_sn' . extension
plot for [i=1:total] file_path(i) using 1:2 with @plot_points t sprintf("%d", Ns[i])
