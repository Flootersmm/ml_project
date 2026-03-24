#import "@preview/charged-ieee:0.1.4": ieee

knn does worse on imbalanced because the larger group sizes 'pull' knn into them

find a paper about this

discuss how you can change this, with k tuning or with weights on the classes that represent the imbalance

#figure(
  placement: top,
  table(
    columns: 4,
    align: (left, right, right, right),
    inset: 4pt,
    table.header([*Model*], [*RAM $Delta$ (MB)*], [*CPU Time (s)*], [*Wall Time (s)*]),
    [kNN (training)], [2034.49], [10121.29], [1163.05],
    [kNN (inference)], [60.95], [1402.22], [141.90],
    [kNN (inference, Raspberry Pi)], [290.60], [5344.74], [1408.22],
    [Random Forest (training)], [2358.29], [1619.48], [116.39],
    [Random Forest (inference)], [6.48], [17.46], [7.95],
    [Random Forest (inference, Raspberry Pi)], [1464.93], [51.85], [65.14],
    [Logistic Regression (training)], [233.83], [69.41], [42.31],
    [Logistic Regression (inference)], [36.73], [9.42], [7.42],
    [Logistic Regression (inference, Raspberry Pi)], [1632.62], [27.53], [30.78],
  ),
  caption: [Resource usage for model training and inference],
)<fig:resource_usage>

reference here asdasd @dos_rulebased
@dos_knn 
@dos_knn_realtime
