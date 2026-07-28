# Literature review — Part 5, *How a Dharma Gets Under Your Skin*

**Date:** 2026-07-28 · **Scope:** downloadable full-text sources bearing on `5-under-your-skin.md`
and its underlying notes (5.1, 5.2, 5.3, 5.4, 5.5). Notes 5.1–5.5 are also drawn on by Parts 2 and 6;
this review covers them as a whole, not only the slice Part 5 quotes.

## Why this review exists

Part 5 is the most *empirical* essay in the series. Almost every sentence is a load-bearing claim
about published science — gamma synchrony, grey matter, oxytocin, heart-rate synchrony, delay of
gratification, moral foundations, PCL-R prevalence. An audit of the ~60 sources behind it shows
that a large fraction of those claims currently rest on **Wikipedia, publisher landing pages,
abstract-only records, popular-science books, YouTube transcripts, or blog posts** — and, more
seriously, that several of the underlying findings have been **contested, qualified or
non-replicated** since the sources the notes used were written.

| Claim in the essay | Currently sourced to | Status |
|---|---|---|
| Whitehouse's doctrinal vs imagistic modes | **Wikipedia** (5.4 S7) | tertiary |
| Durkheim, "collective effervescence" | **Wikipedia** (5.4 S8) | tertiary |
| Firewalk heart-rate synchrony (San Pedro Manrique) | **YouTube transcript** (5.4 S3) | tertiary |
| "Ritual stance" raises self-control in Slovakia & Vanuatu | **prosocial.world blog post** (5.4 S4) | secondary |
| Haidt: intuition-first, moral foundations | moralfoundations.org / righteousmind.com **websites** (5.3 S7) | tertiary |
| Gilligan's critique of Kohlberg | **publisher page** (hup.harvard.edu) (5.3 S6) | not read |
| Snarey cross-cultural meta-analysis | **PubMed abstract** (5.3 S10) | abstract-only |
| Lazar 2005 cortical thickness | lab publications page (5.1 S4) | abstract-level |
| Hölzel 2011 grey-matter density | **ScienceDirect abstract** (5.1 S5) | abstract-only |
| Kral 2022 non-replication; Fox 2014 meta | science.org landing + **PubMed abstract** (5.1 S6) | abstract-only |
| De Dreu, oxytocin "tend-and-defend" | **PNAS abstract page** (5.1 S8) | abstract-only |
| Ricard: compassion ≠ empathy in the brain | Sapolsky's *Behave*, a **popular-science book** (5.1 S1) | secondary |
| Cleckley, Hare, PCL-R, ASPD, Dutton | **Wikipedia** ×4 (5.5 S31–S34, S43) | tertiary |
| Hare, "intraspecies predators" | **FBI bulletin** quoting the book (5.5 S45) | secondary |
| Murphy 1976, *kunlangeta* | **Scientific American** article (5.5 S46) | secondary |
| Sosis & Bressler commune longevity | SAGE landing page (5.2 S6) | abstract-level |
| Henrich 2009, CREDs | **ScienceDirect abstract** (5.2 S7) | abstract-only |
| Choi & Bowles, parochial altruism | **Science abstract page** (5.2 S8) | abstract-only |

> **Acquisition status (2026-07-28):** **nothing has been downloaded for Part 5.** There is no
> `scratch/sources/part5/`; the existing archive (`scratch/sources/part1/`, 85 files) covers Part 1
> only. Everything below is a verified *link*, not a file on disk. The Part-1 fetch harness
> (`scratch/sources/fetch.py` + TSV manifest) will take this list unchanged.

Everything below was **link-verified on 2026-07-28** (HTTP status + content-type via
`curl -sIL --max-time 30`; PMC records additionally checked by title through the Europe PMC REST
API to guard against ID-collision). Access flags are honest:
`verified` = live full text retrieved by a scripted fetch; `browser` = open access but bot-blocked
to scripted requests (Wiley, SAGE, T&F, OUP, science.org, escholarship, some repositories) — one
click in a normal browser; `lending` = archive.org borrow required; `walled` = no free copy found.

▲ **Provenance warning.** As in Part 1, several items here are *community uploads of in-copyright
books* or course-server copies of paywalled articles. They are **reading copies only** — read them,
write attributed summary notes into `$VECTORDBS/appliedanthropology/workshops/DD/sources/`, and do
not add the PDFs to the repo or the corpus. Items marked **OA** are genuinely open-licensed.

▲ **The corpus lean, disclosed not corrected.** The shared corpus reads ritual and religion
*functionally* (Wilson, ProSocial World, Sosis) and reads contemplative neuroscience from inside the
Mind & Life programme (Thompson, Davidson). Note 5.1 already flags this as a motivated-reasoning
risk. This review does not seek "balance" by importing pro-authority material; it imports the
**methodological critics** — the people who ran the replications — because the essay's own honesty
setting ("real but routinely oversold") is only as good as the critical literature standing behind it.

---

## Tier 0 — the six that change the most, soonest

*(Part 1's template lists five. Part 5 needs six: the oxytocin item cannot be dropped without
leaving a false claim standing in the essay.)*

1. **Van Dam et al. (2018), "Mind the Hype: A Critical Evaluation and Prescriptive Agenda for
   Research on Mindfulness and Meditation", *Perspectives on Psychological Science* 13(1):36–61.**
   <https://pmc.ncbi.nlm.nih.gov/articles/PMC5758421/> `verified` (full text, HTML) ·
   publisher PDF at <https://research.rug.nl/files/56912114/Mind_the_Hype.pdf> `browser`
   Fifteen authors, most of them practitioners of the science, documenting definitional drift,
   weak methodology, adverse-event under-reporting and media over-claiming. Note 5.1 cites it
   second-hand from note 3.2; the essay's whole calibration ("real but oversold") is this paper's
   argument. Read it first, and quote it directly.

