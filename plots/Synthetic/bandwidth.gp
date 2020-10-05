load 'common.gp'

set title 'Подобранная ширина окна'
set xlabel 'Размерность кода'
set ylabel 'Ширина окна'
set xtics 2

data_path = directory_path . 'bandwidth.csv'

set output '/dev/null'
plot data_path
set xrange [0:GPVAL_DATA_X_MAX + 2.0]

set output 'images/bandwidth.png'
plot data_path using 1:2 with points pt 2 ps 2 t 'Ширина окна'