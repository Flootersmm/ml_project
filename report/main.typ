#import "@preview/charged-ieee:0.1.4": ieee
#import "@preview/slashion:0.1.1": slash-frac as sfrac

#set document(title: "MLVU information sheet")
#set page(margin: 2.5cm)

#align(center)[
  #text(size: 1.8em, weight: "bold")[MLVU information sheet]
]

_Please include this page in your report either at the start or at the end, before the appendix. Do not change the formatting._

*Group number*

156

*Authors*

#table(
  columns: (auto, auto),
  align: right,
  stroke: none,
  [name], [student number],
  table.hline(),
  [Conrad Clough], [2699315],
  [Samuel Power], [2800107],
  [Andreas Stolle], [2808634],
)

*Software used* _Describe briefly which software and libraries you relied on. If you built a particular algorithm from scratch, make sure to state it explicitly here._

We used Jupyter, numpy, pandas, matplotlib, and sklearn. Jupyter was used for ease of modifying our program without needing to redo data processing; numpy, pandas, and matplotlib were used for interacting with data and displaying results; sklearn was used for their model implementations.

*Use of AI tools* _If you used tools like ChatGPT or Github Copilot in any phase of the report, please detail here which tools you used, what parts of the work you used them for and how. Note that if you use an AI tool and don't report it, it's considered fraud, so be detailed. Note also that having an AI tool write for you is not allowed. If no AI tools were used, please state that explicitly._

- Conrad: ChatGPT was used to generate the code that created our graphs, specifically the styling.

*Link to code (optional)* https://github.com/Flootersmm/ml_project

*Group disagreements (optional)* _If there are any disagreements in the group, you may *not* remove a student from the author list without their consent. You should bring disagreements to our attention early. As a last resort, you can describe any grievances here._

#pagebreak()

#set table(
  columns: (6em, auto),
  inset: (x: 8pt, y: 4pt),
  stroke: (x, y) => if y <= 1 { (top: 0.5pt) },
  fill: (x, y) => if y > 0 and calc.rem(y, 2) == 0 { rgb("#efefef") },
)

#show: ieee.with(
  title: [How can machine learning-based DDoS detection models be designed to minimise false positive rates while maintaining high detection accuracy on both low- and high-powered hardware?],
  authors: (
    (
      name: "Conrad Clough",
      department: [VUNetId: cch250],
      organization: [Student Nr: 2699315],
      email: "c.j.clough@student.vu.nl",
    ),
    (
      name: "Samuel Power",
      department: [VUNetId: spo237],
      organization: [Student Nr: 2800107],
      email: "s.j.power@student.vu.nl",
    ),
    (
      name: "Andreas Stolle",
      department: [VUNetId: ast451],
      organization: [Student Nr: 2808634],
      email: "a.stolle@student.vu.nl",
    ),
  ),
  index-terms: (
    "DDoS detection",
    "machine learning",
    "false positive rate",
    "k-Nearest Neighbors",
    "Random Forest",
    "Logistic Regression",
    "computational efficiency",
  ),
  bibliography: bibliography("refs.bib"),
  figure-supplement: [Fig.],
)

#set page(numbering: "1")