2. **Kral, Davidson et al. (2022), "Absence of structural brain changes from mindfulness-based
   stress reduction: Two combined randomized controlled trials", *Science Advances* 8(20):eabk3316.**
   **OA** <https://europepmc.org/articles/PMC9122316?pdf=render> `verified` (PDF)
   *n* = 218, three arms, active *and* waitlist controls: no gray-matter volume, no gray-matter
   density, no cortical-thickness change, whole-brain or ROI. This is the single most load-bearing
   citation in the essay's third section and it is currently a landing-page reference. The paper
   also names the specific methodological sins of the earlier literature — worth quoting rather
   than paraphrasing.

3. **Royzman, Kim & Leeman (2015), "The curious tale of Julie and Mark: Unraveling the moral
   dumbfounding effect", *Judgment and Decision Making* 10(4):296–313.** **OA**
   <https://www.cambridge.org/core/services/aop-cambridge-core/content/view/B8243CAF7E57AFA4F05B6F1199EB0EBF/S193029750000512Xa.pdf/div-class-title-the-curious-tale-of-julie-and-mark-unraveling-the-moral-dumbfounding-effect-div.pdf>
   `verified`
   The most direct published attack on the essay's central mechanism. Three studies: subjects do
   *not* in fact believe the incest case is harmless; once beliefs about harm and normative standards
   are measured properly, **the dumbfounding estimate falls to about zero**, and subjects' reactions
   are "wholly in line with the rationalist model of moral judgment." The elephant-and-rider passage
   should meet this paper.

4. **Curry, Jones Chesters & Van Lissa (2019), "Mapping morality with a compass: Testing the theory
   of 'morality-as-cooperation' with a new questionnaire", *JRP* 78:106–124.** **OA CC BY-NC-ND**
   <https://ora.ox.ac.uk/objects/uuid:ea1e14c7-80ba-48a9-988b-fe9b107f8d69/files/m854f36ec59cb7c25189c42b17c21ff44>
   `verified` (Oxford ORA deposit)
   The head-to-head. Four studies: the seven-factor MAC model fits; **the MFQ's five-factor model
   does not**. Since Part 1 already runs on Curry's morality-as-cooperation, Part 5's uncritical use
   of Haidt's six foundations puts the book at odds with itself — this paper is where the two
   frameworks actually meet, and it is by the author the project already relies on.

5. **The two primary papers behind the ritual section** — currently sourced to a YouTube transcript
   and a blog post.
   - **Konvalinka, Xygalatas, Bulbulia et al. (2011), "Synchronized arousal between performers and
     related spectators in a fire-walking ritual", *PNAS* 108(20):8514–8519.**
     <https://europepmc.org/articles/PMC3100954?pdf=render> `verified` (PDF)
     The San Pedro Manrique study itself: synchrony between fire-walkers and **related** spectators,
     *not* unrelated ones — the essay's "tightest between people who loved each other" is faithful,
     but the "one could read the social distance from heartbeats" gloss is the transcript's, not the
     paper's.
   - **Rybanska, McKay, Jong & Whitehouse (2017), "Rituals Improve Children's Ability to Delay
     Gratification", *Child Development* 89(2):349–359.**
     <https://srcd.onlinelibrary.wiley.com/doi/pdfdirect/10.1111/cdev.12762> `browser` ·
     record + abstract: <https://doi.org/10.1111/cdev.12762>
     The actual Slovakia-and-Vanuatu experiment (*N* = 210, three-month circle-time intervention),
     with the mediation path the essay compresses: ritual cues → executive function → delay of
     gratification.

6. **The oxytocin correction — three papers, read together.**
   - **Walum, Waldman & Young (2016), "Statistical and Methodological Considerations for the
     Interpretation of Intranasal Oxytocin Studies", *Biological Psychiatry* 79(3):251–257.**
     <https://pmc.ncbi.nlm.nih.gov/articles/PMC4690817/> `verified`
     Median *n* per group in the intranasal-OT literature is tiny; power to detect realistic effects
     is ~16%; published significant findings are therefore likely to be inflated or false positives.
   - **Leng & Ludwig (2016), "Intranasal Oxytocin: Myths and Delusions", *Biological Psychiatry*
     79(3):243–250.** <https://www.pure.ed.ac.uk/ws/files/19764306/accepted_manuscript_Leng_and_Ludwig.pdf>
     `verified` (Edinburgh PURE accepted manuscript)
     Two neuroendocrinologists on whether intranasal doses reach the brain in behaviourally
     meaningful concentrations at all.
   - **McCullough, Churchland & Mendez (2013), "Problems with measuring peripheral oxytocin: Can the
     data on oxytocin and human behavior be trusted?", *Neurosci. Biobehav. Rev.* 37(8):1485–1492.**
     <https://escholarship.org/content/qt6hd550tb/qt6hd550tb.pdf> `browser` (eScholarship OA)
     Plasma/salivary OT assays disagree by orders of magnitude — the measurement base of the whole
     correlational literature.
   The essay states tend-and-defend as settled fact. It is the least secure empirical claim in Part 5.

---

## 1 · The elephant and the rider: intuitionism and its critics  (note 5.3)

### The primary statement (retire the website citations)
- **Haidt (2001), "The Emotional Dog and Its Rational Tail: A Social Intuitionist Approach to Moral
  Judgment", *Psychological Review* 108(4):814–834.**
  <https://www.protevi.com/john/Morality/HaidtEmotionalDog.pdf> `verified` · course-server copy, grey.
  Note 5.3 [S7] cites `moralfoundations.org` and `righteousmind.com` for this. The paper itself is
  more careful than its reputation: Haidt allows private reflection and reasoned persuasion as real
  (if less common) causal routes — a nuance the essay's rider/elephant image flattens.
- **Haidt & Joseph (2004), "Intuitive ethics: how innately prepared intuitions generate culturally
  variable virtues", *Daedalus* 133(4):55–66.** <https://direct.mit.edu/daed/article/133/4/55/27470/>
  `browser` (MIT Press; the article page 403s to scripted fetches). The origin of the "foundations"
  vocabulary and of the cuisine/taste-buds metaphor the essay uses.
