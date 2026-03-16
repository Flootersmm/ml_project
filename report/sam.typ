
The algorithms in this project were trained on data obtained from kaggle (MAYBE NEED TO LINK HERE??). The data was already mostly equally balanced between benign traffic and DDoS traffic. The data was also shuffled in the event that some unknown order had been preserved upon creation. Notably though the data is quite large and does not fit into the memory of the hardware of the researchers. For this reason, the project employs a chunking approach, so that the data can be fully trained upon. The data is read into the models in chunks. Because of this, the entire dataset is not loaded in at once as not all data points are used. Balancing is done to ensure that training is not hindered by biases. This could for example happen when a model favours the majority class, when trained on imbalanced data. This ensures accurate, fair, and reliable predictions across all classes. In this case, 10’000 rows for DDoS and 10’000 rows for benign traffic were used. The features were also modified; namely the identifying columns and other non-revelvant determined data were all dropped. The dropped columns were as follows: #table(
  columns: (auto),
  inset: (x: 8pt, y: 4pt),
  stroke: 0.5pt + gray,
  [*Column*],
  [`Label`],
  [`Unnamed: 0`],
  [`Flow ID`],
  [`Src IP`],
  [`Dst IP`],
  [`Timestamp`],
  [`Src Port`],
  [`Dst Port`],
)

The protocol was additionally one-hot encoded since it is categorical. The data was also cleaned, where inf values were relaced with NaN. For robustness, outliers were identified through use of the median instead of the mean. In terms of training the models, a 60/20/20 split was employed where 60% of the data was used for training, 20% for validation and 20% for testing.

The models that will be evaluated are a k-Nearest Neighbours model, a random forest model, and a logistical regression model. Each of these models has tuned hyperparameters. A variety of possible hyper-parameters are tested, and the best one is chosen by the argmax function on the validation set's accuracy. To make sure that the best hyper-parameters aren't simply overfitting the models will also be benchmarked to determine the extent of over or underfitting.  

The correctness of the models will be evaluated through the accuracy of the model upon the test data. This mainly takes into account the extent to which false positives were minimised while true positives were maximised. The research question scope includes the use of models on low and high powered hardware. Correctness remains the same as previously defined, with the constraint that the models must run in [XXXXXXXX][TIMEFRAME] to qualify as having successfully run on the specified hardware. To evaluate this, the high powered hardware will encompass a modern computer who's computation power is at least X Y Z, and a low-powered computer like a raspberry-pi who's computation power is maximally X Y Z. In place of a physical raspberry-pi, a raspberry-pi emulator will be used. 




Add still: how is correctness evaluated? MORE DETAILED, like precision, recall, ROC/AUC etc. feature scaling in KNN and LR (not present in RF), overfitting analysis details, feature importance for RF and why we do that, threshold tuning in LR only, use of simpleimputed for cleaning, complete hardware XXXX placeholders


[W I L L  | F I N I S H  | A N D  | F O R M A T  | S O O N -SAMUEL]

