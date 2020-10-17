if (eps == 1){
set terminal eps enhanced font "liberation sans,24" fontscale 1.0 size 16, 10
extension = ".eps"
title = 0
}
else{
set terminal pngcairo enhanced font "liberation sans,32" fontscale 1.0 size 1920, 1080
extension = ".png"
title = 1
}

set macro
small_points_common = "points pointsize 2 lw 8"
points_common       = "points pointsize 4 lw 8"
big_points_common   = "points pointsize 8 lw 8"

plot_errbars      = "yerrorbars lw 4"
plot_small_points = small_points_common . "pointtype 2"
plot_points       = points_common . "pointtype 2"
plot_big_points   = big_points_common . "pointtype 2"