- **Graham, Haidt, Koleva, Motyl, Iyer, Wojcik & Ditto (2013), "Moral Foundations Theory: The
  Pragmatic Validity of Moral Pluralism", *Adv. Exp. Soc. Psych.* 47:55–130.**
  <https://cpb-us-e2.wpmucdn.com/sites.uci.edu/dist/1/863/files/2020/06/Graham-et-al-2013.AESP_.pdf>
  `verified` · author-hosted. The canonical statement, including the five formal criteria a candidate
  foundation must meet — useful because it shows MFT's authors conceding the count is open.

### ▲ Substantive challenge found here — the rationalist counter-case is alive
- **Royzman, Kim & Leeman (2015)** — Tier 0, above. Dumbfounding ≈ 0.
- **Stanley, Yin & Sinnott-Armstrong (2019), "A reason-based explanation for moral dumbfounding",
  *JDM* 14(2):120–129.** **OA**
  <https://www.cambridge.org/core/services/aop-cambridge-core/content/view/5347532A1A642F83B91F1A20788EF31E/S1930297500003351a.pdf/div-class-title-a-reason-based-explanation-for-moral-dumbfounding-div.pdf>
  `verified`. Judged *likelihood of harm* predicts wrongness judgements and can be experimentally
  manipulated — so subjects were tracking a reason all along.
- **Landy & Goodwin (2015), "Does Incidental Disgust Amplify Moral Judgment? A Meta-Analytic Review
  of Experimental Evidence", *PPS* 10(4):518–536.**
  <https://repository.upenn.edu/bitstreams/f68918bb-0e6f-4081-abec-daf400322dc2/download>
  `verified` (61 pp., Penn repository). The gut-feelings-drive-judgement literature meta-analysed:
  the effect is very small and plausibly nil once publication bias is modelled. This directly
  undercuts the strongest form of "the feeling comes first."
- **Decety & Cowell (2014), "Friends or Foes: Is Empathy Necessary for Moral Behavior?", *PPS*
  9(5):525–537.** <https://pmc.ncbi.nlm.nih.gov/articles/PMC4241340/> `verified`.
  The peer-reviewed version of the argument the essay attributes to Bloom's trade book — and it is
  more discriminating: empathy is *dissociable* into affective arousal, concern and perspective-taking,
  with different moral consequences, rather than being simply "a poor moral guide."

*Gap, honestly flagged:* I did **not** find a full-text critique of **Greene's** two-tragedies framing
(the Kahane / Berker line against dual-process moral psychology). The essay leans on Greene twice and
the counter-literature is currently unsourced in the notes.

---

## 2 · Moral foundations, WEIRD, and the MFT-vs-MAC contest  (note 5.3)

- **Curry, Jones Chesters & Van Lissa (2019)** — Tier 0.
- **Atari, Haidt, Graham et al. (2023), "Morality Beyond the WEIRD: How the Nomological Network of
  Morality Varies Across Cultures", *JPSP* 125(5):1157–1188.** Preprint (author accepted version):
  <https://osf.io/preprints/psyarxiv/q6c9r> `browser` · published version `walled`.
  MFT's own authors rebuilding the instrument (MFQ-2) across 25 populations, **splitting Fairness
  into Equality and Proportionality** and showing the network of foundations varies by culture.
  Anyone quoting "six foundations" in 2026 should know the count moved.
- **Zakharin & Bates (2021), "Remapping the foundations of morality: Well-fitting structural model of
  the Moral Foundations Questionnaire", *PLoS ONE* 16(10):e0258910.** **OA**
  <https://journals.plos.org/plosone/article/file?id=10.1371/journal.pone.0258910&type=printable>
  `verified`. Five large samples, *N* = 11,496: no previously theorised MFQ model fits; the binding
  trio splits into five. Converges with the psychometric worry note 5.3 already carries from Bretl &
  Goering.
- **Gray, DiMaggio, Schein & Kachanoff (2022), "The Problem of Purity in Moral Psychology", *PSPR*
  27(3):272–308.** <https://journals.sagepub.com/doi/10.1177/10888683221124741> `browser` (SAGE OA;
  403s to scripts). Systematic review finding ~9 incompatible meanings of "purity", no convergent or
  divergent validity, and confounding with politics, religion and perceived harm. Since the essay's
  sanctity/divinity material does a lot of work, this is the sharpest available objection — and it is
  Kurt Gray's Theory of Dyadic Morality applied.
- **Schein & Gray (2018), "The Theory of Dyadic Morality: Reinventing Moral Judgment by Redefining
  Harm", *PSPR* 22(1):32–70.** <https://journals.sagepub.com/doi/10.1177/1088868317698288> `walled`;
  author copy listed at <https://www.deepestbeliefslab.com/papers/the-theory-of-dyadic-morality-reinventing-moral-judgments-by-redefining-harm-pdf-yz5rb>
  `browser`. The monist alternative: all moral judgement is perceived-harm judgement on a dyadic
  template. Directly opposes the essay's pluralist "taste buds" picture.
- **Fitouchi, André & Baumard (2023), "Moral disciplining: The cognitive and evolutionary foundations
  of puritanical morality", *BBS* 46:e293.** **OA**
  <https://hal.science/hal-03899979v1/file/Fitouchi_MoralDisciplining_202.pdf> `verified`.
  A third position: apparently "purity" moralising (temperance, modesty, asceticism) *is* cooperation
  morality, because self-control is cooperation's proximate requirement. Explains the same data the
  essay assigns to a separate sanctity foundation, without the extra module — and it explains the
  ritual/self-control link in the essay's own second section.
- **Henrich, Heine & Norenzayan (2010), "The weirdest people in the world?", *BBS* 33(2–3):61–83.**
  <https://www2.psych.ubc.ca/~henrich/pdfs/WeirdPeople.pdf> `verified` (already held in
  `scratch/sources/part1/`). No acquisition needed.

