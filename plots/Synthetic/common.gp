reset

eps = 1

if (eps == 1){
set terminal eps enhanced font "liberation sans,16" fontscale 1.0 size 16, 10
extension = ".eps"
title = 0
}
else{
set terminal pngcairo enhanced font "liberation sans,20" fontscale 1.0 size 1920, 1080
extension = ".png"
title = 1
}

#set datafile separator tab
set datafile separator ','

set style increment default
set xrange  [ 0 : * ] noreverse writeback
set yrange  [ 0 : * ] noreverse writeback
#set zrange  [ * : * ] noreverse writeback
#set cbrange [ * : * ] noreverse writeback
#set rrange  [ * : * ] noreverse writeback

#set format x ""
#set format y ""

set key Left left top reverse

# Шаг делений.

set mxtics 10
set mytics 10

# Сетка.

set style line 100 lt 1 lc rgb "#444444" lw 1
set style line 101 lt 1 lc rgb "#CCCCCC" lw 1
set style line 102 lt 1 lc rgb "#EEEEEE" lw 1

set grid mytics ytics ls 101, ls 102
set grid mxtics xtics ls 101, ls 102

# Масштаб.

set xtics 1
#set ytics 0.1
#set size ratio -10

# Построение графиков.

set pointsize 2
set style data lines

set macro
small_points_common = "points pointsize 1 lw 6"
points_common       = "points pointsize 2 lw 6"
big_points_common   = "points pointsize 4 lw 6"

plot_errbars      = "yerrorbars lw 6"
plot_small_points = small_points_common . "pointtype 2"
plot_points       = points_common . "pointtype 2"
plot_big_points   = big_points_common . "pointtype 2"

data_path = '../../data/'                                        # Директория с данными.
function_path = data_path . 'function_3/8_16/'                   # Директория с данными для выбранной функции.
exp_data_path = function_path . '5.000e-02/'                     # Директория с результатами экспериментов для функции.
dataset_results_path = function_path . '0.000e+00/60000_10000/'  # Директория с результатами экспериментов с набором данных.
autoencoders_results_path = exp_data_path . '30000_10000/'       # Директория с результатами экспериментов с внутренним представлением автокодировщиков.
