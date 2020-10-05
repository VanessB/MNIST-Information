load 'common.gp'

set style increment default
set title  "Корреляционная размерность"
set xlabel  'ln(r)'
set ylabel  'ln(2 · P / N^2)'
set yrange [*:2]

# Filenames

set datafile separator ","

autoencoders_path = directory_path . 'Autoencoders/'
no_model_path = directory_path . 'No model/'

total = 9#13
array dim = [2, 3, 4, 5, 6, 7, 8, 9, 10]#, 11, 12, 13, 14]
file(n) = sprintf(autoencoders_path . "%d_1000/log_pairs.csv", dim[n])

# Functions

#a = 5.0
#b = -1.0
f(x) = a*x + b

array A[total]
array B[total]
do for [i=1:total] {
    print file(i)
    # [-16:-10]
    fit[*:*][-4:-1] f(x) file(i) using 1:2 via a, b
    A[i] = a
    B[i] = b
}

as = 10.0
ab = -1.0
g(x) = as * x + bs

#[-7:-2]
fit [*:*][-4:-2] g(x) no_model_path . 'log_pairs.csv' using 1:2 via as, bs

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

set output 'images/fractal_dimension/all.png'
plot [*:*] for [i=1:total] file(i) using 1:2 @plot_points lc rgb gradient(i * 1.0 / total) notitle

set output 'images/fractal_dimension/cropped.png'
min = -18
max = 1
filter(x)=(( (x <= max)?(x):(1/0) ) >= min)?(x):(1/0)
plot [-10:*][-20:2] for [i=1:total] file(i) using 1:(filter($2)) @plot_points lc rgb gradient(i * 1.0 / total) notitle

set output 'images/fractal_dimension/fitted.png'
plot [-4:4][-7: 2] \
for [i=1:total] file(i) using 1:2 @plot_points lc rgb gradient(i * 1.0 / total) notitle, \
for [i=1:total] a=A[i] b=B[i] f(x) @plot_lines lc rgb gradient(i * 1.0 / total)

set output 'images/fractal_dimension/dataset.png'
plot [-3:3.5][*:*] no_model_path . 'log_pairs.csv' using 1:2 with points pointtype 2 notitle, g(x) t sprintf("d_{corr} = %3.3f", as)


# Dimension plot.

set xlabel  'd'
set ylabel  'd_{corr}'

l(x) = as

set output 'images/fractal_dimension/dimension.png'
plot [*:*][0:14] sample [i=1:total] '+' using (dim[i]):(A[i]) with points pointtype 2 ps 2 t "d_{corr}", l(x) lw 2 t "Корреляционная размерность датасета"