set terminal pngcairo enhanced font "liberation sans,18" fontscale 1.0 size 1920, 1080
#set datafile separator tab

set style increment default
set title  "Энтропия"
set xlabel  'Размерность кода'
set ylabel  'H, нат'
set xrange  [ 0 : * ] noreverse writeback
set yrange  [ 0 : * ] noreverse writeback
#set zrange  [ * : * ] noreverse writeback
#set cbrange [ * : * ] noreverse writeback
#set rrange  [ * : * ] noreverse writeback

#set format x ""
#set format y ""

set key Left left top reverse

# Tics

set mxtics 10
set mytics 10

# Grid

set style line 100 lt 1 lc rgb "#444444" lw 1
set style line 101 lt 1 lc rgb "#CCCCCC" lw 1
set style line 102 lt 1 lc rgb "#EEEEEE" lw 1

set grid mytics ytics ls 101, ls 102
set grid mxtics xtics ls 101, ls 102

# Scale

#set xtics 2
#set ytics 0.1
#set size ratio -10

# Plotting

set pointsize 2
set style data lines

set macro
errbars = "yerrorbars lw 1.5"