= Abstract <sec:abstract>
// #text(fill: blue)[
//   #link("https://users.ece.cmu.edu/~koopman/essays/abstract.html")
//
//   Checklist: Parts of an Abstract
//
//   Despite the fact that an abstract is quite brief, it must do almost as much work as the multi-page paper that follows it. In a computer architecture paper, this means that it should in most cases include the following sections. Each section is typically a single sentence, although there is room for creativity. In particular, the parts may be merged or spread among a set of sentences. Use the following as a checklist for your next abstract:
//
//   Motivation:
//   Why do we care about the problem and the results? If the problem isn't obviously "interesting" it might be better to put motivation first; but if your work is incremental progress on a problem that is widely recognized as important, then it is probably better to put the problem statement first to indicate which piece of the larger problem you are breaking off to work on. This section should include the importance of your work, the difficulty of the area, and the impact it might have if successful.
//   Problem statement:
//   What problem are you trying to solve? What is the scope of your work (a generalized approach, or for a specific situation)? Be careful not to use too much jargon. In some cases it is appropriate to put the problem statement before the motivation, but usually this only works if most readers already understand why the problem is important.
//   Approach:
//   How did you go about solving or making progress on the problem? Did you use simulation, analytic models, prototype construction, or analysis of field data for an actual product? What was the extent of your work (did you look at one application program or a hundred programs in twenty different programming languages?) What important variables did you control, ignore, or measure?
//   Results:
//   What's the answer? Specifically, most good computer architecture papers conclude that something is so many percent faster, cheaper, smaller, or otherwise better than something else. Put the result there, in numbers. Avoid vague, hand-waving results such as "very", "small", or "significant." If you must be vague, you are only given license to do so when you can talk about orders-of-magnitude improvement. There is a tension here in that you should not provide numbers that can be easily misinterpreted, but on the other hand you don't have room for all the caveats.
//   Conclusions:
//   What are the implications of your answer? Is it going to change the world (unlikely), be a significant "win", be a nice hack, or simply serve as a road sign indicating that this path is a waste of time (all of the previous results are useful). Are your results general, potentially generalizable, or specific to a particular case?
//
//   Other Considerations
//
//   An abstract must be a fully self-contained, capsule description of the paper. It can't assume (or attempt to provoke) the reader into flipping through looking for an explanation of what is meant by some vague statement. It must make sense all by itself. Some points to consider include:
//
//   Meet the word count limitation. If your abstract runs too long, either it will be rejected or someone will take a chainsaw to it to get it down to size. Your purposes will be better served by doing the difficult task of cutting yourself, rather than leaving it to someone else who might be more interested in meeting size restrictions than in representing your efforts in the best possible manner. An abstract word limit of 150 to 200 words is common.
//   Any major restrictions or limitations on the results should be stated, if only by using "weasel-words" such as "might", "could", "may", and "seem".
//   Think of a half-dozen search phrases and keywords that people looking for your work might use. Be sure that those exact phrases appear in your abstract, so that they will turn up at the top of a search result listing.
//   Usually the context of a paper is set by the publication it appears in (for example, IEEE Computer magazine's articles are generally about computer technology). But, if your paper appears in a somewhat un-traditional venue, be sure to include in the problem statement the domain or topic area that it is really applicable to.
//   Some publications request "keywords". These have two purposes. They are used to facilitate keyword index searches, which are greatly reduced in importance now that on-line abstract text searching is commonly used. However, they are also used to assign papers to review committees or editors, which can be extremely important to your fate. So make sure that the keywords you pick make assigning your paper to a review category obvious (for example, if there is a list of conference topics, use your chosen topic area as one of the keyword tuples).]
//

Distributed Denial of Service (DDoS) attacks continue to disrupt network services, causing downtime and economic damage. Existing techniques for mitigating this often struggle to deal with evolving attack signatures @dos_rulebased. This paper investigates the design of DDoS detection models using machine learning. We evaluate three classifiers, k-Nearest Neighbours (kNN), Logistic Regression (LR), and Random Forests, by analysing their accuracy, false positive rates, and resource usage under controlled conditions. Our results indicate that kNN is too simple of a model to efficiently classify attacks, RF is significantly faster and very usable in all levels of hardware but slow to train, and LR beats the previous two models in every meaningful way. These findings suggest that model selection is dependent on hardware specifications and the relative importance of minimising false positives,  providing a practical guide for using machine learning-based DDoS detection in diverse contexts, but future work should be done to identify areas where LR may perform suboptimally.

*Keywords*: DDoS detection, machine learning, false positive rate, k-Nearest Neighbours, Random Forest, Logistic Regression, computational efficiency