### ▲ Substantive challenge found here
The essay presents moral foundations as the settled architecture of the moral mind ("the taste buds
of the moral mind… every human being has all of these"). The current state of play is: **the
questionnaire does not fit**, **purity is not a coherent construct**, **the rival cooperation model
fits better on its own test**, and **MFT's own authors have re-specified the foundations**. None of
this destroys the essay's *point* — that cultures tune a shared affective apparatus differently —
but the point should be made in terms that survive the psychometrics. Curry's morality-as-cooperation
(already Part 1's spine) does that; six named taste buds does not.

---

## 3 · Kohlberg, Gilligan, and the developmental ladder  (note 5.3)

- **Gilligan, *In a Different Voice*** (Harvard UP, 1982) — <https://archive.org/details/indifferentvoice00gillrich>
  `lending`. Note 5.3 [S6] cites the **publisher's page**; this is the borrowable book. No free full text exists.
- **Snarey (1985), "Cross-cultural universality of social-moral development", *Psych. Bulletin*
  97(2):202–232** — `walled` (PubMed abstract only, as the note says). No OA copy found.
- **Jaffee & Hyde (2000), "Gender differences in moral orientation: A meta-analysis", *Psych.
  Bulletin* 126(5):703–726** — `walled` (checked via Unpaywall: no OA location).
  ▲ **This is the missing counterweight.** The meta-analytic finding is that care- and justice-
  orientation gender differences are *small* (d ≈ 0.2 and 0.2 in opposite directions) and largely
  explained by content of the dilemma. Note 5.3 gestures at it ("later work qualifies Gilligan");
  the essay does not, and says Gilligan "landed the hardest blow." Until an OA copy is found, this
  should be footnoted from the note rather than asserted in the essay.
- **Kline, Shamsudheen & Broesch (2018), *Phil. Trans. R. Soc. B* 373:20170059** — already in the
  corpus and cited by note 5.3 [S12]; the "deficit assumption" framing that unifies both critiques.

---

## 4 · Ritual, habituation, synchrony  (note 5.4)

### Primary sources for the claims the essay actually makes
- **Konvalinka et al. (2011)** and **Rybanska et al. (2017)** — Tier 0.
- **Xygalatas, Konvalinka, Bulbulia & Roepstorff (2011), "Quantifying collective effervescence:
  Heart-rate dynamics at a fire-walking ritual", *Communicative & Integrative Biology* 4(6):735–738.**
  <https://www.tandfonline.com/doi/pdf/10.4161/cib.17609> `browser` (T&F OA; 403s to scripts).
  The authors' own short interpretive companion — and the paper that puts Durkheim's phrase on the
  physiological data, which is exactly the move the essay makes.
- **Fischer, Xygalatas, Mitkidis et al. (2014), "The Fire-Walker's High: Affect and Physiological
  Responses in an Extreme Collective Ritual", *PLoS ONE* 9(2):e88355.** **OA**
  <https://journals.plos.org/plosone/article/file?id=10.1371/journal.pone.0088355&type=printable>
  `verified`. Mauritius, with a finding the essay would enjoy: watching a loved one endure the ordeal
  is more *exhausting* than enduring it yourself.
- **Whitehouse, McQuinn, Buhrmester & Swann (2014), "Brothers in arms: Libyan revolutionaries bond
  like family", *PNAS* 111(50):17783–17785.** **OA**
  <https://europepmc.org/articles/PMC4273349?pdf=render> `verified`. The identity-fusion end of the
  imagistic mode, in the field.
- **Whitehouse & Lanman (2014), "The Ties That Bind Us: Ritual, Fusion, and Identification",
  *Current Anthropology* 55(6):674–695.** <https://www.journals.uchicago.edu/doi/epdf/10.1086/678698>
  `browser`. The theoretical statement of the two-modes/two-bonding-routes distinction, in a
  peer-reviewed venue — the replacement for the Wikipedia citation at 5.4 [S7].
- **Whitehouse, *Modes of Religiosity: A Cognitive Theory of Religious Transmission*** (AltaMira, 2004)
  — <https://archive.org/details/modesofreligiosi0000whit> `lending`.
  **Whitehouse, *The Ritual Animal*** (OUP, 2021) — no copy found, `walled`; a substantive review is
  free at <https://www.sav.sk/journals/uploads/07052153SN.2022.2.25.pdf> `verified` (Bahna, *Slovenský
  národopis* 2022) and is a usable stopgap for what the 2021 synthesis adds.
- **Durkheim, *The Elementary Forms of the Religious Life*** (Swain translation, 1915 — public domain)
  <https://archive.org/download/in.ernet.dli.2015.24045/2015.24045.The-Elementary-Forms-Of-The-Religious-Life.pdf>
  `verified`. Replaces the Wikipedia citation at 5.4 [S8] with Durkheim's own words on
  *effervescence*.
- **Aristotle, *Nicomachean Ethics* II.1** — public domain: Ross translation at
  <http://classics.mit.edu/Aristotle/nicomachaen.html> `verified`; Gutenberg edition at
  <https://www.gutenberg.org/ebooks/8438> `verified`. The essay's Durant-attribution caveat is already
  correct and well handled; nothing to fix, only to anchor.
- **Xygalatas (2023), "Culture, Cognition, and Ritual"** (chapter preprint) —
  <https://osf.io/preprints/psyarxiv/yza8x> `browser`. His own current summary of the programme, free,
  and a legitimate citable substitute for the trade book *Ritual* (2022), which has no free copy.
- **Bullock (2017), "The Sociology of the Sunday Assembly: 'Belonging Without Believing' in a
  Post-Christian Context"** (PhD thesis, Kingston University). **OA**
  <https://eprints.kingston.ac.uk/id/eprint/41775/1/Bullock-J.pdf> — ▲ Kingston's server was
  **unreachable from this network today** (`curl` returns 000); the record resolves via
  <https://doi.org/10.13140/rg.2.2.23222.96325>. Flag `browser`, retry later.
  35 interviews inside the Sunday Assembly: the only substantial empirical study of the exact
  institution the essay names, and its finding — homogeneous, ex-religious, middle-class, using
  inherited Christian congregational form — sharpens the essay's open question rather than answering it.

### ▲ Substantive challenges found here
- **Kapitány, Davis, Kundtová Klocová & Legare (2018), "An experimental examination of object-directed
  ritualized action in children across two cultures", *PLoS ONE* 13(11):e0206884.** **OA**
  <https://journals.plos.org/plosone/article/file?id=10.1371/journal.pone.0206884&type=printable>
  `verified`. Australia and Vanuatu, *N* = 202: contrary to the adult findings, ritualized action
  **did not** influence children's valuation of a reward; the authors close with "a call for
  pre-registered replications." The ritual-cognition literature the essay treats as established is
  in the same replication weather as everything else in social psychology.
- **Pizarro, Zumeta, Bouchat et al. (2022), "Emotional processes, collective behavior, and social
  movements: A meta-analytic review of collective effervescence outcomes", *Frontiers in Psychology*
  13:974683.** **OA** <https://www.frontiersin.org/articles/10.3389/fpsyg.2022.974683/pdf> `verified`.
  *k* = 50, *N* = 182,738. This one cuts *for* the essay — collective effervescence is a measurable
  construct with reliable associations to group identity, efficacy and self-transcendent emotion —
  and it is a far better citation than Wikipedia for the strongest claim in the ritual section.
- **Rennung & Göritz (2016), "Prosocial Consequences of Interpersonal Synchrony: A Meta-Analysis",
  *Zeitschrift für Psychologie* 224(3):168–189.** OA record:
  <https://nbn-resolving.org/urn:nbn:de:bvb:384-opus4-971199> `verified` (repository landing; PDF one
  click on). The synchrony→cooperation effect the corpus treats as robust, meta-analysed: real but
  modest, and heterogeneous. Note 5.4 [S4] currently carries this literature via a blog post.
