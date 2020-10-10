load 'common.gp'

if (title == 1){
set title 'Подобранная ширина окна'
}
set xlabel 'Размерность кода'
set ylabel 'Ширина окна'

data_path = autoencoders_results_path . 'bandwidth.csv'

set output '/dev/null'
plot data_path
set xrange [0:GPVAL_DATA_X_MAX + 2.0]

set output 'images/bandwidth' . extension
plot data_path using 1:2 with @plot_points lc rgb "forest-green" t 'Ширина окна'