= Introduction <sec:intro>
The proliferation of online services has made networks increasingly vulnerable to Distributed Denial of Service (DDoS) attacks, which can overwhelm servers and disrupt them, causing significant operational downtime and economic damage. Detecting these attacks efficiently is challenging because high accuracy must be balanced with low false positive rates; denying service to legitimate users is highly undesirable, as is allowing too much malicious traffic through. Machine learning offers a promising alternative to traditional, rule-based approaches; patterns in network traffic can be used to identify evolving malicious activity in real time. This document investigates the design of machine learning-based DDoS detection models with an emphasis on maintaining high detection accuracy while reducing false positives, and evaluates their resource usage across a range of hardware to ensure usability for a variety of situations. Specifically, k-Nearest Neighbours (kNN), Logistic Regression (LR), and Random Forest classifiers are compared in terms of both accuracy, false positive rate, and performance.

The report is structured as follows:
- In @sec:related_work we consider existing methods of DDoS detection.
- In @sec:dataset_preprocessing we discuss the dataset we used and how it was prepared for use in training.
- In @sec:methodology we explain our classifiers and how we ran our experiments.
- In @sec:results we show and discuss our results.
- In @sec:conclusion we summarise our findings.

= Related Work <sec:related_work>

Previously, rule-based classifiers were used to detect DDoS attacks @dos_rulebased. This involves the categorisation data with a series of "if ... then ..." rules, generating descriptive models that are easy to interpret. This is an earlier machine learning method than the classifiers explored in this report, and therefore less expressive. Requiring distinct rules that must be carefully considered to provide good coverage and classification makes this kind of model perform poorly in exceptional scenarios. Real-world data is often fuzzy, and preventing DDoS attacks is an arms race - the complexity and upkeep of a rule-based classifier fighting new attacks with evolving signatures makes them unwieldy.

There are many ways to use kNN, and one notable study reduces the feature space drastically to only four features @dos_knn. In constrast, this report applies kNn to all numeric features available in the dataset, a total of 79, to evaluate whether broader feature coverage improves performance or not.

Other papers have investigated the usage of a kNN model to tackle DDoS attacks in real-time. It's correctly pointed out in @dos_knn_realtime that machine learning is a rapidly developing field, and therefore repeated investigation into model performance is important and relevant to consider. The author expressed interest in investigating the computational resource requirements for this real-time protection; resource-constrained IoT environments were less performant than desired and required further optimisation to reach a high level of effectiveness.

While kNN does work well in many cases, it's downside is that it relies on heavy distance computations, which can slow it down for devices with limited resources. Therefore, we want to see if a simpler model could still get similar results. A natural choice for this is Logistic Regression, as it is often used as lightweight baseline model for network intrusion detection and it doesn't consume much resources. In his analysis of classic machine learning classifiers, Boadi shows that LR does score fairly high in accuracy AUC, but is outperformed by more complex models like Random Forest @boadi2025nslkdd.

Even if we are aware that LR might not deliver the best results out of all the models, it is still worth including, as its trade-off between performance and resource consumption is attractive and there are ways to maximise results. Research shows that LR can be improved significantly with careful preprocessing, such as feature selection and balanced data @chalichalamala2023lrec. This means that LR's effectiveness depends on how the data is set up just as much as it does on how complex the model itself is. One study that focuses on using LR in deployment emphasises that can be scaled further through techniques like parallelised training and automated hyperparameter tuning, allowing for competitive performance while keeping computational overead low @kolukisa2024efficient.

This means that LR is not just a popular baseline, but is especially a lightweight and effective model that using the right approach can be tuned to successfully handle the trade-offs between accuracy, false positive rate and computational efficiency.

While many studies report high accuracy for machine learning-based intrusion detection, this does not automatically translate to practical deployment. Sommer and Paxson highlight that such systems often struggle in real-world environments due to high false positive rates and poor generalisation, despite strong performance on benchmark datasets. This reinforces the need to evaluate models not only on accuracy, but also on their ability to minimise false positives under realistic conditions @sommer2010outside.

