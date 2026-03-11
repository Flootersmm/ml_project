
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

The protocol was additionally one-hot encoded since it is categorical. The data was also cleaned, where inf values were relaced with NaN. For robustness, outliers were identified through use of the median instead of the mean. In terms of training the models a 60/20/20 split was employed where 60% of the data was used for training, 60% for validation and 20% for testing. 


Add still: how is correctness evaluated? feature scaling in KNN and LR (not present in RF), hyper param tuning, and maybe eval/feature importances. also talk about the overfitting and underfitting. this probably for the eval tho. 


[W I L L  | F I N I S H  | A N D  | F O R M A T  | S O O N -SAMUEL]

