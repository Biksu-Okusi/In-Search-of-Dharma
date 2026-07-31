# Citation-support sweep — 31 July 2026

> **STATUS: COMPLETE.** All 58 findings worked. Zero rejected on verification — every finding
> checked out as a real defect. Final state: 61/61 notes carry no undefined `[S#]`, no duplicate
> entries; frontmatter intact everywhere; 36 tracked files changed (+361/−185), plus four
> gitignored `0-preface/` notes. Sections below are retained as the record of what was found.
>
> **Four things the fixing turned up that the audit had missed:**
> 1. `3.3` was **silently repairing a corrupt source and quoting the repair** — the corpus text of
>    BGE §186 reads "they wanted to GIVE A BASIC to morality". Sibling `3.4` was right to refuse
>    the quotation. Both notes now paraphrase and describe the file identically.
> 2. `7.3`'s "the corpus puts the question in exactly these terms" was **the author quoting his own
>    FAQ text** held inside the shared corpus — self-citation reading as external corroboration.
>    Now registered as [S22] with a ▲ marking it project-internal.
> 3. `7.7`'s April-1921 congress date is a **source error, not a note error**: the Goldman–Berkman
>    letter itself says April. Now attributed to the letter with the congress record (8–16 March)
>    flagged alongside.
> 4. Two claims were **weaker than the notes stated, in the notes' favour**: the 2012 Cochrane
>    review found *no eligible trials at all* (an evidential blank, not a tested null), and
>    Rybanska et al. found ritual cues *amplified* an intervention effect rather than producing it.
>
> **Left open by design** (recorded, not silently resolved): `2.2`'s secularisation-with-prosperity
> step now stands as flagged *unsourced inference* pending Norris & Inglehart; `0.2` holds Ward and
> Prichard at bibliographic level only, so Stage 2 **cannot quote either**; `8.2`'s moral-Turing-test
> claim names no study until Dillon et al. is acquired; `7.3`'s pastoral-power reading stays a
> placeholder until "Omnes et Singulatim" is retrieved.

Scope: all 61 research notes (~13,800 lines) across `0-preface/` … `8-future/`, plus a
mechanical pass over the whole `[S#]` apparatus. Prompted by the Fehr & Gächter /
Fehr & Fischbacher defect found in `2.3-pre-axial-ethics.md` while editing Part 2.

**58 findings.** ✓ = I verified the cited file/line myself. Others are auditor-reported,
pattern-consistent with the verified ones, and not yet independently checked.

---

## Apparatus integrity: good

- **No undefined `[S#]` anywhere in 61 notes.** Every inline ref resolves to an entry.
- No duplicate entry numbers.
- Only two defined-but-uncited entries (below).

The bookkeeping is sound. **Every defect below is claim-to-source fidelity**, not clerical.

---

## Tier 1 — the source contradicts, or cannot support, the claim pinned to it

1. ✓ **`7-critical/7.3-dharma-and-power.md:110`** — the whole pastoral-power passage is
   tagged **[S9]** = *Discipline and Punish*, whose own entry states the word "pastoral"
   **does not occur once** in that book, "verified by full-text search." [S21], created for
   pastoral power and marked "not held; browser-only", is **never cited**. The confessional /
   spiritual-director / meditation-hall application all rests on this.

2. ✓ **`2-historical/2.1-axial-age.md:113`** — cites the moralizing-gods result as
   corroboration for Baumard. That is Whitehouse et al. 2019 *Nature*, **retracted 7 July 2021**
   (Beheim et al.: 61% of observations were missing values recoded as known absences; under
   standard imputation the result reverses). `1.2` records the retraction; **`2.2:136` states the
   project's own rule — "Stage 2 must not cite the 2019 Letter in either direction."** The note
   breaks a rule the project wrote for itself.

3. ✓ **`5-psychological/5.4.1-alexander-technique.md:55`** — four verbatim quotations
   ("postural core", "axial line", "centrates and stabilizes…", "prosociality begins within")
   carry **no `[S#]` at all**. Violates the per-claim rule outright.