- **Legare & Souza (2012), "Evaluating ritual efficacy: Evidence from the supernatural", *Cognition*
  124(1):1–15** — `walled` (ScienceDirect 403s; no OA copy found).

---

## 5 · Contemplative neuroscience: the hype literature and its correctives  (note 5.1)

### The critical anchors (load-bearing for the essay's honesty)
- **Van Dam et al. (2018)** and **Kral et al. (2022)** — Tier 0.
- **Goyal, Singh, Sibinga et al. (2014), "Meditation Programs for Psychological Stress and Well-being:
  A Systematic Review and Meta-analysis", *JAMA Internal Medicine* 174(3):357–368.**
  <https://pmc.ncbi.nlm.nih.gov/articles/PMC4142584/> `verified` (full text).
  47 trials, 3,515 participants. **Moderate** evidence for improvement in anxiety, depression and
  pain; **low or insufficient** for everything else; and — the sentence that matters for Part 5 —
  **no evidence that meditation programmes outperform active controls** (exercise, drugs, other
  therapies). The essay's "sustained practice *reliably* changes how the brain functions" is stronger
  than this.
- **Kral, Davidson et al. (2018), "Impact of short- and long-term mindfulness meditation training on
  amygdala reactivity to emotional stimuli", *NeuroImage* 181:301–313.**
  <https://pmc.ncbi.nlm.nih.gov/articles/PMC6671286/> `verified`. The functional counterpart to the
  2022 null — what *does* survive from the same lab, and how modest it is.
- **Britton (2019), "Can mindfulness be too much of a good thing? The value of a middle way",
  *Current Opinion in Psychology* 28:159–165.**
  <https://pmc.ncbi.nlm.nih.gov/articles/PMC6612475/> `verified`. Dose–response is not monotonic;
  more practice is not simply better.
- **Britton, Lindahl, Cooper, Canby & Palitsky (2021), "Defining and Measuring Meditation-Related
  Adverse Effects in Mindfulness-Based Programs", *Clinical Psychological Science* 9(6):1185–1204.**
  <https://pmc.ncbi.nlm.nih.gov/articles/PMC8845498/> `verified`.
- **Farias, Maraldi, Wallenkampf & Lucchetti (2020), "Adverse events in meditation practices and
  meditation-based therapies: a systematic review", *Acta Psychiatrica Scandinavica* 142(5):374–393.**
  <https://onlinelibrary.wiley.com/doi/pdfdirect/10.1111/acps.13225> `browser`.
  83 studies, 6,703 participants: **8.3% adverse-event prevalence overall** (33% in observational
  designs), including in people with no prior mental-health history.
- **Schlosser, Sparby, Vörös, Jones & Marchant (2019), "Unpleasant meditation-related experiences in
  regular meditators", *PLoS ONE* 14(5):e0216643.** **OA**
  <https://europepmc.org/articles/PMC6508707?pdf=render> `verified`. 25.6% of regular meditators
  report particularly unpleasant meditation-related experiences.
- **Coronado-Montoya et al. (2016), "Reporting of Positive Results in Randomized Controlled Trials of
  Mindfulness-Based Mental Health Interventions", *PLoS ONE* 11(4):e0153220.** **OA**
  <https://europepmc.org/articles/PMC4825994?pdf=render> `verified`. 108 of 124 trials reported
  positive results — a rate the authors call implausible, i.e. direct evidence of publication bias in
  precisely this literature.
- **Goldberg, Tucker, Greene, Simpson, Hoyt, Kearney & Davidson (2017), "Is mindfulness research
  methodology improving over time? A systematic review", *PLoS ONE* 12(10):e0187298.**
  <https://pmc.ncbi.nlm.nih.gov/articles/PMC5663486/> `verified`.
- **Galante, Friedrich, Dawson et al. (2021), "Mindfulness-based programmes for mental health
  promotion in adults in nonclinical settings: A systematic review and meta-analysis of randomised
  controlled trials", *PLoS Medicine* 18(1):e1003481.** **OA**
  <https://europepmc.org/articles/PMC7799763?pdf=render> `verified`. The best current effect-size
  estimates outside clinical populations, with heterogeneity that will not go away.
- **Fox et al. (2014), "Is meditation associated with altered brain structure?", *Neurosci. Biobehav.
  Rev.* 43:48–73** — `walled` (no OA copy located). Cited by note 5.1 [S6] from a PubMed abstract;
  Kral 2022 supersedes it for the essay's purposes anyway.

### ▲ Substantive challenge found here — the gamma claim
The essay's opening neuroscience beat is Lutz et al. (2004), "greater than any previously reported."
Two things are true and neither is in the notes.
- **Lutz, Greischar, Rawlings, Ricard & Davidson (2004), *PNAS* 101(46):16369–16373.** **OA**
  <https://europepmc.org/articles/PMC526201?pdf=render> `verified`. *n* = 8 monks, 10 controls,
  cross-sectional, never independently replicated at that magnitude.
