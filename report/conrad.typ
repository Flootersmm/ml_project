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

Three models were trained on a dataset consisting of network traffic, balanced between DDoS traffic and benign traffic. These models were kNN, logistic regression, and random forest. The data was extracted from public IDS datasets, produced in different years and with different techniques of generating traffic. There are $12 thin 794 thin 627$ datapoints and $84$ features. The models' inference abilities were then tested on an identically formed dataset that was unbalanced, with 20% DDoS traffic and 80% benign. Implementation of each model was provided by the `sklearn` library for Python. 

In order to manage resource and time constraints, training and inference were limited to $200 thin 000$ labels. This data was then put into a `pandas` dataframe for efficiency and ease of management. Particular features that were either irrelevant or non-numeric were also dropped - both kNN and logistic regression require numeric features. An alternative way of tackling non-numeric features is to one-hot encode them, where categoric features are given an integer identifier. This massively increases the memory requirements of the model and was therefore decided against, with the exception of encoding the `Protocol` feature which was the only relevant categorical feature present. This resulted in $79$ features.

The next step was cleaning; all features were represented with a 64-bit float and invalid numbers were cast to NaN for predictable management.

Next, the dataset was split into $60%$ training, $20%$ validation, and $20%$ test data. The training set was used for fit the model parameters, and was the largest to allow the models to effectively capture patterns in the data. The validation set was used for hyperparameter tuning; as the models haven't encountered the data before this is a suitable playground for adjustment. The final test set allows finalisation of ideal hyperparameters, and an additional verification that they are indeed ideal without any bias. 

Finally, features were then scaled with a mean of 0 and a standard deviation of 1, which is z-score normalisation. This is because logistic regression is sensitive to feature magnitude as it uses gradient descent which can struggle when, for example, one feature takes values $[0,1]$ and another takes $[2^32, 2^64]$. This prevents particular features completely dominating calculations and having inflated importance. It also allows faster convergence to the gradient's local minima. This scaler was applied to the training data, and then used to transform all data to make it homogeneous for the models. This is the last step to prepare the data. 

Preprocessing steps can be viewed in detail at our codebase's git repository @github, as well as any exact implementation details mentioned hereafter.

= Methodolgy <sec:methodology> 

One model evaluated was kNN. This works by finding the $k$-nearest points in the training dataset and uses their class to predict the class of nearby datapoints. For 79 features, the feature space has a dimensionality of $bb(R)^79$ which makes visualisation challenging, but the idea of 'nearby datapoints' generlises to high-dimension Euclidean spaces and therefore kNN is perfectly usable, though potentially slow. #text(fill: red)[REPHRASE, CITE, OR REFERENCE HYPOTHESIS] 