Given these challenges, with changing attack patterns and a variety of new and innovative attacks compounding upon IoT devices, it makes sense to also investigate the random forests model use in computation. Due it being lightweight and robust with ensembling methods @xie2023ddos it is quite suitable for use in classifying IoT traffic. Additionally, with the importance of classifcation reliability as well as real-time clasification, the random forest model has outperformed other models while simultaneously avoiding overfitting @prashanthi2023machine. Additionally, research shows that the forest model can reach very high scores as high as 99.88% accuracy, 99.93% precision and 99.81% recall @nawaz2025lightweight while still maintaining low computational overhead and remaining suitable for the resource-constrained IoT deployments that will be outlined further in this paper. This suggests that it could handle the tradeoffs better than other models as it is able to provide a more comprehensive classification while simultaneously staying far below the computational overheads of other equally accurate models.

= Hypothesis <sec:hypothesis>
The research question focuses on designing a DDoS detecion model to minimise false positive rates while maintaining high detection accuracy on both low and high powered hardware. With respect to this, our first hypothesis is that the random forest model and the kNN model will outperform linear regression in the minimisation of false-positive rates (FPR). This stems form the fact that network traffic paterns are inherently non-linear given occurences such as burst behaviours, temporal correlations and other protoco-specific signatures that don't subscribe to a linear formatting. Additionally, the interaction of different features is extremely impotant. This encompasses combinations such as packet rates and payload sizes or duration of and number of failed handshakes. We expect linear regression will struggle to capture precise decision boundaries due to the multi-faceted aspect of the data, thereby yielding a higher FPR than RF and kNN.
We expect that kNN will perform well because benign data clusters naturally, i.e. normal user behaviour is repetitive. However, the extent of the diversity of the attack variants may complicate the clustering. We do not expect kNN to perform best, as we expect a variety of different attack formats given the dataset samples a multitude of other dates Therefore, we hypothesise that the random forest model will outperform kNN (and LR) in terms of accuracy. Aditionally, we also expect the kNN model to underperform RF and LR in terms of computational speed. kNN is a lazy algorithm and therefore the training dataset will take up a very significant portion of the embedded devices limited memory, as well as needing to recan the entire dataset anew when new data arrives. We hypothesise that linear regression will run fastest given that it is a very simple model. We expect the order to be 
1. LR
2. RF
3. kNN
Over all, we expect the random forest model to outperform the other two when accounting for speed and accuracy.

= Dataset and Preprocessing <sec:dataset_preprocessing>

Three models were trained on a dataset consisting of network traffic, balanced between DDoS traffic and benign traffic. These models were kNN, logistic regression, and random forest. The data was extracted from public IDS datasets, produced in different years and with different techniques of generating traffic. There are $12 thin 794 thin 627$ datapoints and $84$ features. The models' inference abilities were then tested on an identically formed dataset that was unbalanced, with 20% DDoS traffic and 80% benign. Implementation of each model was provided by the `sklearn` library for Python.

In order to manage resource and time constraints, training and inference were limited to $200 thin 000$ labels. This data was then put into a `pandas` dataframe for efficiency and ease of management. Particular features that were either irrelevant or non-numeric were also dropped - both kNN and logistic regression require numeric features. An alternative way of tackling non-numeric features is to one-hot encode them, where categoric features are given an integer identifier. This massively increases the memory requirements of the model and was therefore decided against, with the exception of encoding the `Protocol` feature which was the only relevant categorical feature present. This resulted in $79$ features.

The next step was cleaning; all features were represented with a 64-bit float, invalid numbers were cast to NaN for predictable management, and missing values were imputed using the median.

Next, the dataset was split into $60%$ training, $20%$ validation, and $20%$ test data. The training set was used for fit the model parameters, and was the largest to allow the models to effectively capture patterns in the data. The validation set was used for hyperparameter tuning; as the models haven't encountered the data before this is a suitable playground for adjustment. The final test set allows finalisation of ideal hyperparameters, and an additional verification that they are indeed ideal without any bias. Notable, this is not training on the test set. It's a sanity check, and if unexpected results

