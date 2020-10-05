load 'common.gp'

set title 'Оценка энтропии'
set xlabel 'Размерность кода'
set ylabel 'Энтропия, нат'
set xtics 2

file_path = directory_path . 'entropy.csv'

set output '/dev/null'
plot file_path
set xrange [0:GPVAL_DATA_X_MAX + 2.0]

set output 'images/entropy_all.png'
plot file_path using 1:4:5 with @errbars t 'Убрать один элемент', file_path using 1:2:3 with @errbars t 'Монте-Карло'

set output 'images/entropy.png'
plot file_path using 1:4:5 with @errbars t 'Убрать один элемент'