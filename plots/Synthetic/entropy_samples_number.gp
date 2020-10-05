load 'common.gp'

set title 'Оценка энтропии'
set xlabel 'Размерность кода'
set ylabel 'Энтропия, нат'
set xtics 2

file_path_30000 = function_path . '30000_10000/entropy.csv'
file_path_60000 = function_path . '60000_10000/entropy.csv'
file_path_120000 = function_path . '120000_10000/entropy.csv'

set output '/dev/null'
plot file_path_30000, file_path_60000, file_path_120000
set xrange [0:GPVAL_DATA_X_MAX + 2.0]

set output 'images/entropy_samples_number.png'
plot file_path_30000 using 1:4 with points t '30000', file_path_60000 using 1:4 with points t '60000', file_path_120000 using 1:4 with points t '120000'