Finally, features were then scaled with a mean of 0 and a standard deviation of 1, which is z-score normalisation. This is because logistic regression is sensitive to feature magnitude as it uses gradient descent which can struggle when, for example, one feature takes values $[0,1]$ and another takes $[2^32, 2^64]$. This prevents particular features completely dominating calculations and having inflated importance. It also allows faster convergence to the gradient's local minima. An alternative, explored in @dos_knn, is to hugely reduce the feature space - this was opted against this as makes a comparison between kNN and other models less direct. This scaler was applied to the training data, and then used to transform all data to make it homogeneous for the models. This is the last step to prepare the data.

Exact implementation details can be viewed at the codebase's git repository @github.

= Methodology <sec:methodology>

#figure(
  placement: top,
  image("images/knn/hyperparameter_tuning.png"),
  caption: [Tuning hyperparameters for kNN for accuracy. $k = 1$ provides the best balance between accuracy and overfitting.],
) <fig:knn_hyperparameter>

== kNN

The first model evaluated was kNN. This works by finding the $k$-nearest points in the training dataset and uses their class to predict the class of nearby datapoints. For 79 features, the feature space has a dimensionality of $bb(R)^79$ which makes visualisation challenging, but the idea of 'nearby datapoints' generalises to high-dimension Euclidean spaces and therefore kNN is perfectly usable, though slow (@fig:resource_training). Varying hyperparameters $k$ were tested to maximise accuracy and minimise overfitting, see @fig:knn_hyperparameter. Larger $k$ can lead to overfitting and smaller $k$ can lead to underfitting, so finding the balance was important.

After the optimal hyperparameter $k$ was chosen, 5-fold cross-validation was used, wherein the validation and training sets were combined and split into 5 sections. This allows for addressing the tradeoff between bias and variance, finding a model that maximises the benefit gained for the best inference results. Finally, the model was trained and then evaluated a single time on the test data. Using the test data a single time to evaluate final performance is extremely important to prevent provide an independent analysis of the model's performance - repeated use of the test data means this is no longer an evaluation on unseen data and therefore valueless.

== Logistic Regression

For the logistic regression model, with an input feature vector $x$, it estimates the probability of the DDoS class as

$
  P(y = 1 | x) = sigma(w^T x + b),
$

where $w$ is the coefficient vector, $b$ is the bias term, and $sigma(.)$ is the sigmoid function. Classification is obtained by thresholding this probability.

To study the sensitivity of logistic regression to L2 regularisation and to reduce overfitting, we evaluate $C$ over a logarithmic range from $10^(-4)$ to $10^4$. For each value of $C$, we measure training accuracy, validation accuracy, and the overfitting gap.


#figure(
  image("images/lr/lr_hyperparameter_tuning_overfitting.png"),
  caption: [Effect of the inverse regularisation parameter $C$ on performance. Accuracy improves sharply at low $C$ and quickly plateaus, while the overfitting gap remains negligible.],
)

The best validation performance is achieved at $C ≈ 0.046$, with validation accuracy of approximately 0.9855.

== Random Forest
The random forest model was implemented with the sklearn randomforestclassifier, and was implemented as an ensemble of decision trees that were trained upon bootstrap samples. The RF prediction is computed by averaging tree class proabailities and thresholding at 0.5 (argmax for class label). Here, each split considered a random subset of features. The random forest made use of hyperparameter tuning via a number of estimators 
n_estimators_values = [10, 25, 50, 75, 100, 150, 200]. For each estimator, the validation accuracy and overfitting gap were computed and the estimator with the highest validation accuracy was selected for the final model. This final model was then used on the test set. 
 
 \

