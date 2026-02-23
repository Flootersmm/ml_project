#import "@preview/charged-ieee:0.1.4": ieee
#import "@preview/slashion:0.1.1": slash-frac as sfrac

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
