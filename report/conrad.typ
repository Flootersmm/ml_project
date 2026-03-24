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

= Related Work stuff
#text(fill: red)[TO MERGE TOGETHER LATER]

Previously, rule-based classifiers were used to detect DDoS attacks @dos_rulebased. This involves the categorisation data with a series of "if ... then ..." rules, generating descriptive models that are easy to interpret. This is an earlier machine learning method than the classifiers explored in this report, and therefore less expressive. Requiring distinct rules that must be carefully considered to provide good coverage and classification makes this kind of model perform poorly in exceptional scenarios. Real-world data is often fuzzy, and preventing DDoS attacks is an arms race - the complexity and upkeep of a rule-based classifier fighting new attacks with evolving signatuers makes them unwieldy. 

There are many ways to use kNN, and one notable study reduces the feature space drastically to only four features @dos_knn. In constrast, this report applies kNn to all numeric features available in the dataset, a total of 79, to evaluate whether broader feature coverage improves performance or not. 

Other papers have investigated the usage of a kNN model to tackle DDoS attacks in real-time. It's correctly pointed out in @dos_knn_realtime that machine learning is a rapidly developing field, and therefore repeated investigation into model performance is important and relevant to consider. The author expressed interest in investigating the computational resource requirements for this real-time protection; resource-constrained IoT environments were less performant than desired and required further optimisation to reach a high level of effectiveness.

= Dataset and Preprocessing <sec:dataset_preprocessing>

Three models were trained on a dataset consisting of network traffic, balanced between DDoS traffic and benign traffic. These models were kNN, logistic regression, and random forest. The data was extracted from public IDS datasets, produced in different years and with different techniques of generating traffic. There are $12 thin 794 thin 627$ datapoints and $84$ features. The models' inference abilities were then tested on an identically formed dataset that was unbalanced, with 20% DDoS traffic and 80% benign. Implementation of each model was provided by the `sklearn` library for Python. 

In order to manage resource and time constraints, training and inference were limited to $200 thin 000$ labels. This data was then put into a `pandas` dataframe for efficiency and ease of management. Particular features that were either irrelevant or non-numeric were also dropped - both kNN and logistic regression require numeric features. An alternative way of tackling non-numeric features is to one-hot encode them, where categoric features are given an integer identifier. This massively increases the memory requirements of the model and was therefore decided against, with the exception of encoding the `Protocol` feature which was the only relevant categorical feature present. This resulted in $79$ features.

The next step was cleaning; all features were represented with a 64-bit float and invalid numbers were cast to NaN for predictable management.

Next, the dataset was split into $60%$ training, $20%$ validation, and $20%$ test data. The training set was used for fit the model parameters, and was the largest to allow the models to effectively capture patterns in the data. The validation set was used for hyperparameter tuning; as the models haven't encountered the data before this is a suitable playground for adjustment. The final test set allows finalisation of ideal hyperparameters, and an additional verification that they are indeed ideal without any bias. 

Finally, features were then scaled with a mean of 0 and a standard deviation of 1, which is z-score normalisation. This is because logistic regression is sensitive to feature magnitude as it uses gradient descent which can struggle when, for example, one feature takes values $[0,1]$ and another takes $[2^32, 2^64]$. This prevents particular features completely dominating calculations and having inflated importance. It also allows faster convergence to the gradient's local minima. This scaler was applied to the training data, and then used to transform all data to make it homogeneous for the models. This is the last step to prepare the data. 

 Exact implementation details can be viewed at the codebase's git repository @github.

= Methodology <sec:methodology> 

#figure(
  placement: top,
  image("images/knn/hyperparameter_tuning.png"),
  caption: [Tuning hyperparameters for kNN for accuracy.],
) <fig:knn_hyperparameter>

== kNN

The first model evaluated was kNN. This works by finding the $k$-nearest points in the training dataset and uses their class to predict the class of nearby datapoints. For 79 features, the feature space has a dimensionality of $bb(R)^79$ which makes visualisation challenging, but the idea of 'nearby datapoints' generlises to high-dimension Euclidean spaces and therefore kNN is perfectly usable, though potentially slow #text(fill: red)[REPHRASE, CITE, OR REFERENCE HYPOTHESIS]. Varying hyperparameters $k$ were tested to maximise accuracy and minimise overfitting, see @fig:knn_hyperparameter. Larger $k$ can lead to overfitting and smaller $k$ can lead to underfitting, so finding the balance was important. 

After the optimal hyperparemter $k$ was chosen, 5-fold cross-validation was used, wherein the validation and training sets were combined and split into 5 sections. This allows for addressing the tradeoff between bias and variance, finding a model that maximises the benefit gained for the best inference results. Finally, the model was trained and then evaluated a single time on the test data. Using the test data a single time to evaluate final performance is extremely important to prevent provide an independent analysis of the model's performance - repeated use of the test data means this is no longer an evaluation on unseen data and therefore valueless.

== Logistic Regression 

== Random Forest

Once the models were  evaluated, we created confusion matrices, ROC curves, and computed AUC scores for each of our models. The models themselves were also saved to later be used for inference. This inference was performed with identical dataset preprocessing on the unbalanced dataset. Confusion matrices, ROC curves, and AUC scores were also computed for the inference run, and only one run was performed per model as the results are deterministic. 

Throughout both training and analysis, performance statistics were collected. These were RAM usage, CPU time, and wall clock time. Training was done on a desktop computer equipped with a 12th Gen Intel(R) Core(TM) i7-12700K and 32GiB of DDR5 4800MHz RAM, and inference was ran on both the same desktop computer and a Raspberry Pi 4 with a Quad core Cortex-A72 (ARM v8) 64-bit SoC \@ 1.8GHz and 4GiB of DDR4 3200MHz RAM. This was done to measure performance under limited hardware.