Once the models were evaluated, confusion matrices, ROC curves, and AUC scores were computed for each of them. The models themselves were also saved to later be used for inference. This inference was performed with identical dataset preprocessing on the unbalanced dataset. Confusion matrices, ROC curves, and AUC scores were also computed for the inference run, and only one run was performed per model as the results are deterministic.

Throughout both training and analysis, performance statistics were collected. These were RAM usage, CPU time, and wall clock time. Training was done on a desktop computer equipped with a 12th Gen Intel(R) Core(TM) i7-12700K and 32GiB of DDR5 4800MHz RAM, and inference was ran on both the same desktop computer and a Raspberry Pi 4 with a Quad core Cortex-A72 (ARM v8) 64-bit SoC \@ 1.8GHz and 4GiB of DDR4 3200MHz RAM. This was done to measure performance under limited hardware.

= Results <sec:results>

== kNN

#figure(
  placement: top,
  table(
    columns: 4,
    align: (left, left, right, right),
    inset: 4pt,
    table.header([*Model*], [*RAM $Delta$ (MB)*], [*CPU Time (s)*], [*Wall Time (s)*]),
    [kNN], [2034.49], [10121.29], [1163.05],
    [RF], [2358.29], [1619.48], [116.39],
    [LR], [233.83], [69.41], [42.31],
  ),
  caption: [Resource usage for model training, with $200 thin 000$ samples.],
)<fig:resource_training>

Training costs are a one-time expense, but they're relevant when considering that models need to be occasionally retrained as attacks evolve and signatures change. As shown in @fig:resource_training, LR is by far the cheapest to train, using only $233.83$ MB of RAM and completing in 42 seconds of wall time. RF is significantly more expensive but still tractable at 116 seconds. kNN is the most costly by a wide margin, consuming over 2 GB of RAM and taking nearly 20 minutes of wall time. A significant portion of the training time for kNN comes from the 5-fold cross-validation: having to compute the distances between $200 thin 000$ samples is incredibly slow. For larger datasets and more thorough validation, kNN may be completely unrealistic as an option.

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

#figure(
  placement: top,
  image("images/knn/confusion_matrix.png"),
  caption: [Confusion matrix for kNN during training, seeing very high recall.],
) <fig:knn_confusion>

To contextualise @fig:resource_inference: a 1 Gb/s network carrying TCP/UDP traffic generates $5 thin 000 "to" 50 thin 000$ NetFlow records per second. A lightly loaded home or small office router might produce $100 "to" 1 thin 000$ flows/s, while enterprise or data-centre networks can exceed $100 thin 000$ flows/s.

kNN is a clear bottleneck. On the desktop hardware it achieves only $1 thin 409$ flows/s which is equivalent to a home router under a medium load, and on the Raspberry Pi 4 it achieves $142$ flows/s which is catastrophically low and would result in essentially any network traffic overwhelming the model, causing inference to fail - let alone a DDoS attack. This makes kNN the least efficient model of the three. The low amount of traffic that it can handle disqualifies it from being useful in any realistic scenario, and its low recall on DDoS traffic makes it evident that it has extremely limited usefulness on what traffic it can make decisions on. Further work is needed to refine the kNN model: reducing the feature space, as explored in @dos_knn, is a promising direction to take as their approach achieved competitive performance with only four features which would substantially reduce runtime. This is very relevant for IoT deployment, where resource constraints can be even more severe than on the Raspberry Pi 4; @dos_knn_realtime highlight that this kind of environment would require that further optimisation is needed.


Prior to finalising the model training, hyperparameters were evaluated from 1 to 50. This hyperparameter $k$ represents the number of neighbours that kNN uses. As shown in @fig:knn_hyperparameter, both training and validation accuracy are the highest for $k = 1$ ($approx 99.7%$ for both), and decline as $k$ increases. This is a worrisome result that looks like extreme overfitting on the training set, however both LR and RF had similar results. Therefore, it's possible that the balanced dataset represents a genuinely simple problem to solve and that DDoS traffic is distinct enough from benign traffic for it to be trivial to tell them apart. Unfortunately, the collapse in kNN's recall for the unbalanced dataset signifies definitively that overfitting did occur, as it to perform on new data and has therefore cannot sufficiently classify realistic, unbalanced traffic.