4. **`3-philosophical/3.4-relativism-universalism.md:89`** — five wording-level Gita quotations
   (5.18, 9.29, 9.32, 4.13, 18.41–48) drawn from a translation whose own [S9] entry says
   "*unverified*… no wording quoted" and whose ▲ says it "supports no wording-level claim."
   The quoted "untouchable person" at 9.32 is precisely the translation-sensitive rendering
   the caveat exists to block.

5. **`3-philosophical/3.5-sumarah/3.5.2-practice-and-transmission.md:146`** — "no fees beyond
   voluntary support" presented as encyclopedic wording from [S6]; [S6] says nothing about fees,
   and sibling `3.5.4:331` states flatly that **no corpus source says Sumarah charges nothing**.

6. ✓ **`2-historical/2.4-transmission-institutionalization.md:362`** — the note's own provenance
   audit discloses **two** metadata-only book citations; the Sources list carries **six** explicit
   "consulted at metadata/preview/abstract level" flags (S10, S12, S14, S15, S17, + S11/S16).
   A self-disclosure that understates itself is worse than none.

7. ✓ **`1-foundational/1.1-etymology.md:125`** — Curry's seven rules stated flat: "not a single
   counter-example was found." `1.2` reads the *same paper* with three qualifications: average
   **4.4 of 7** per society, fairness in only 9/60, coder agreement **κ = 0.14, "poor"** for fairness.
   **This is the upstream source of the defect I already fixed in Parts 1 and 2.** The essays are
   now more careful than the note that seeds them.

---

## Tier 2 — attribution wrong

8. ✓ **`0-preface/0.5:39`** — "'structural violence' being **Graeber's own term**." It is
   **Johan Galtung's** (1969). The note leans on the shared phrase as "the strongest textual proof"
   of a Batchelor–Graeber convergence; shared inherited vocabulary cannot bear that weight.
9. **`3-philosophical/3.1:54`** — "Rawls's 'unencumbered self'." That is **Sandel's** polemical
   characterisation of Rawls, not Rawls's self-description. The critic's coinage handed to the target.
10. **`7-critical/7.7:199`** — Tenth Party Congress dated **April 1921**; RCP(b) Tenth Congress sat
    **8–16 March 1921**. Error sits in both body and [S15].
11. **`8-future/8.2:109`** — "UNESCO's Recommendation (2021) **binds** 194 states." A Recommendation
    is non-binding by definition; adopted Nov 2021 by 193 member states. Both verb and number wrong.
12. **`6-contemporary/6.5:127`** — a forward projection attributed to Pew's Religious Landscape Study,
    which reports a **plateau** and makes no projection; the projection is Pew's 2022 *Modeling the
    Future of Religion in America*.
13. **`5-psychological/5.1:81`** — Hölzel 2011 credited with the amygdala/perceived-stress
    correlation; that is Hölzel et al. **2010** (*SCAN* 5:11–17). Two papers merged into one citation.
14. **`5.6-neurodivergence/5.6.1-autism.md:45`** — "9.8% of 5,400 parents" attributed to Howlin 2009
    (N≈137, ~28% meeting criteria); the figure is **Rimland 1978**, usually relayed via Treffert.
15. **`2-historical/2.2:90`** — Botero et al. 2014 reported as tracking societies *becoming* less
    religious over time; it is a **cross-sectional** analysis of ~583 traditional societies correlating
    moralizing gods with environmental duress. A temporal/causal argument built on a correlation.
16. **`2-historical/2.1:69`** — "theoretic culture" cited to Bellah, *The Axial Age and Its
    Consequences* (2012), an **edited volume** (Bellah & Joas); the concept is developed in
    *Religion in Human Evolution* (2011), which `2.5` cites correctly.
17. **`3-philosophical/3.4:201`** — "confines two *varṇas* to service (18.44)"; 18.44 gives the
    vaiśya husbandry and trade, only the śūdra service.