- **Hipp & Siegel (2013), "Dissociating neuronal gamma-band activity from cranial and ocular muscle
  activity in EEG", *Frontiers in Human Neuroscience* 7:338.** **OA**
  <https://www.frontiersin.org/articles/10.3389/fnhum.2013.00338/pdf> `verified`.
  Scalp EMG and microsaccades contaminate exactly the >30 Hz band, and "prevented a direct
  investigation of neuronal gamma-band activity at the sensor level." A study reporting
  unprecedented scalp gamma in people holding an unusual facial/postural set for an hour is the
  textbook case for this confound. The claim is not refuted — but "the brain activity of monks" is
  doing more work in the essay than an unreplicated *n* = 8 EEG study can bear.

---

## 6 · Compassion, empathy, and whether training works  (note 5.1)

- **Klimecki, Leiberg, Ricard & Singer (2014), "Differential pattern of functional brain plasticity
  after compassion and empathy training", *SCAN* 9(6):873–879.**
  <https://pmc.ncbi.nlm.nih.gov/articles/PMC4040103/> `verified`.
  **This is the paper the essay's Ricard passage should rest on.** Ricard-in-the-scanner is an *n* = 1
  anecdote relayed through Sapolsky's *Behave*; Klimecki et al. is the controlled training study
  (with Ricard as co-author) showing empathy training → negative affect + anterior insula/aMCC,
  compassion training → positive affect + medial OFC/ventral striatum/pregenual ACC.
- **Klimecki, Leiberg, Lamm & Singer (2013), "Functional neural plasticity and associated changes in
  positive affect after compassion training", *Cerebral Cortex* 23(7):1552–1561.**
  <https://academic.oup.com/cercor/article-pdf/23/7/1552/17307245/bhs142.pdf> `browser` (OUP OA;
  403s to scripts).
- **Weng, Fox, Shackman, Davidson et al. (2013), "Compassion training alters altruism and neural
  responses to suffering", *Psychological Science* 24(7):1171–1180.**
  <https://pmc.ncbi.nlm.nih.gov/articles/PMC3713090/> `verified`.
- **Decety & Cowell (2014)** — see cluster 1.
- **Bloom, *Against Empathy*** (2016) — <https://archive.org/details/againstempathyca0000bloo_x1i0>
  `lending`. Cited in note 5.1 only via Sapolsky.

### ▲ Substantive challenge found here — the one the essay most needs
**Kreplin, Farias & Brazil (2018), "The limited prosocial effects of meditation: A systematic review
and meta-analysis", *Scientific Reports* 8:2403.** **OA**
<https://www.nature.com/articles/s41598-018-20299-z.pdf> `verified`.
RCTs of meditation and prosociality: effects appear for compassion and empathy but **not** for
aggression, connectedness or prejudice — and the compassion effect **only** survives under two
conditions: when the meditation teacher was a co-author of the study, and when the control group was
a waitlist rather than an active control. That is a devastating pair of moderators, and it lands
squarely on the essay's claim that "the dharmic move… is the one the brain rewards." The finding does
not overturn the compassion/empathy *dissociation* (a mechanism result), but it does overturn any
inference from it to reliable prosocial behaviour change.

---

## 7 · Oxytocin and "tend-and-defend"  (note 5.1, and the essay's darkest paragraph)

- **Walum et al. (2016)**, **Leng & Ludwig (2016)**, **McCullough et al. (2013)** — Tier 0, item 6.
- **Nave, Camerer & McCullough (2015), "Does Oxytocin Increase Trust in Humans? A Critical Review of
  Research", *PPS* 10(6):772–789** — `walled` (checked via Unpaywall: no OA location).
  Their conclusion is quotable second-hand from the papers above: the simplest promising finding
  "has not replicated well."
- **De Dreu et al. (2010, *Science*; 2011, *PNAS*)** — the essay's source, `walled` at publisher; the
  notes cite the PNAS abstract page.
