#import "@preview/charged-ieee:0.1.4": ieee

knn does worse on imbalanced because the larger group sizes 'pull' knn into them

find a paper about this

discuss how you can change this, with k tuning or with weights on the classes that represent the imbalance

#figure(
  placement: top,
  table(
    columns: 4,
    align: (left, left, right, right, right),
    inset: 4pt,
    table.header([*Model*], [*RAM $Delta$ (MB)*], [*CPU Time (s)*], [*Wall Time (s)*]),
    [kNN], [2034.49], [10121.29], [1163.05],
    [RF], [2358.29], [1619.48], [116.39],
    [LR], [233.83], [69.41], [42.31],
  ),
  caption: [Resource usage for model training, with $200 thin 000$ samples.],
)<fig:resource_training>

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


= Results (kNN, to merge)

#text(fill: red)[Reference table 1]

Training costs are a one-time expense, but they're relevant when considering that models need to be occasionally retrained as attacks evolve and signatures change. #text(fill: red)[Briefly compare results, it's okay to essentially just rephrase what the table says]. A significant portion of the training time for kNN comes from the 5-fold cross-validation: having to compute the distances between $200 thin 000$ samples is incredibly slow. For larger datasets and more thorough validation, kNN may be completely unrealistic as an option.

#figure(
  placement: top,
  table(
    columns: 6,
    align: (left, left, right, right, right, right),
    inset: 4pt,
    table.header(
      [*Model*], [*Hardware*], [*RAM $Delta$ (MB)*], [*Wall Time (s)*], [*Throughput (flows/s)*], [*Latency (ms/flow)*]
    ),
    [kNN], [Desktop], [60.95], [141.90], [1409], [0.710],
    [kNN], [Raspberry Pi 4], [290.61], [1408.23], [142], [7.041],
    [RF], [Desktop], [6.48], [7.95], [25145], [0.040],
    [RF], [Raspberry Pi 4], [64.94], [65.15], [3070], [0.326],
    [LR], [Desktop], [36.73], [7.42], [26943], [0.037],
    [LR], [Raspberry Pi 4], [68.63], [30.79], [6497], [0.154],
  ),
  caption: [Resource usage for model inference across hardware, evaluated on $200 thin 000$ samples.],
)<fig:resource_inference>

To contextualise @fig:resource_inference: a 1 Gb/s network carrying TCP/UDP traffic generates $5 thin 000 "to" 50 thin 000$ NetFlow records per second. A lightly loaded home or small office router might produce $100 "to" 1 thin 000$ flows/s, while enterprise or data-centre networks can exceed $100 thin 000$ flows/s.

kNN is a clear bottleneck. On the desktop hardware it achieves only $1 thin 409$ flows/s which is equivalent to a home router under a medium load, and on the Raspberry Pi 4 it achieves $142$ flows/s which is catastrophically low and would result in essentially any networy traffic overwhelming the model, causing inference to fail - let alone a DDoS attack. This makes kNN the least efficient model of the 3. The low amount of traffic that it can handle disqualifies it from being useful in any realistic scenario, and its recall on kNN traffic being #text(fill: red)[amount, reference] makes it evident that it has extremely limited usefulness on what traffic it can make decisions on. Further work is needed to refine the kNN model, #text(fill: red)[refer to the 3 papers, proably the one using limited feature amounts], in order for it to become usable for DDoS traffic classification.

#text(
  fill: red,
)[LR and RF saturate 1 Gb/s network, but there's also 2.5, 5, and 10 Gb/s networks iirc. flow/s increases linearly so figure out what we can reach, where it's used, and how useful that is. Latency is no issue for any of our models, web requests are 100ms and games are like 10ms best case.]

Evaluated against the balanced dataset, the kNN model with a hyperparameter of $k = 1$ achievees near perfect recall. The training/validation confusion matrix (#text(fill: red)[figure]) shows #text(fill: red)[x correct classifications, y misclassifications, accuracy of z]. The corresponding ROC curve (#text(fill: red)[fig]) achieves an AUC of #text(fill: red)[amount], indicating that the model can almost perfectly classify DDoS and benign traffic when balanced.

To assess the viability of kNN in a real-world scenario, inference was performed on a dataset with 80% benign traffic and 20% DDoS, with $200 thin 000$ samples. This is a much more difficult scenario, as there is significantly less DDoS traffic to train on. The inference confusion matrix (#text(fill: red)[figure]) shows a degradation in DDoS recall with this unbalanced dataset. #text(fill: red)[numbers blah blah, roc curve, auc, "a decline from zxy on training set evaluation"]. This disparity comes from the distribution of data in our feature space - with a decision boundary created for balanced probability, a large amount of DDoS traffic samples are in regions dominated by benign traffic samples, creating many false negatives. The near-zero false positive rate (#text(fill: red)[number]) confirms that the model can identify DDoS traffic that's representative, but fails when it's more similar to benign traffic.

Prior to finalising the model training, hyperparameters were evaluated from 1 to 50. This hyperparameter $k$ represents the number of neighbours that kNN uses. As shown in #text(fill: red)[figure], both training and validation accuracy are the highest for $k = 1$ ($approx 99.7%$ for both), and decline as $k$ increases. This is a worrisome result that looks like extreme overfitting on the training set, however both LR and RF had similar results. Therefore, it's possible that the balanced dataset represents a genuinely simple problem to solve and that DDoS traffic is distinct enough from benign traffic for it to be trivial to tell them apart. Unfortunately, the collapse in kNN's recall for the unbalanced dataset (#text(fill: red)[recall amount]) signifies definitively that overfitting did occur, as it to perform on new data and has therefore cannot sufficiently classify realistic, unbalanced traffic. #text(fill: red)[future work to prevent this]




