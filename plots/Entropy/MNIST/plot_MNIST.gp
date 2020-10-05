load 'common.gp'

set output 'images/MNIST.png'
plot [0:140] 'data/MNIST.csv' using 1:5:6 with @errbars t 'Убрать один элемент', 'data/MNIST.csv' using 1:3:4 with @errbars t 'Монте-Карло'
set output 'images/MNIST_LOO.png'
plot [0:140] 'data/MNIST.csv' using 1:5:6 with @errbars t 'Убрать один элемент'

set output 'images/MNIST_first.png'
plot [0:45] 'data/MNIST.csv' using 1:5:6 with @errbars t 'Убрать один элемент', 'data/MNIST.csv' using 1:3:4 with @errbars t 'Монте-Карло'
set output 'images/MNIST_first_LOO.png'
plot [0:45] 'data/MNIST.csv' using 1:5:6 with @errbars t 'Убрать один элемент'