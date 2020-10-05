set terminal pngcairo enhanced font "arial,18" fontscale 1.0 size 1920, 1080
#set datafile separator tab

set style increment default
set title  "Корреляционная размерность"
set xlabel  'ln(r)'
set ylabel  'ln(2 · P / N^2)'
set xrange  [ * : * ] noreverse writeback
set yrange  [ * : 2 ] noreverse writeback
#set zrange  [ * : * ] noreverse writeback
#set cbrange [ * : * ] noreverse writeback
#set rrange  [ * : * ] noreverse writeback

#set format x ""
#set format y ""

# Filenames

set datafile separator ","

total = 20
array dim = [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 18, 20, 22, 24, 28]
file(n) = sprintf("data/%d.csv", dim[n])

# Functions

#a = 5.0
#b = -1.0
f(x) = a*x + b

array A[total]
array B[total]
do for [i=1:total] {
    print file(i)
    fit[*:*][-16:-10] f(x) file(i) using 1:2 via a, b
    A[i] = a
    B[i] = b
}

as = 10.0
ab = -1.0
g(x) = as * x + bs

fit [*:*][-11:-4] g(x) 'data/source.csv' using 1:2 via as, bs

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

# Palette

h1 = 230.0/360.0
h2 = 360.0/360.0
s = 1.0
v = 1.0
gradient(x) = hsv2rgb((h2-h1)*x + h1, s, v)
dimg(start, end, i) = gradient((dim[i] - dim[start]) * 1.0 / (dim[end] - dim[start]))

# Plotting

set macro
plot_points = "with points pointtype 2"
plot_lines = "t sprintf(\"d = %d, d_{corr} = %3.3f\", dim[i], a)"

set output 'images/all.png'
plot [*:*] for [i=1:total] file(i) using 1:2 @plot_points lc rgb gradient(i * 1.0 / total) notitle

set output 'images/cropped.png'
min = -18
max = 1
filter(x)=(( (x <= max)?(x):(1/0) ) >= min)?(x):(1/0)
plot [-10:*][-20:2] for [i=1:total] file(i) using 1:(filter($2)) @plot_points lc rgb gradient(i * 1.0 / total) notitle

set output 'images/fitted.png'
plot [*:6][-23:-5] \
for [i=1:total] file(i) using 1:2 @plot_points lc rgb gradient(i * 1.0 / total) notitle, \
for [i=1:total] a=A[i] b=B[i] f(x) @plot_lines lc rgb gradient(i * 1.0 / total)

set output 'images/source.png'
plot [*:3.75][*:*] 'data/source.csv' using 1:2 with points pointtype 2 notitle, g(x) t sprintf("d_{corr} = %3.3f", as)


# Dimension plot.

set xlabel  'd'
set ylabel  'd_{corr}'

l(x) = as

set output 'images/dimension.png'
plot [*:*][0:14] sample [i=1:total] '+' using (dim[i]):(A[i]) with points pointtype 2 ps 2 t "d_{corr}", l(x) lw 2 t "Корреляционная размерность датасета"