#import "@preview/charged-ieee:0.1.4": ieee
#import "@preview/slashion:0.1.1": slash-frac as sfrac

#set document(title: "MLVU information sheet")
#set page(margin: 2.5cm)

#align(center)[
  #text(size: 1.8em, weight: "bold")[MLVU information sheet]
]

_Please include this page in your report either at the start or at the end, before the appendix. Do not change the formatting._

*Group number*

00

*Authors*

#table(
  columns: (auto, auto),
  align: right,
  stroke: none,
  [name], [student number],
  table.hline(),
  [Jane Doe], [1234567],
  [], [],
  [], [],
)

*Software used* _Describe briefly which software and libraries you relied on. If you built a particular algorithm from scratch, make sure to state it explicitly here._

*Use of AI tools* _If you used tools like ChatGPT or Github Copilot in any phase of the report, please detail here which tools you used, what parts of the work you used them for and how. Note that if you use an AI tool and don't report it, it's considered fraud, so be detailed. Note also that having an AI tool write for you is not allowed. If no AI tools were used, please state that explicitly._

*Link to code (optional)* _If you would like to share your code, you can link to your repository here._

*Group disagreements (optional)* _If there are any disagreements in the group, you may *not* remove a student from the author list without their consent. You should bring disagreements to our attention early. As a last resort, you can describe any grievances here._

#pagebreak()

#set table(
  columns: (6em, auto),
  inset: (x: 8pt, y: 4pt),
  stroke: (x, y) => if y <= 1 { (top: 0.5pt) },
  fill: (x, y) => if y > 0 and calc.rem(y, 2) == 0 { rgb("#efefef") },
)

#show: ieee.with(
  title: [TITLE HERE],
  authors: (
    (
      name: "Conrad Clough",
      department: [VUNetId: cch250],
      organization: [Student Nr: 2699315],
      email: "c.j.clough@student.vu.nl",
    ),
  ),
  // index-terms: ("Scientific writing", "Typesetting", "Document creation", "Syntax"),
  bibliography: bibliography("refs.bib"),
  figure-supplement: [Fig.],
)

#set page(numbering: "1")

= Introduction <sec:intro>
Blah blah blah. We can quote code `like this`. We can also reference sections like this @sec:intro or even define labels on things like figures and images and reference them later.

Wanna reference something in the bibliography? Just do it with another label @javareentrantlock

The report is structured as follows:
- In @sec:design we consider and justify our design.

= Design <sec:design>
- Bullet points are super easy
- Like this!

+ Numbered lists too
+ Wow
  + Even with indentation
  - and mixing!


Math, with equation labels:
$ T_upright("coarse") = c t f (n) $<eq:coarse>.
Or even inline $frac(n, 2)$ wowie
$ T_upright("fine") = op("max") (ceil(frac(c, 2n)) dot t f (n), thick t f (n)) $<eq:fine>.

Figures!
// #figure(
//   placement: top,
//   image("images/1_parallel_scalability.png"),
//   caption: [Parallel Scalability of our structures for all thread counts and job sizes],
// ) <fig:parallelscalability>
// In @fig:parallelscalability we can very clearly see that our experimental data matches the time complexity of access/mutation for our structures.
Commented out because if there's no image in the directory you put in then it'll fail to compile or have live preview :(

Tables too:
#figure(
  placement: top,
  table(
    columns: 4,
    align: (left, right, right, right),
    inset: 4pt,
    stroke: 0.5pt + gray,
    table.header([*Structure*], [*$p$*], [*Max Speedup *], [*Eff. (16 threads)*]),
    [Coarse-grained List], [2.3%], [1.02$times$], [6.4%],
    [Coarse-grained BST], [92.7%], [13.64$times$], [45.4%],
    [Fine-grained List], [48.5%], [1.94$times$], [22.9%],
    [Fine-grained BST], [76.2%], [4.20$times$], [19.3%],
  ),
  caption: [Amdahl's Law metrics at 65536 job count],
)<fig:amdahls>

Generally you can surround things in figures or blocks and such, it's all super functional, the typst website will guide you

Typst website also have all the symbol names, and some symbols have subsets like $subset$ has $subset.eq$
