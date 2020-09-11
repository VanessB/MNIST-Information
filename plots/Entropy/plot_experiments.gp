load 'common.gp'

set xtics 2

N = 2

do for [k=1:N] {
    data_path = 'data/experiment_' . k . '.csv'

    set output '/dev/null'
    plot data_path
    set xrange [0:GPVAL_DATA_X_MAX + 2.0]

    set output 'images/experiment_' . k . '.png'
    plot data_path using 1:5:6 with @errbars t 'Убрать один элемент', data_path using 1:3:4 with @errbars t 'Монте-Карло'

    set output 'images/experiment_' . k . '_LOO.png'
    plot data_path using 1:5:6 with @errbars t 'Убрать один элемент'
}