#figure(
  placement: top,
  image("images/knn/inference_confusion_matrix.png"),
  caption: [Confusion matrix for kNN during inference, seeing a high false negative rate.],
) <fig:knn_confusion_infer>

#figure(
  placement: top,
  image("images/knn/roc_curve.png"),
  caption: [ROC curve for kNN on the balanced test set, with a AUC of $0.9970$.],
) <fig:knn_roc>

Evaluated against the balanced dataset, the kNN model with a hyperparameter of $k = 1$ achieves near perfect recall. The training/validation confusion matrix (@fig:knn_confusion) shows shows $3 thin 988$ correct classifications and just 12 misclassifications, yielding an accuracy of $99.7%$ and equal recall of $99.7%$ for both classes. The corresponding ROC curve (@fig:knn_roc) achieves an AUC of $0.9970$, confirming that the model can almost perfectly separate DDoS and benign traffic when class distribution is balanced.

To assess the viability of kNN in a real-world scenario, inference was performed on a dataset with 80% benign traffic and 20% DDoS, with $200 thin 000$ samples. This is a much more difficult scenario, as there is significantly less DDoS traffic to train on. The inference confusion matrix (@fig:knn_confusion_infer) shows a degradation in DDoS recall with this unbalanced dataset. Of $200 thin 000$ samples, only $63 thin 993$ were correctly identified, yielding a DDoS recall of $32.0%$, a huge collapse when compared to the balanced dataset. This disparity comes from the distribution of data in our feature space - with a decision boundary created for balanced probability, a large amount of DDoS traffic samples are in regions dominated by benign traffic samples, creating many false negatives. The near-zero false positive rate confirms that the model can identify DDoS traffic that's representative, but fails when it's more similar to benign traffic.

== Logistic Regression

The results show when $C$ is too small it leads to underfitting, reducing both training and validation accuracy. When increasing $C$, the performance improves until it reaches $C approx 0.046$. From then on, increasing $C$ any further has practically no effect to the performance. The overfitting gap remains almost zero across all values, indicating that the model generalises well and does not overfit.

This suggests that the data might be close to linearly separable under our current feature representation. At this point the model is also flexible enough to capture the structure in the data, which is why even more additional capacity does not improve its performance. Once As soon as a certain level of flexibility is reached, adding more capacity does not improve the performance. Thus we can categorize it in a low-bias, low-variance regime, where both underfitting and overfitting effects are minimal.

While regularisation has little influence, the classification does have a strong impact on how the model behaves. Using the best validation model, we evaluate thresholds between $0.1$ and $0.9$.

Increasing the threshold makes the classifier more conservative. This means that fewer flows are classified as DDoS, which reduces the FPR and increases precision, but lowers recall. In reverse, the advantage lowering the threshold is that it maximizes the number of detections, but the trade-off is that it also increases false positives.

For example, at threshold $0.5$, the model achieves FPR $approx 0.028$ and recall $approx 0.9995$. If the threshold is increased to $0.9$, it reduces the FPR to approximately $0.015$, however the recall drops to around $0.9588$. This clearly shows the trade-off between how sensitive the detection is and the false alarm rate.

#figure(
  image("images/lr/lr_threshold_sweep.png"),
  caption: [Threshold sweep for logistic regression. Increasing the decision threshold reduces false positives and increases precision, but lowers recall.],
)

These results show that model performance doesn't just depend on a single fixed setting, but rather on the chosen threshold, which controls the balance between detecting actual attacks and avoiding false positives. In contrast, regularisation has little effect once it reaches moderate values.

Another advantage of logistic regression is that it's easy to interpret, as the learned coefficients overtly show how each feature directly influences the prediction. Positive coefficients push predictions toward the DDoS class, while negative coefficients support the benign class.

