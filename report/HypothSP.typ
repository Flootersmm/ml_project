// HYPOTHESES

The research question focuses on designing a DDoS detecion model to minimise false positive rates while maintaining high detection accuracy on both low and high powered hardware. With respect to this, our first hypohesis is that the random forest model and the kNN model will outperform linear regression in the minimisation of false-positive rates (FPR). This stems form the fact that netwrk traffic paterns are inherently non-linear given occurences such as burst behaviours, temporal correlations and other protoco-specific signatures that don't subscribe to a linear formatting. Additionally, the interaction of different features is extremely impotant. This encompasses combinations such as packet rates and payload sizes or duration of and number of failed handshakes. We expect linear regression will struggle to capture precise decision boundaries due to the multi-faceted aspect of the data, thereby yielding a higher FPR than RF and kNN. 
We expect that kNN will perform well because benign data clusters naturally, i.e. normal user behaviour is repetitive. However, the extent of the diversity of the attack variants may complicate the clustering. We do not expect kNN to perform best, as we expect a variety of different attack formats given the dataset samples a multitude of other dates Therefore, we hypothesise that the random forest model will outperform kNN (and LR) in terms of accuracy. Aditionally, we also expect the kNN model to underperform RF and LR in terms of computational speed. kNN is a lazy algorithm and therefore the training dataset will take up a very significant portion of the embedded devices limited memory, as well as needing to recan the entire dataset anew when new data arrives. We hypothesise that linear regression will run fastest given that it is a very simple model. We expect the order to be 
1. LR
2. RF
3. kNN
Over all, we expect the random forest model to outperform the other two when accounting for speed and accuracy.

hypothesis now: Which machine learning approaches best minimise false positive rates while maintaining high detection accuracy for DDoS detection across varying hardware constraints?

(not edited, reviewed, accurate subject to alteration of H)