18. **`4-cultural/4.2:40`** — "I am because we are" attributed to **Mbiti**; neither cited entry
    mentions him.
19. **`3-philosophical/3.1:65`** — quotes "for Homo economicus rather than Homo sapiens"; the source
    entry records the **reverse** wording. Sense preserved, quotation not.

---

## Tier 3 — second-hand presented as primary (the largest cluster)

20. **`5.4-ritual-habituation.md:84`** — Whitehouse ritual-stance experiments cited via a
    prosocial.world blog post + a Henrich footnote, then **reclassified at line 128 as
    "genuine fieldwork."** Primary is Rybanska, McKay, Jong & Whitehouse, *Child Development* 89(2), 2018.
21. **`4-cultural/4.5:53`** — Geels's monograph **quoted verbatim** while its entry says
    metadata/abstract-only.
22. **`8-future/8.2:79`** — Allen, Varner & Zinser (2000) quoted directly; sole source is a
    corpus **interview with Wallach** reporting the point.
23. **`7-critical/7.2:50`** — Said quoted; the wording is a *Conversation* explainer's paraphrase.
    `7.5` [S11] holds page-anchored Said.
24. **`5.4.1:43`** — 2012 Cochrane asthma review presented as consulted; sourced to Wikipedia.
25. **`3-philosophical/3.3:160`** — Anscombe's 1958 law-conception argument attributed to an entry
    covering only Euthyphro/DCT encyclopedia articles. Anscombe is nowhere in the Sources list.
26. **`1.3-boundary-definition.md:117`** — Shweder, Fessler and Barrett given with dates as direct
    findings; they reach the note through a blog post's reference list.
27. **`0-preface/0.5:41`** — Kropotkin stated as read in primary form; all pointers are
    intermediaries (Wikipedia, Graeber/Grubačić introduction, Wilson).
28. **`0-preface/0.2:41,43,28`** — Ward "upgraded to a primary citation" but still via Wikipedia;
    Prichard "cited directly" via a **Routledge catalogue page**; Freedom Collective detail taken from
    a search-index summary after direct fetch failed on an expired TLS certificate.
29. **`3.5.2:42`** — a SubudVision page presented as the rare **non-Stange** witness; its own entry
    says it cites Stange 1980.
30. **`4.6-badui:29`** — an unnamed "Indonesian study" quoted; only source is a Wikipedia article.
31. **`0.6:65`** — Gonda and de Casparis cited with no access-level flag, paired with a Wikipedia
    entry that is explicitly derivative of de Casparis.

---

## Tier 4 — quantifiers, figures and hedges lost in transit

32. ✓ **`0-preface/0.2:26`** — "**Each element** of that arc matches the externally checked record."
    `7.6:174` rates the Greens terminus **"◐ half right"** (no organisational merger; ex-member
    migration is the real part). Mitigating: the parenthetical already says "dissolution-and-migration."
    Fix the quantifier only. ⚠ **Register constraint: the CPA years are told with pride of provenance,
    never as recantation. Do not touch the tone.**
33. ✓ **`0-preface/0.7:37`** — the "tiny sangha" listed as **four** people including Julie Chamorel;
    `0.3:15` and the author's own words at `0.3:21` ("comprises myself Elfie, and Rupert") make it
    **three**. ⚠ Concerns real named private individuals.
34. **`1.2:32`** — "no society that reversed its seven rules"; the note's own line 85 records
    **one** negative — a Chuuk report that open theft is admired.
35. **`0.5:45`** — "**all** show reverse dominance"; quantifier absent from the entry, and the LPA
    coding is *Moral Origins* (2012), not *Hierarchy in the Forest* (1999).
36. **`0.5:47`** — "among foragers mothers do only about half of direct childcare"; Hrdy's figure is
    from specific cases (Efé, Aka), and no cited entry supplies the statistic.