The most important DDoS-indicating features include:

- `Init Bwd Win Bytes`
- `SYN Flag Count`
- `Protocol_6`
- `Down/Up Ratio`

These features align with known attack characteristics, such as abnormal TCP flag usage and protocol-level patterns typical of DDoS traffic.

The most important benign-indicating features include:

- `Fwd Segment Size Min`
- `Fwd Packet Length Max`
- `Protocol_17`
- `PSH Flag Count`

These features correspond to more stable and structured flow behaviour associated with legitimate traffic.

#figure(
  image("images/lr/lr_feature_coefficients.png"),
  caption: [Most influential logistic regression coefficients. Positive values support the DDoS class, while negative values support the benign class.],
)

It is noteworthy, that the most important features match commonly known DDoS characteristics, suggesting that the model does not rely on random correlations, but is in fact learning meaningful and real patterns. This is useful in security settings, where it is relevant to understand why a prediction is made.

Using the best validation setup, logistic regression performs well on the test-set, reaching an accuracy of $0.9855$ and a ROC-AUC of approximately $0.996$.

Class-wise performance reveals a slight asymmetry:

- Benign recall: $0.9715$
- DDoS recall: $0.9995$

This indicates that the model almost never misses attack traffic, but sometimes misclassifies benign flows as attacks. The confusion matrix confirms that most errors correspond to false positives rather than false negatives.

Prioritising catching attacks over avoiding false alarms leans into a conservative detection strategy. While this may be the safer option for security settings, it also leads to unnecessary blocking of legitimate traffic. Therefore selecting an appropriate decision threshold is the most important factor when balancing the trade-off between detection performance and acceptable false positive rates.

#figure(
  image("images/lr/lr_confusion_matrix.png"),
  caption: [Confusion matrix on the test set. Errors are dominated by false positives rather than missed attacks.],
)

Cross-validation yields a mean accuracy of #text(fill: red)[(insert CV mean) with standard deviation (insert CV std)], indicating that performance is stable across different data splits and not driven by a particular partition of the data.

A limitation of this evaluation is that the dataset is explicitly balanced and heavily preprocessed, which may simplify the classification task. In real-world scenarios, class imbalance and noisier feature distributions could reduce performance and increase the importance of threshold tuning.


== Random Forest

#text(fill: red)[Random forest results to be added]

= Conclusion <sec:conclusion>

kNN proves unsuitable for practical DDoS detection as implemented in this report. While it does achieve near-perfect accuracy of $99.7%$ on the balanced dataset, this does not generalise to realistic conditions where traffic is unbalanced: DDoS recall collapses to $32.0%$, confirming that overfitting occurred. Its inference throughput of $1 thin 409$ flows/s on desktop hardware and just $142$ flows/s on the Raspberry Pi 4 further disqualify it from being used in any real scenario, as even a lightly loaded home router would overwhelm it. The primary issue is the cost of distance computation in the high-dimensional feature space that was used. With 79 features and $200 thin 000$ samples, both training and inference are prohibitively slow. Future work should investigate reducing the feature space as in @dos_knn, or applying class-weighted voting to address the imbalance sensitivity, rather than letting the majority class crowd out the minority class.

Logistic regression provides a strong, stable, and interpretable baseline for DDoS detection on this dataset.

First, performance is largely insensitive to the regularisation parameter once the model is no longer under-constrained, and no significant overfitting is observed. Second, the classification threshold has a much larger effect on the trade-off between false positives and recall, making it the primary tuning mechanism for deployment. Third, coefficient analysis shows that the model relies on meaningful traffic features such as TCP flags, protocol indicators, and flow-level statistics.

Taken together, these results suggest that the dataset is close to linearly separable and that logistic regression is sufficient to capture most of the available signal, while offering the advantages of simplicity, computational efficiency, and interpretability.

#include "andi.typ"
#include "conrad.typ"
