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

= Dataset and Preprocessing <sec:dataset_preprocessing>

Our models were trained on a dataset consisting of network traffic, balanced between DDoS traffic and benign traffic. The data was extracted from public IDS datasets, produced in different years and with different techniques of generating traffic. There are $12 thin 794 thin 627$ datapoints and $84$ features. We then tested our models' inference abilities on an identically formed dataset that was unbalanced, with 20% DDoS traffic and 80% benign. 

In order to manage resource and time constraints, we limited our training and inference to $200 thin 000$ labels. This data was then put into a `pandas` dataframe for efficiency and ease of management. We then dropped particular features that were either irrelevant or non-numeric - both kNN and logistic regression require numeric features. An alternative way of tackling our non-numeric features 

Preprocessing can be viewed in detail at @github.
