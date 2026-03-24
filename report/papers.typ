// This is just to gather reports in one place and potentially evaluate, file not formatted for citation

#let my-name = "Samuel RF"

#let show-source(src) = [
  - #if src.link != none [#link(src.link)[Source]] else [No link]
  - *Citation:* #src.citation
  - *Brief:* #src.brief
]

#let sources = (
  (
    owner: "Samuel RF",
    link: "https://www.semanticscholar.org/paper/Machine-learning-based-DDoS-detection-for-IoT-Xie/86be19ca7507e0923629130ffa89ec23452e5aa9",
    citation: "Xie, Y. (2023). Machine learning-based DDoS detection for IoT networks. Applied and Computational Engineering, 29, 99–107.",
    brief: "Shows Random Forest can achieve high accuracy with relatively low power usage, making it suitable for constrained devices like Raspberry Pi.",
  ),
  (
    owner: "Samuel RF",
    link: "https://pmc.ncbi.nlm.nih.gov/articles/PMC12246053/",
    citation: "APA: Nawaz, M., Tahira, S., Shah, D., Ali, S., & Tahir, M. (2025). Lightweight machine learning framework for efficient DDoS attack detection in IoT networks. Scientific reports, 15(1), 24961. https://doi.org/10.1038/s41598-025-10092-0",
    brief: "DDoS detection in IoT, finds RF to be best performer among LR, Naive Bayes, deep learning"
  ),
  (
    owner: "Samuel RF",
    link:"../non-linkableRPs/Turcomat+May+2023.pdf",
    citation: "Prashanthi, P., Reddy, M. M., & Lavanya, A. (2023). Machine learning for IoT security: Random forest model for DDoS attack detection. Turkish Journal of Computer and Mathematics Education, 14(03), 1029–1038.",
    brief: "IoT DDoS detection, compares SVM, RF, XGBOOST, ADABOOST, KNN and Naive Bayes. Finds RF superior"
  )
)

= #my-name

#for src in sources [
  #if src.owner == my-name [
    #show-source(src)
    #v(8pt)
  ]
]