37. **`1.4:69`** — Premnath's Ṛta/Ma'at comparison silently extended to a **third** concept, asha.
38. **`4.3:81`** — the Urubu chief's "fewest possessions… shabbiest ornaments" generalised to
    "the forest chief" of lowland South America.
39. **`4.2:40`** — two maxims in two language groups generalised to "**pan-Southern-African**."
40. **`4.6-badui:39,23,33`** — ~9,000 phone numbers re-dated from a 2018 census base to 2023;
    Seba upper bound given as 1,552 where the only source says 1,580; a one-way 60 km figure
    irreconcilable with the entry's 160–200 km.
41. **`4.1-samin:40,201`** — "born in 1859" where the source says "**probably** in 1859"; one Blora
    village study with an explicit "at a certain level" hedge reported as the finding of
    "modern Indonesian scholarship" generally.
42. **`3.5.4:129`** — "roughly ninety per cent… Muslims" from a source the note itself marks
    "**figures unreliable**."
43. **`8.2:145`** — three targeted **pilots** (Finland: unemployed only; SEED: 125 recipients;
    GiveDirectly) upgraded to an "empirical record" that "**rebuts**" the idleness objection.
44. **`7.3:154`** — Parker's *Basic Bakunin*, a movement pamphlet whose entry says "**not for its
    verdicts**", upgraded to "standardly read as the confirmation."
45. **`3.5-sumarah:33`** — "contesting… every membership figure" cited to three entries, none of
    which addresses membership numbers; one is an unretrieved catalogue record.
46. **`3.5.3:80`** — "ten of the twelve KB sources are his"; eleven of twelve are Stange, since the
    "encyclopedia entries" counted as non-Stange are Stange's own. A monoculture disclosure that
    understates the monoculture.
47. **`7.1:233`** — Rusch's war-conflict finding hangs off [S11] Silva & Mace, who did not conduct it.
    Rusch is properly registered in `5.2` as [S18].
48. **`7.3:125`** — three verbatim quotations ("Daring to define. By whose right?") attributed to
    "the corpus" but tagged **[A]** = the author's own analysis. Phrase occurs nowhere in the DD tree.
49. **`8.4:71`** — a quotation explicitly attributed to Delphi's *critics* hung on the ref that
    defines Delphi's own paper (Jiang et al.).
50. **`3.3:82`** — quotes verbatim the exact BGE §186 clause that `3.4:244` records as
    **textually corrupt** in the KB file and says must never be quoted.
51. **`2.5:85`** — Gould & Lewontin's *Spandrels* (about organismal traits) transposed without flag
    to the extinction of cultural traditions.

---

## Two gathered-but-unused counterweights

- ✓ **`5.1-neurological-basis.md` [S14]** — Britton on the **adverse effects** of mindfulness.
  Defined, never cited.
- ✓ **`7.3-dharma-and-power.md` [S21]** — Foucault, pastoral power. Defined, never cited
  (see Tier 1 #1).

In both cases the unused source is the note's critical counterweight. Gathered, then silent.

---

## Essay-level (outside the note tree)

✓ **`1-defining-dharma.md:52`** — Tinbergen's function/mechanism split and D.S. Wilson's
application carry the book's "one job, many tools" resolution. **Neither appears in that essay's
Key works.** Sole support is note `1.2` [S4], a **prosocial.world blog post**; Tinbergen's own
work is not held.

---

## Three cross-cutting patterns

**A. Sibling-note divergence.** The same source is read strictly in one note and loosely in another:
Curry (`1.1` flat vs `1.2` qualified), Nietzsche BGE §186 (`3.3` quotes what `3.4` says is corrupt),
Parker (`7.3` verdict vs `7.6` attributed), Bellah (`2.1` wrong volume vs `2.5` right one).
**The careful reading usually already exists somewhere in the tree.** Most fixes are propagation,
not research.

**B. The critic's coinage handed to the target.** Galtung→Graeber, Sandel→Rawls. Both times a
term of art is credited to the person it was aimed at.

**C. The caveat that stays in the Sources list.** By far the commonest failure: the `[S#]` entry
carries an honest flag — *metadata-only*, *figures unreliable*, *not for its verdicts*, *supports no
wording-level claim*, *access via search index* — and the body then states the claim flat. **The
apparatus is more honest than the prose it supports.** That is the systemic finding, and the Fehr
defect was one instance of it.

---

## Suggested order of work

1. **Tier 1** (7 items) — a source that contradicts its claim is the only class that misleads
   Stage 2 outright. #2 (retracted paper) and #1 (Foucault) first.
2. **Pattern C sweep** — mechanical and high-yield: for every `[S#]` entry carrying a caveat,
   check whether the body carries it too.
3. **Tier 2** (12 items) — attribution errors; each is a one-line fix.
4. **Tier 3/4** — hedges and figures; largely propagation from the careful sibling note.
5. **Essay-level** — decide whether to source Tinbergen/Wilson properly or soften the attribution.

Two items need the author's judgement, not mine: **#33** (sangha membership — real named private
individuals) and **#32** (CPA arc — register constraint).