- **Romano, Gross & De Dreu (2024), "The nasty neighbor effect in humans", *Science Advances*
  10(28):eadm7968.** **OA** <https://www.science.org/doi/pdf/10.1126/sciadv.adm7968> `browser`
  (science.org 403s to scripts; DOI <https://doi.org/10.1126/sciadv.adm7968>).
  ▲ **De Dreu's own laboratory, complicating De Dreu's own slogan.** Across 51 nations, Kenyan
  communities and UK representative samples, people invest *more* in taking from and defending
  against **in-group** members than out-group members or strangers when within-group resources are
  perceived as scarce. "Bonds the in-group and braces it against the stranger, in one chemical
  stroke" is not what the current evidence says the social psychology does, let alone the molecule.
- **Silva & Mace (2014)**, already in note 5.2 [S11] — conflict depressed out-group cooperation but
  left in-group cooperation untouched. Same direction of travel.

---

## 8 · Psychopathy: the missing elephant  (note 5.5)

Note 5.5 is the best-sourced note of the five and says so honestly; what it lacks is **primary
clinical and neuroimaging literature**, which it flags twice. These fill that gap.

### The construct, first-hand (retire the Wikipedia citations)
- **Cleckley, *The Mask of Sanity*, 5th edition (1988)** — the edition the Cleckley estate released
  for free non-commercial distribution. <https://www.cassiopaea.org/cass/sanity_1.PdF> `verified`
  (PDF) · mirror <https://www.quantumfuture.net/store/sanity_1.PdF> `verified`.
  Earlier print editions are `lending` only (<https://archive.org/details/maskofsanityatte0000clec_l3d5>).
  Note 5.5 [S31] currently cites Wikipedia for the sixteen criteria; they are in this file.
- **Hare, *Without Conscience*** (1993/1999) — <https://archive.org/details/withoutconscienc0000hare_q5a0>
  `lending`; a community upload also exists at
  <https://archive.org/details/without-conscience-the-disturbing-world-of-the-psychopaths-among-us-1999-rob>
  `verified` · grey, impermanent. The "intraspecies predators" phrase the essay quotes is currently
  taken from an FBI bulletin quoting the book.
- **Kiehl, *The Psychopath Whisperer*** (2014) — <https://archive.org/details/psychopathwhispe0000kieh> `lending`.

### Neurobiology — primary, and its meta-analytic correction
- **Kiehl & Hoffman (2011), "The Criminal Psychopath: History, Neuroscience, Treatment, and
  Economics", *Jurimetrics* 51:355–397.** <https://pmc.ncbi.nlm.nih.gov/articles/PMC4059069/>
  `verified`. The accessible, free, citable statement of the paralimbic-dysfunction model — a better
  anchor than the 2006 *Psychiatry Research* paper already at note 5.5 [S86], which is `walled`.
- **Blair (2013), "The neurobiology of psychopathic traits in youths", *Nature Reviews Neuroscience*
  14(11):786–799.** <https://pmc.ncbi.nlm.nih.gov/articles/PMC4418507/> `verified`.
  The amygdala/vmPFC (Integrated Emotion Systems) model in the author's own words. Blair (2007,
  *TICS*) is `walled`; this supersedes it.
- **Viding & McCrory (2012), "Genetic and neurocognitive contributions to the development of
  psychopathy", *Dev. Psychopathology* 24(3):969–983.**
  <https://discovery.ucl.ac.uk/1348587/1/download2.pdf> `verified` (UCL Discovery).
- **Viding & McCrory (2018), "Understanding the development of psychopathy: progress and challenges",
  *Psychological Medicine* 48(4):566–577.**
  <https://discovery.ucl.ac.uk/10038988/1/Viding_Understanding_development_psychopathy.pdf>
  `verified`. Callous-unemotional traits, heritability, and — importantly for the essay's determinism
  — the evidence that developmental trajectories are *not* fixed.

### ▲ Substantive challenge found here — the neural story is much weaker than the essay implies
- **Deming & Koenigs (2020), "Functional neural correlates of psychopathy: a meta-analysis of MRI
  data", *Translational Psychiatry* 10:133.** **OA**
  <https://www.nature.com/articles/s41398-020-0816-8.pdf> `verified`.
  A formal meta-analysis of task-fMRI studies of psychopathy finding **no consistent, replicable
  regional signature** — including for the amygdala results the corpus (via Sapolsky and Wrangham)
  treats as established.
- **Poeppl, Donges, Mokros, Eickhoff et al. (2019), "A view behind the mask of sanity: meta-analysis
  of aberrant brain activity in psychopathy", *Molecular Psychiatry* 24:463–470.**
  <https://pmc.ncbi.nlm.nih.gov/articles/PMC6344321/> `verified`.
  Finds convergence, but on a *different and broader* network (prefrontal, insula, temporal) than the
  simple low-amygdala story — and reports that findings vary with task class.
  Together these two mean the essay's "the moral taste buds barely flare… guilt and fear running low"
  can stand as a *psychological* description but should not be given a confident neural mechanism.

### The construct's critics
- **Skeem & Cooke (2010), "Is criminal behavior a central component of psychopathy? Conceptual
  directions for resolving the debate", *Psychological Assessment* 22(2):433–445.**
  <http://cda.psych.uiuc.edu/multivariate_fall_2010/skeem_original.pdf> `verified` · course-server
  copy, grey. The PCL-R circularity objection: criminality is a *correlate*, not a component, and
  building it into the instrument guarantees the finding that psychopaths offend.
- **Skeem & Cooke (2010), "One measure does not a construct make: Directions toward reinvigorating
  psychopathy research — reply to Hare and Neumann", *Psychological Assessment* 22(2):455–459.**
  <http://cda.psych.uiuc.edu/multivariate_fall_2010/skeem_response.pdf> `verified` · grey.
- **Hare & Neumann (2010), "The role of antisociality in the psychopathy construct: Comment on Skeem
  and Cooke", *Psychological Assessment* 22(2):446–454** — `walled`. The other half of the exchange;
  cite from the reply until obtained.
- **Skeem, Polaschek, Patrick & Lilienfeld (2011), "Psychopathic Personality: Bridging the Gap Between
  Scientific Evidence and Public Policy", *PPS* 12(3):95–162** — `walled` (no OA location).
  The best single overview of the whole construct debate; worth a manual attempt.
- **Jalava, Griffiths & Maraun, *The Myth of the Born Criminal*** (2015) — `walled` as at note 5.5 [S49].

---

## 9 · Evolutionary background: costly signalling, CREDs, parochial altruism  (note 5.2)

This note was substantially repaired in the 2026 corpus expansion and is the least urgent. Remaining
external gaps:

- **Sosis & Bressler (2003), "Cooperation and Commune Longevity", *Cross-Cultural Research*
  37(2):211–239** (correct DOI: `10.1177/1069397103037002003`) — `walled`; Unpaywall reports no OA
  location. The 25-vs-5-years figure the essay's forward-links depend on is therefore still
  landing-page sourced.
- **Henrich (2009), CREDs, *EHB* 30(4):244–260** — `walled`; note 5.2 [S7] is abstract-only. The
  Mentawai field test (Singh & Henrich 2020) is already corpus-internal and carries the claim.
- **Choi & Bowles (2007), *Science* 318:636–640** — `walled`; abstract-only at note 5.2 [S8]. The
  counter-evidence (Silva & Mace; Rusch) is already corpus-internal, and now also **Romano, Gross &
  De Dreu (2024)** above.

---

## Recommended acquisition order

1. **Tier 0 in full** (Van Dam, Kral 2022, Royzman, Curry MAC-Q, Konvalinka + Rybanska, the oxytocin
   trio). This alone retires two Wikipedia citations, one YouTube transcript, one blog post and three
   abstract-only references, and puts the essay's two most vulnerable claims on honest footing.
2. **Goyal 2014 + Kreplin 2018 + Farias 2020 + Coronado-Montoya 2016.** The four papers that decide
   whether the essay's "real but routinely oversold" is a stance or a sourced judgement.
3. **Kiehl & Hoffman + Blair 2013 + Viding & McCrory ×2 + Deming & Koenigs + Poeppl.** Fills the
   confirmed primary-literature gap note 5.5 declares, and corrects the amygdala story.
4. **Haidt 2001 + Graham et al. 2013 + Atari 2023 + Zakharin & Bates + Gray purity + Fitouchi.**
   Puts the moral-foundations material on primary sources *and* on its current contested footing.
5. **Cleckley (free 5th ed.) + Skeem & Cooke ×2.** Retires Wikipedia from the psychopathy construct
   and supplies the PCL-R circularity critique first-hand.
6. **Durkheim (PD) + Whitehouse & Lanman + Pizarro CE meta + Rennung & Göritz + Kapitány/Legare.**
   Ritual section: primary sources plus the replication weather.
7. **Bullock thesis** (retry when Kingston's server responds) for the Sunday Assembly paragraph.

## Claims that should be softened or footnoted regardless of acquisition

- **"Meditation reliably changes how the brain functions."** Goyal 2014 found **no evidence** that
  meditation programmes beat *active* controls on any outcome; Coronado-Montoya documents publication
  bias in the same literature. "Reliably" should become something like "on the better-controlled
  evidence, modestly, mainly for attention and stress."
- **The gamma-synchrony opener.** *n* = 8, cross-sectional, unreplicated, and in the one EEG band
  most vulnerable to cranial-muscle artifact (Hipp & Siegel 2013). Keep it as a striking finding;
  do not let it carry the paragraph's weight.
- **The Ricard compassion/empathy passage.** It is a single-subject anecdote relayed through a trade
  book. The generalisable version (Klimecki et al. 2013/2014) exists and should be cited instead —
  and even then, **Kreplin et al. 2018** shows the prosocial pay-off vanishes with an active control
  or an independent teacher.
- **"Oxytocin… bonds the in-group and braces it against the stranger, in one chemical stroke."**
  This is the weakest load-bearing claim in Part 5. The intranasal literature is underpowered and
  poorly validated (Walum; Leng & Ludwig; McCullough), trust effects have not replicated (Nave), and
  De Dreu's own 2024 work finds people are *nastier* to in-group members under scarcity. At minimum
  the sentence needs a hedge; ideally the paragraph makes the fence-argument from the behavioural
  evidence (parochial altruism, Choi & Bowles, Silva & Mace) and drops the molecule as its warrant.
- **"The rider's real job is to come up with a respectable reason after the fact."** Royzman 2015
  (dumbfounding ≈ 0), Stanley 2019, and Landy & Goodwin 2015 (incidental disgust barely moves moral
  judgement) make the strong form contested. "Much of the time" is defensible; "almost backwards" is
  not, and Haidt's own 2001 paper is more hedged than the slogan.
- **The six moral foundations as settled architecture.** The MFQ's factor structure does not fit
  (Zakharin & Bates), purity lacks construct validity (Gray et al. 2022), MAC outperforms MFT on a
  head-to-head (Curry et al. 2019), and MFT's authors have re-specified the foundations (Atari et al.
  2023). The essay can keep the *cuisine* metaphor while dropping the confident list.
- **"Gilligan landed the hardest blow."** Meta-analysis finds gender differences in moral orientation
  are small and dilemma-dependent (Jaffee & Hyde 2000, `walled`). Note 5.3 already concedes this; the
  essay should carry the concession.
- **The "ritual stance" result.** One three-month intervention (Rybanska et al. 2017), with a null
  from a related cross-cultural design (Kapitány, Davis & Legare 2018) and the authors themselves
  calling for preregistered replication. Present it as promising, not as demonstrated.
- **Psychopathy's neural signature.** "The moral taste buds barely flare" is fine as psychology; the
  amygdala mechanism behind it does not survive meta-analysis (Deming & Koenigs 2020). The essay
  wisely never states the mechanism outright — note 5.5 should record why it must not.
- **Meditation's harms are absent from the essay entirely.** Farias 2020 (8.3% adverse events),
  Britton 2021, Schlosser 2019 (25.6%). An essay whose stated posture is "real but routinely oversold"
  is weaker, not stronger, for leaving this out.

## Verification tally (2026-07-28)

**~80 items assessed** (HTTP-checked, or checked for an open-access location through the Unpaywall
and Europe PMC APIs where no candidate URL existed).

- `verified` — live full text retrieved by a scripted fetch today: **45**.
- `browser` — genuinely open access but bot-blocked to scripted requests, one click in a normal
  browser: **14** (Rybanska/Wiley, Farias/Wiley, Xygalatas 2011/T&F, Klimecki 2013/OUP,
  McCullough 2013/eScholarship, Gray *Purity*/SAGE, Schein & Gray author copy, Romano 2024/science.org,
  Van Dam publisher PDF/RUG, Haidt & Joseph/MIT Press, Atari MFQ-2 preprint/OSF, Xygalatas 2023
  preprint/OSF, Whitehouse & Lanman/Chicago, Bullock thesis/Kingston — the last unreachable from this
  network today, retry).
- `lending` — archive.org borrow required: **6** (Hare *Without Conscience*, Kiehl *Psychopath
  Whisperer*, Whitehouse *Modes of Religiosity*, Gilligan *In a Different Voice*, Cleckley print
  editions, Bloom *Against Empathy*).
- `walled` — no free copy found: **15** (Sosis & Bressler 2003, Henrich 2009 CREDs, Choi & Bowles 2007,
  De Dreu 2010/2011, Nave et al. 2015, Skeem et al. 2011, Hare & Neumann 2010, Jaffee & Hyde 2000,
  Snarey 1985, Fox et al. 2014, Legare & Souza 2012, Blair 2007, Kiehl 2006, Whitehouse *The Ritual
  Animal*, Xygalatas 2013 *Psychological Science*).

Grey items (course servers, community uploads: Haidt 2001/protevi, Graham 2013/UCI, Skeem ×2/UIUC,
Hare/archive.org opensource, Cleckley/cassiopaea) are **reading copies only** — summarise, do not
redistribute.

#fin
