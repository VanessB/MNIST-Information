load 'common.gp'

set style increment default

if (title == 1){
set title  "Корреляционная размерность"
}
set xlabel  'ln(r)'
set ylabel  'ln(2 · P / N^2)'
set yrange [*:2]

# Имена файлов.

set datafile separator ","

autoencoders_path = autoencoders_results_path . 'Autoencoders/'
no_model_path = dataset_results_path . 'No model/'

# Число исследованных размерностей.
total = 13

# Исследованные размерности кодов (перечислить все!).
array dim = [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14]

file(n) = sprintf(autoencoders_path . "%d_1000/log_pairs.csv", dim[n])

# Функции.

#a = 5.0
#b = -1.0
f(x) = a*x + b

approx_y_min = -3.0
approx_y_max = -1.5

array A[total]
array B[total]
do for [i=1:total] {
    print file(i)
    fit[*:*][approx_y_min : approx_y_max] f(x) file(i) using 1:2 via a, b
    A[i] = a
    B[i] = b
}

as = 10.0
ab = -1.0
g(x) = as * x + bs

fit [*:*][-4:-2] g(x) no_model_path . 'log_pairs.csv' using 1:2 via as, bs

# Палитра.

h1 = 210.0/360.0
h2 = 400.0/360.0
s = 1.0
v = 1.0
gradient(x) = hsv2rgb( ( (h2 - h1)*x + h1 <= 1.0 )?( (h2 - h1)*x + h1 ):( (h2 - h1)*x + h1 - 1.0), s, v)
dimg(start, end, i) = gradient((dim[i] - dim[start]) * 1.0 / (dim[end] - dim[start]))

# Построение графиков.

set macro
lines_titles = "t sprintf(\"d = %d, d_{corr} = %3.3f\", dim[i], a)"

if (title == 1){
set title "Корреляционная размерность кодов"
}

# Оригинальные данные.
set output '/dev/null'
plot [*:*][*:*] for [i=1:total] file(i) using 1:2
data_x_min = GPVAL_DATA_X_MIN
data_x_max = GPVAL_DATA_X_MAX
data_y_min = GPVAL_DATA_Y_MIN
data_y_max = 0.0 #GP_VAL_DATA_Y_MAX

set output 'images/fractal_dimension/all' . extension
plot [data_x_min - 1.0 : data_x_max + 1.0][data_y_min - 1.0 : data_y_max + 1.0] for [i=1:total] file(i) using 1:2 with @plot_small_points lc rgb gradient(i * 1.0 / total) notitle

# Обрезанные данные.
crop_y_min = data_y_min + 3.0
crop_y_max = data_y_max + 1.0
filter(x, min, max)=(( (x <= max)?(x):(1/0) ) >= min)?(x):(1/0)
filter_xy(x, y, min, max)=(( (y <= max)?(y):(1/0) ) >= min)?(x):(1/0)

set output '/dev/null'
plot [*:*][*:*] for [i=1:total] file(i) using (filter_xy($1, $2, crop_y_min, crop_y_max)):(filter($2, crop_y_min, crop_y_max))
cropped_data_x_min = GPVAL_DATA_X_MIN
cropped_data_x_max = GPVAL_DATA_X_MAX
cropped_data_y_min = GPVAL_DATA_Y_MIN
cropped_data_y_max = 0.0 #GP_VAL_DATA_Y_MAX

set output 'images/fractal_dimension/cropped' . extension
plot [cropped_data_x_min - 1.0 : cropped_data_x_max + 1.0][crop_y_min - 1.0 : crop_y_max] for [i=1:total] file(i) using 1:(filter($2, crop_y_min, crop_y_max)) with @plot_small_points lc rgb gradient(i * 1.0 / total) notitle

# Аппроксимация.
set output '/dev/null'
plot [*:*][*:*] for [i=1:total] file(i) using (filter_xy($1, $2, approx_y_min - 3.0, data_y_max + 1.0)):(filter($2, approx_y_min - 3.0, data_y_max + 1.0))
approx_x_min = GPVAL_DATA_X_MIN
approx_x_max = GPVAL_DATA_X_MAX

#approx_x_min = -4.0
#approx_x_max = data_x_max

set output 'images/fractal_dimension/fitted' . extension
plot [approx_x_min - 1.0 : approx_x_max + 1.0][approx_y_min - 3.0 : data_y_max + 1.0] \
for [i=1:total] file(i) using 1:2 with @plot_small_points lc rgb gradient(i * 1.0 / total) notitle, \
for [i=1:total] a=A[i] b=B[i] f(x) @lines_titles lc rgb gradient(i * 1.0 / total)

# Исследуемый набор данных.
if (title == 1){
set title  "Корреляционная размерность набора данных"
}

set output 'images/fractal_dimension/dataset' . extension
plot [*:*][*:*] no_model_path . 'log_pairs.csv' using 1:2 with @plot_small_points notitle, g(x) t sprintf("d_{corr} = %3.3f", as)


# Сводный график размерностей.

if (title == 1){
set title  "Сводный график корреляционных размерностей"
}

set mxtics 5
set mytics 5

set xlabel  'Размерность внутреннего представления'
set ylabel  'd^*_{corr}'

l(x) = as

set output 'images/fractal_dimension/dimension' . extension
plot [0 : dim[total] + 1.0][0 : as + 1.0] sample [i=1:total] '+' using (dim[i]):(A[i]) with @plot_points t "Внутреннее представление", l(x) lw 4 t sprintf("Исходный набор данных (d_{corr} = %.2f)", as)
