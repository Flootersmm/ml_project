== Logistic Regression

=== Model and Preprocessing

We use logistic regression as an interpretable linear baseline for binary DDoS detection. For an input feature vector $x$, the model estimates the probability of the DDoS class as

$
P(y = 1 | x) = sigma(w^T x + b),
$

where $w$ is the coefficient vector, $b$ is the bias term, and $sigma(.)$ is the sigmoid function. Classification is obtained by thresholding this probability. To reduce overfitting, we apply L2 regularization, controlled by the inverse regularization parameter $C$, where smaller values correspond to stronger regularization.

Before training, we remove identifier-like and non-predictive fields such as flow IDs, IP addresses, ports, and timestamps. The protocol field is one-hot encoded. Infinite values are replaced and missing values are imputed using the median. All remaining features are standardized to zero mean and unit variance. We use a stratified 60/20/20 split into training, validation, and test sets. Hyperparameters are selected on the validation set only, while the test set is reserved for final evaluation.

(The final dataset contains approximately (insert samples per class) per class and (insert number of features) features after preprocessing.)

---

=== Effect of Regularization

To study the sensitivity of logistic regression to regularization, we evaluate $C$ over a logarithmic range from $10^-4$ to $10^4$. For each value of $C$, we measure training accuracy, validation accuracy, and the overfitting gap.

The results show that very small values of $C$ lead to underfitting, with both training and validation accuracy reduced. As $C$ increases, performance improves rapidly and stabilizes around $C ≈ 0.046$. Beyond this point, further increases in $C$ yield negligible gains. The overfitting gap remains close to zero across all values, indicating that the model generalizes well and does not exhibit meaningful overfitting.

This behaviour suggests that the dataset is close to linearly separable with the chosen feature representation. Once sufficient model flexibility is reached, additional capacity does not improve performance. This places the model in a low-bias, low-variance regime, where both underfitting and overfitting effects are minimal.

#figure(
  image("images/lr/lr_hyperparameter_tuning_overfitting.png"),
  caption: [Effect of the inverse regularization parameter $C$ on performance. Accuracy improves sharply at low $C$ and quickly plateaus, while the overfitting gap remains negligible.]
)

The best validation performance is achieved at $C ≈ 0.046$, with validation accuracy of approximately 0.9855.

---

=== Threshold-Based Trade-off Analysis

While regularization has limited influence beyond moderate values, the classification threshold strongly affects the model’s operational behaviour. Using the best validation model, we evaluate thresholds between 0.1 and 0.9.

Increasing the threshold makes the classifier more conservative: fewer flows are classified as DDoS, which reduces the false positive rate (FPR) and increases precision, but lowers recall. Conversely, lower thresholds maximize detection but increase false positives.

For example, at threshold 0.5, the model achieves approximately FPR ≈ 0.028 and recall ≈ 0.9995. Increasing the threshold to 0.9 reduces the FPR to approximately 0.015, while recall drops to approximately 0.9588. This demonstrates a clear trade-off between detection sensitivity and false alarm rate.

#figure(
  image("images/lr/lr_threshold_sweep.png"),
  caption: [Threshold sweep for logistic regression. Increasing the decision threshold reduces false positives and increases precision, but lowers recall.]
)

These results show that model performance is not characterized by a single operating point, but by a continuum of trade-offs. Threshold selection is therefore a critical design decision in deployment. In contrast to regularization, which has limited impact after moderate values, the threshold directly controls the balance between security sensitivity and operational cost.

---

=== Interpreting the Decision Boundary

A key advantage of logistic regression is interpretability. The learned coefficients directly indicate how each feature influences the prediction. Positive coefficients push predictions toward the DDoS class, while negative coefficients support the benign class.

The most important DDoS-indicating features include:

- Init Bwd Win Bytes
- SYN Flag Count
- Protocol_6
- Down/Up Ratio

These features align with known attack characteristics, such as abnormal TCP flag usage and protocol-level patterns typical of DDoS traffic.

The most important benign-indicating features include:

- Fwd Segment Size Min
- Fwd Packet Length Max
- Protocol_17
- PSH Flag Count

These features correspond to more stable and structured flow behaviour associated with legitimate traffic.

#figure(
  image("images/lr/lr_feature_coefficients.png"),
  caption: [Most influential logistic regression coefficients. Positive values support the DDoS class, while negative values support the benign class.]
)

The alignment between learned coefficients and domain-relevant features suggests that the model captures meaningful structure rather than relying on spurious correlations. This interpretability is particularly valuable in security applications, where understanding the basis of a prediction is essential.

---

=== Final Performance

Using the best validation configuration, logistic regression achieves strong performance on the held-out test set. The model reaches a test accuracy of 0.9855 and a ROC-AUC of approximately 0.996.

Class-wise performance reveals a slight asymmetry:

- Benign recall: 0.9715
- DDoS recall: 0.9995

This indicates that the model almost never misses attack traffic, but occasionally misclassifies benign flows as attacks. The confusion matrix confirms that most errors correspond to false positives rather than false negatives.

#figure(
  image("images/lr/lr_confusion_matrix.png"),
  caption: [Confusion matrix on the test set. Errors are dominated by false positives rather than missed attacks.]
)

Cross-validation yields a mean accuracy of (insert CV mean) with standard deviation (insert CV std), indicating that performance is stable across different data splits and not driven by a particular partition of the data.

A limitation of this evaluation is that the dataset is explicitly balanced and heavily preprocessed, which may simplify the classification task. In real-world scenarios, class imbalance and noisier feature distributions could reduce performance and increase the importance of threshold tuning.

---

=== Summary

Logistic regression provides a strong, stable, and interpretable baseline for DDoS detection on this dataset.

First, performance is largely insensitive to the regularization parameter once the model is no longer under-constrained, and no significant overfitting is observed. Second, the classification threshold has a much larger effect on the trade-off between false positives and recall, making it the primary tuning mechanism for deployment. Third, coefficient analysis shows that the model relies on meaningful traffic features such as TCP flags, protocol indicators, and flow-level statistics.

Taken together, these results suggest that the dataset is close to linearly separable and that logistic regression is sufficient to capture most of the available signal, while offering the advantages of simplicity, computational efficiency, and interpretability.