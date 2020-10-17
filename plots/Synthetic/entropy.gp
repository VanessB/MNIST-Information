load 'common.gp'

if (title == 1){
set title 'Оценка энтропии'
}
set xlabel 'Размерность кода'
set ylabel 'Энтропия, нат'

set mxtics 5

file_path = autoencoders_results_path . 'entropy.csv'

set output '/dev/null'
plot file_path
set xrange [0:GPVAL_DATA_X_MAX + 2.0]

set output 'images/entropy_all' . extension
plot file_path using 1:4:5 with @plot_errbars t 'Убрать один элемент', file_path using 1:2:3 with @plot_errbars t 'Монте-Карло'

set output 'images/entropy' . extension
plot file_path using 1:4:5 with @plot_errbars t 'Убрать один элемент'
