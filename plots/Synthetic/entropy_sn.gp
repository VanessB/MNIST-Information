load 'common.gp'

if (title == 1){
set title 'Оценка энтропии'
}
set xlabel 'Размерность кода'
set ylabel 'Энтропия, нат'

file_path_30000 = exp_data_path . '30000_10000/entropy.csv'
file_path_60000 = exp_data_path . '60000_10000/entropy.csv'
file_path_120000 = exp_data_path . '120000_10000/entropy.csv'

set output '/dev/null'
plot file_path_30000, file_path_60000, file_path_120000
set xrange [0:GPVAL_DATA_X_MAX + 2.0]

set output 'images/entropy_sn' . extension
plot file_path_30000 using 1:4 with @plot_points t 'N = 30000', file_path_60000 using 1:4 with @plot_points t 'N = 60000', file_path_120000 using 1:4 with @plot_points t 'N = 120000'