---

## Addendum, 2026-07-31 — the sweep's blind spot: essays carry pre-sweep claims

The sweep audited the 61 research notes and left the essays alone. Part 5's review turned up the
consequence, and it is a class, not an instance.

`5-under-your-skin.md` stated that "simply getting children to adopt … a 'ritual stance' measurably
improved their self-control and their ability to delay gratification" — the *pre-sweep* reading of
the claim. Note `5.4-ritual-habituation.md` had been corrected the same day: the new primary
`[S10]` (Rybanska, McKay, Jong & Whitehouse 2018, *Child Development* 89(2):349–359) reports a
three-month intervention that raised executive function and, through it, delay of gratification,
with ritual cues **amplifying** the effect. A moderator had been written up as a main effect. The
essay's Sources list also credited the stance to Whitehouse, where he is fourth author. Both fixed.

▲ **Every note the sweep changed may have an essay downstream still quoting the uncorrected
version.** Notes are the source of truth; the essays were drafted from them *before* correction.
The check is cheap and should run per essay as each is reviewed: for every note in the essay's
`draws_on:` list, diff the note's corrected claims against the essay's prose and its Sources list.
Parts 1, 2, 3, 4 and 5 are done — Part 4 produced one hit (the 1965 death toll, essay 3× the notes' figure; fixed to the 500K–1M scholarly range with a suppression footnote, 2026-07-31). Part 6 checked 2026-07-31, two hits (Foucault pastoral-power placeholder stated as established; moral-licensing scale-up stated as finding), both fixed, plus a Bukharin-via-Berkman provenance disclosure. Part 7 checked 2026-07-31, no hits — the essay already conformed to every sweep correction in its nine draws_on notes (nones plateau, Asad paraphrase, no Nietzsche wording, Sandel-Rawls dodge, no flagged Sumarah material); one minor precision fix applied (Purser "made stick" rather than implied coinage of McMindfulness). Part 8 checked 2026-07-31, one hit: "nine Sikep women" at the palace gate, where note 4.1 says "nine women farmers, incl. Sukinah" and Part 3 was already calibrated to the coalition reading — fixed to "nine women of the Kendeng farming communities, Sikep among them." Clean otherwise (no Gita wording, no moral-Turing-test claim, Delphi as paraphrase, no April 1921). All eight essays checked. The coda was reviewed and revised 2026-07-31 (normative "holds without crushing" test restored, non-privileging stance disclosed rather than installed, personal-dharma isolation guard added); it introduces no new claims, so no propagation check was needed. The preface was reviewed and revised 2026-07-31 (definition aligned with Part 8 — no more "built from scratch"; the RAG overclaims "does not get to make things up" and "it decided nothing" replaced with honest versions consistent with the Part 8 mirror section; audiobook link moved to the cover copyright page). The review-and-check cycle over the whole book — cover, preface, eight essays, coda — is complete.
