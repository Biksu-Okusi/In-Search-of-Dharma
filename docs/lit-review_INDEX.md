# Literature review — series index and cross-part corrections ledger

**Date:** 2026-07-28 · **Scope:** all eight Parts of *In Search of Dharma* and the research notes
behind them.

Part 1 was reviewed, acquired and staged in an earlier pass. Parts 2–8 were reviewed in a single
parallel pass on the same template: audit every source behind the essay and its notes, flag the
ones that are tertiary, abstract-only or unverified, then find downloadable full text and
link-verify it.

| Part | Review | Notes audited | Sources audited | verified / browser / lending / walled | Acquired |
|---|---|---|---|---|---|
| 1 · Defining Dharma | [lit-review_1](lit-review_1-defining-dharma.md) | 1.1–1.4, 3.3, 3.4 | ~50 | (earlier pass) | 93 files · 921 MB |
| 2 · The Genesis of Dharmas | [lit-review_2](lit-review_2-birth-of-dharma.md) | 2.1–2.5 | 92 | 50 / 18 / 9 / 10 | 66 files · 224 MB |
| 3 · The Samin of Java | [lit-review_3](lit-review_3-samin-of-java.md) | 4.1 | ~55 | 33 / 11 / 6 / 4 | 33 files · 190 MB |
| 4 · A World of Dharmas | [lit-review_4](lit-review_4-world-of-dharmas.md) | 4.2–4.5, 3.5 cluster | ~78 | 41 / 6 / 16 / 15 | 59 files · 250 MB |
| 5 · Under Your Skin | [lit-review_5](lit-review_5-under-your-skin.md) | 5.1–5.5 | ~80 | 45 / 14 / 6 / 15 | 58 files · 91 MB |
| 6 · When Dharmas Go Wrong | [lit-review_6](lit-review_6-when-dharma-goes-wrong.md) | 7.1–7.3, 7.6, 7.7, 6.3, 6.4 | 58 | 31 / 9 / 17 / 13 | 56 files · 429 MB |
| 7 · Dharmas in a Secular Age | [lit-review_7](lit-review_7-secular-age.md) | 6.1, 6.2, 6.5, 3.1 | ~70 | 33 / 11 / 9 / 17 | 33 files · 46 MB |
| 8 · Creating Dharmas | [lit-review_8](lit-review_8-creating-dharmas.md) | 8.1–8.5, 7.4, 7.5 | ~89 | 53 / 11 / 14 / 11 | 62 files · 94 MB |

Access flags mean the same thing in every review: `verified` = full text retrieved by script;
`browser` = genuinely open access but bot-blocked to scripted fetches; `lending` = archive.org
borrow required; `walled` = no free copy found.

**Archive total: 460 files, 348 PDFs, 2.2 GB, 0 corrupt** — in `scratch/sources/partN/`, gitignored,
each with its own `README.md` inventory recording per-file provenance and licence status. Every PDF
was verified by magic bytes plus a `pdfinfo` page count *and* a `pdftotext` character count, because
a page count alone does not prove a file is readable: three image-only scans in the Part 2 set
parsed perfectly and yielded no text, and were replaced with OCR derivatives.

---

## What the pass found, in one paragraph

The accusations in this book are better sourced than its analytical frame. Where an essay names a
scandal, an atrocity or a statistic, there is usually a real source behind it. Where an essay
states the *mechanism* — why rituals install beliefs, why power reproduces itself, why the Axial
Age happened — the citation is very often a Wikipedia article, a blog post, a YouTube transcript
or a publisher's abstract. Five of the seven reviews independently found a **YouTube transcript
carrying a load-bearing opening move**. That is the single most repeated structural weakness in
the series, and it is concentrated in exactly the sentences a hostile reader would attack first.

## The stance held

Nothing in this pass threatens the book's category. *Dharma* is a placeholder for a cross-cultural
concept-family, so word-history and period-history findings are **specimen study**: Mullins et al.
can dissolve the Axial Age window entirely and the essay loses a rhetorical hook, not an argument.
The same applies to Gade's redating of the ubuntu proverb and to Wolfe on the colonial manufacture
of "the Dreamtime" — in each case the *label* turns out to be younger and more constructed than the
essay implies, while the underlying function is untouched. That is the placeholder reading working
as designed.

---

## Cross-part corrections ledger

Ordered by severity. Each item names the claim, what the literature actually says, and where the
fix lives. **Tiers A and B have now been worked** (2026-07-28); each item carries its outcome inline.
Tier C remains open. Every finding was re-verified against the acquired full text before any edit,
and four of the reviews' charges did not survive that check — those corrections are recorded in place.

### Tier A — claims that are wrong as stated  ✓ **all five worked, 2026-07-28**

> Each was re-verified against the acquired full text before editing, and one review finding did not
> survive that check (see item 2). Files touched: notes 1.2, 2.2, 4.1, 5.1, 5.3 and essay Part 5.
> No claim was removed without recording what replaced it.

1. **The moralizing-gods finding (note 2.2, essay Part 2).** Whitehouse et al. (2019) was
   **retracted by *Nature* in 2021**. Beheim et al. showed that 61% of the moralizing-gods data
   points were missing values re-coded as known absences; under standard imputation the sign
   reverses. The note's "main finding largely upheld" is the retracted authors' own
   characterisation of their own retraction. The 2022 reworking attributes both variables to
   warfare and agricultural productivity instead. → review 2, Tier 0 #1.

   ✓ **Done.** Retraction note and Beheim preprint read in full; both quoted verbatim in the note.
   Note 2.2's bullet is rebuilt around a dated correction block carrying the exact figures (61%,
   n = 490, r = 0.97), the fact that "main finding largely upheld" was the retracting authors' own
   phrase, and that three co-authors refused to sign. New sources [S8]–[S10]. The note's surviving
   conclusion — moralizing religion as one tool among several — now rests on the correlational
   evidence alone, with an explicit instruction that Stage 2 cite the 2019 Letter in **neither**
   direction. Note 1.2 carried the same neutral gloss and was corrected to match; its "moralising
   gods are late" claim was already independent of the exchange, so it stands.

2. **Note 4.1's marriage-practices citation (Part 3).** "Rumours and Realities of Marriage
   Practices in Contemporary Samin Society" is by **Arif Rohman** (*Humaniora* 22(2)), not
   Amrih Widodo. → review 3, Tier 0 #3.

   ✓ **Done — and the review's second charge did not survive verification.** The misattribution is
   real, and confirmed two independent ways: the Al-Ihkam article's own footnote 30 cites Rohman,
   and the OpenAlex record lists him as sole author. But the review also claimed Rohman's finding
   "contradicts the subordinate gender claim the note attaches to it," and that is wrong twice over.
   The "subordinate" wording is sourced to a *different* work in the same bundled citation — Mukodi
   & Burhanuddin's *Al-Tahrir* 15(2) (2015) study, since **read in full**, which supports it in its
   own fieldwork context. And Rohman's article is a *rumour-refutation* piece examining whether
   "virginity tests" and "stray marriages" occur, i.e. it addresses slander directed **at** the
   community, not internal gender hierarchy. [S14] is now split into four separately attributed
   works, two read in full, with both corrections recorded on the face of the note.

3. **Oxytocin "tend-and-defend" (note 5.1, essay Part 5).** The intranasal literature is
   underpowered and poorly validated, and **De Dreu's own 2024 *Science Advances* paper** finds
   people compete *more* with in-group members under scarcity. → review 5, Tier 0 #6.

   ✓ **Done.** Three papers read in full and quoted: Leng & Ludwig on the delivery problem (little
   intranasal oxytocin reaches the brain; peripheral levels driven supraphysiological), Walum,
   Waldman & Young on power ("generally underpowered," median d = 0.28), and Romano, Gross & De Dreu
   on the nasty-neighbour effect across 51 nations. Note 5.1's claim is downgraded with a dated block
   and sources [S9]–[S11]; the essay paragraph is rewritten as an honest retraction of a line the
   author liked, which suits Part 5's existing self-correction theme. **What survives:** the parochial
   fence, argued behaviourally rather than neurochemically. ▲ The nasty-neighbour result is a *gain* —
   it shows the fence can run inside a group, feeding Part 6's "wolf in the flock." (Nave 2015 was not
   verified and is not cited.)

4. **Moral dumbfounding (essay Part 5).** Royzman, Kim & Leeman (2015) re-ran "Julie and Mark"
   with the confounds removed and the estimate falls to **approximately zero**. → review 5, Tier 0 #3.

   ✓ **Done.** Verified verbatim: the procedure "yielded a dumbfounding estimate of about 0." The
   mechanism matters more than the number and is now recorded — subjects were not reasoning-free,
   they disbelieved the harm-free stipulation and so held "excellent reasons to disapprove." Note 5.3
   carries it at [S17] with the explicit limit that this retires the *vignette*, not intuitionism.

5. **The book contradicts itself between Parts 1 and 5.** Part 1 runs on Curry's
   morality-as-cooperation; Part 5 presents Haidt's moral foundations as settled architecture.
   → review 5, Tier 0 #4.

   ✓ **Done — resolved by disclosure rather than by picking a winner.** Four results verified and
   added to note 5.3 as [S13]–[S16]: Curry's head-to-head ("support the MAC-Q's seven-factor model
   … but not the MFQ's five-factor model"), Zakharin & Bates (no theorised MFQ model fits at
   N = 11,496 — and their repaired model independently lands on **seven** factors, converging with
   MAC), Gray et al. (purity "is not a coherent construct"), and Atari/Haidt/Graham's own
   six-foundation MFQ-2. Essay Part 5 gains two paragraphs naming the tension in the reader's
   hearing and pointing back to Part 1. The reconciliation adopted: foundations as a **vocabulary of
   moral concerns**, MAC as the better-supported **structural** account. Both frameworks assert the
   claim the chapter actually needs — a small shared palette, tuned differently by culture — so the
   argument is undamaged.

### Tier B — claims resting on sources that cannot carry them  ✓ **seven of eight worked, 2026-07-28; item 12 deferred by the author**

> ▲ **Three of this tier's charges did not survive verification, and the corrections are recorded
> in place below.** Item 12 (the CPA note) was left **entirely untouched** at the author's explicit
> instruction: it is his own history, and the sourcing decision is his.

6. **The forest-road catechism that opens Part 3.** Absent from **all three** canonical full texts
   (Benda & Castles 1969, Korver 1976, Shiraishi 1990), confirmed by full-text search. It survives
   only in Indonesian popular sources, in variant forms, and reaches the essay through a translated
   YouTube transcript. A documented substitute exists in Benda & Castles: the interrogation at the
   *patih*'s office, where the answer is "*Wong Sikep* knows no taxes" and the speaker stays calm
   when slapped for it. → review 3, §1.

   ✓ **Done — provenance strengthened, scene kept (author's decision).** The review was right that the
   exchange is absent from all three canonical studies (re-confirmed by full-text search; their "from
   the forest" hits concern teak-cutting). But it missed that the corpus holds a **second, independent
   Indonesian source** which rests on a named book — Anis Sholeh Ba'asin & Muhammad Anis Ba'asin,
   *Samin: Mistisisme Petani di Tengah Pergolakan* (Semarang, prefaced by Gus Mus and Ganjar Pranowo)
   — and through it on a **primary colonial record**: *Het Nieuws van den Dag*, 5 March 1907, on the
   interrogation of the arrested Samin Surosentiko ("My body is my home"). The *patih* slap scene the
   review credited to Benda & Castles is in fact at Ba'asin p. 63. Note 4.1 gains [S15] carrying both,
   and states the honest position: **well attested in Indonesian sources and traceable to a 1907
   record, unattested in the English-language canon** — a gap in that canon as much as in the claim.
   The essay keeps its opening and now says so in its own Sources section.

7. **The No-True-Scotsman refusal that opens Part 6** — the move that licenses the entire
   dark-twin schema — rests on a YouTube transcript. → review 6.

   ✓ **Done — attribution upgraded; substance was never in doubt.** The transcript is **Harvard
   Divinity School's Religious Literacy Project**, presented by the religious-studies scholar Joseph
   Laycock, and "religions are internally diverse" is that programme's published first principle, not
   one commentator's opinion. Note 7.1's [S1] now cites it institutionally. Two honest caveats added:
   the Harvard statement 403s all scripted access and still needs one manual fetch, and the transcript
   file **no longer resolves in the rebuilt corpus** (checked against the 2026-07-27 rebuild), so the
   quoted wording now survives only in the note.

8. **The Foucault paragraph (note 7.3, Part 6)** rests on an anonymous WordPress blog, and is
   actually about **pastoral** power, which does not appear in the one Foucault text that is
   freely available. → review 6, §on power.

   ✓ **Done — and the substitution exposed a real mismatch.** The anonymous WordPress citation is
   retired for Foucault's own text: *Discipline and Punish* is now [S9], anchored on "power produces
   knowledge… there is no power relation without the correlative constitution of a field of knowledge"
   (p. 27, verified in the scan with the folio offset checked). But full-text search confirms
   **"pastoral" occurs zero times** in that book, and the note's paragraph — confessional, spiritual
   director, meditation hall — is a *pastoral*-power argument. New [S21] names the correct source,
   "Omnes et Singulatim" (Tanner Lectures, 1979), flags it as **not held, browser-only**, and marks the
   paragraph under-sourced until it is read. One manual download closes it.

9. **The 'Ata narrative (Part 8, note 8.5)** runs entirely through Bregman's popular synthesis.
   Warner's memoir, Willey, Perry and Hamilton are all walled. → review 8, Tier 0 #1.

   ✓ **Done — though "runs entirely through Bregman" was overstated** (Christakis's *Blueprint* is an
   independent leg). The real gap was the Tongan objection, now added as note 8.5 [S6] and as two new
   paragraphs in the essay: Meleika Gesa (*The Spinoff*, 2021), who names the six men — Tevita Siola'a,
   Sione Fataua, Luke Veikoso, Fatai Latu, Kolo Fekitoa and Sione Totau (Mano) — and argues the famous
   telling "focuses on the white man who rescued them, as interpreted by the white man who 'discovered'
   their story, who compares their journey to a book by a white author," while the 1863 slave raid that
   emptied 'Ata is treated as scenery although its victims' abandoned crops helped keep the boys alive.
   ▲ The objection **strengthens** the finding: what they rebuilt from was not generic goodwill but a
   named dharma, *anga fakatonga*. Also logged: contemporary reporting says the boys were **gaoled** on
   return, so "borrowed a fishing boat" is doing gentle work.

10. **"The economists who saw it coming a decade ago noted the grim joke" (Part 8)** traces to a
    corpus podcast transcript that the note itself flags as speaker-merged. **No economist wrote
    it.** → review 8.

    ✓ **Done.** The essay now attributes the quip to Sam Harris by name and rests the underlying
    reversal on Frey & Osborne, who are already cited in note 8.2 [S15]; the note flags the line as
    "Sam Harris's line, not an economist's." The speaker-merge caveat [S4] already carried stays.

11. **Ubuntu had zero scholarly sources in the register** — one YouTube video and one dead blog,
    for a cluster Part 4 opens on. → review 4, Tier 0 #4–5.

    ▲ **Partly a false alarm — but acted on.** Note 4.2 itself already cited Menkiti (1984), Metz
    (2007), Ramose (1999) and *S v Makwanyane*; the "zero scholarly sources" finding applied to the
    **register**, not the note. `SOURCES.md` now carries four scholarly Ubuntu entries (Metz 2011,
    Gade 2011, Menkiti 1984, *Makwanyane* 1995), and the weak video entry is marked superseded for
    load-bearing use. ▲ One nuance the review flattened: Gade offers the 1993–95 dating as an explicit
    **hypothesis** about the *written* discourse, not as proof about oral tradition — which matters for
    Part 4's "a village proverb became a principle of constitutional law" sentence.

12. **Note 7.6's CPA fact-check runs on five Wikipedia articles.** O'Lincoln's *Into the
    Mainstream* is complete, free and author-permitted at marxists.org. → review 6, Tier 0 #5.

    ⏸ **Deferred — left entirely untouched at the author's instruction (2026-07-28).** This note
    concerns the author's own years in the party; the sourcing decision is his to make, and no edit
    was applied. O'Lincoln's complete text sits in `scratch/sources/part6/8-cpa-history/` whenever he
    wants it.

13. **Durkheim is nowhere in the project** — although *Elementary Forms* carries the argument Part 7
    depends on (belief installed through the "we", not through the referent of belief).
    → review 7, Tier 0 #6.

    ▲ **Overstated, and corrected.** Durkheim was *not* absent — note 5.4 has always cited *Elementary
    Forms* — but it hung off a Wikipedia URL. [S8] now quotes the primary text ("it is in the midst of
    these effervescent social environments and out of this effervescence itself that the religious idea
    seems to be born," Book II ch. 7, p. 214, verified in the acquired public-domain edition). The true
    version of the finding is narrower and is recorded there: he is absent from **all four of Part 7's
    own notes**, which is a real gap for the secular-congregation and grounding material.

### Tier C — claims to soften, and gaps to disclose

14. **Smartphone harm (Part 7).** "No natural defences", "an adversary that gets cleverer every
    quarter" — advocacy-sourced. Orben & Przybylski put the effect at ~0.4% of variance; Odgers &
    Jensen, and Goodyear 2025 on school phone bans, point the same way. The large-average-harm
    question has effectively settled against the essay's rhetoric.

15. **Meditation harms are absent from Part 5 entirely** — Farias 2020 reports 8.3% adverse events,
    Schlosser 2019 reports 25.6%. An essay this careful about overselling benefits should not omit
    the harm literature.

16. **"Reliably changes how the brain functions" (Part 5)** — Goyal et al. 2014 found no evidence
    meditation beats *active* controls on any outcome; Coronado-Montoya documents 108 of 124 trials
    reporting positive results.

17. **The gamma-synchrony opener (Part 5)** — *n* = 8, unreplicated, in the EEG band most
    vulnerable to cranial-muscle artifact.

18. **"A village proverb became a principle of constitutional law" (Part 4)** — Gade shows
    *umuntu ngumuntu ngabantu* was first used to *define* ubuntu in 1993–95, contemporaneous with
    the constitutional moment rather than ancestral to it.

19. **Stoicism's "almost no metaphysical luggage" (Part 4)** — Long, Becker and the SEP hold the
    providence theology load-bearing. Secular Stoicism is a translation-in-transit, structurally
    identical to the Sumarah God-floor the same essay analyses. Review 4 suggests making that
    parallel explicit rather than dropping the claim.

20. **"For the first time" framing (Part 8)** — Whyte's "Our Ancestors' Dystopia Now": the
    apocalypse already happened, to somebody. Treating the present as unprecedented is a settler
    vantage.

21. **"Encode the argument, not the verdict" (Part 8)** — Millière's *Phil Studies* 2025 paper is
    the strongest brake on the essay's own cure: current systems have shallow behavioural
    dispositions rather than deliberative capacity, so this is a far harder target than the
    closing implies.

22. **Kela's basic-income trial (Part 8)** — the actual finding (small employment effects, large
    wellbeing and trust gains) is more interesting than the essay's "largely failed".

23. **Sosis & Bressler 2003 (83 communes)** — religious communes outlasted secular ones at every
    point measured. Note 8.3's worry about secular community deficit may be **structural rather
    than effort-related**, which is a harder and better version of the essay's point.

24. **Parochial altruism (Part 2 close)** — Dyble 2021 (*PNAS*) re-analyses Choi & Bowles and finds
    it does not evolve under realistic population structure, against "two faces of one adaptation".

25. **"The cost is the point" (Part 2)** — Kavanagh et al. 2018 found no pain–cohesion correlation
    in 605 subjects; the 2025 pre-registered Thaipusam study concludes it is estimated *benefits*
    that matter.

26. **The Axial Age window itself (Part 2)** — Mullins et al. 2018 find the Axial traits appearing
    centuries to millennia before the proposed window. Halton 2014 additionally argues
    Stuart-Glennie named the phenomenon in 1873, not Jaspers in 1949.

### Named gaps — no free source found, disclose rather than fudge

- Adams's modified divine command theory, the standard believer's reply to the Euthyphro move
  (Part 7).
- Wolfe's "Dreamtime as colonial construct" critique (Part 4) — walled, and entirely absent from
  note 4.3.
- Ramose's *African Philosophy through Ubuntu* — no legal copy exists. ▲ **The top web hit is a
  confirmed SEO-spam fake PDF. Do not fetch it.**
- Stanner's 1953 "The Dreaming" essay — the circulating grey PDF titled *White Man Got No Dreaming*
  contains only "Continuity and Change" (verified by download).
- Hadiwijono, and Howe's UNC thesis (HathiTrust search-only) — the non-Stange witnesses to Sumarah.
- A full-text critique of Greene's dual-process framing (the Kahane/Berker line).

---

## Operational flags

- ✓ **`freotopia.org` — rescued.** It is the single host of the Paul Stange Sumarah archive the
  Part 4 / 3.5 cluster depends on, and it is unreachable from this network (TCP timeout on both
  http and https). The Internet Archive's crawler could still reach it, so fresh captures were
  forced through the Wayback `/save/` endpoint on 2026-07-28 and retrieved from there.
  **2,008 pages of Stange plus ~58,000 words of HTML chapters are now preserved** independently of
  whether the site ever returns. ▲ The HTML arrived gzip-compressed and stored undecompressed,
  reading as 1.8–2.2 KB binary stubs that looked like failed fetches; check for a `1f8b` magic-byte
  prefix before trusting a small file from this path.
- ✓ **Whyte — TLS resolved without weakening verification.** `kylewhyte.marcom.cal.msu.edu` presents
  a valid Michigan State certificate (InCommon RSA OV SSL CA 3) covering the host, but omits the
  intermediate, so the chain fails to build. The intermediate was fetched from the address the
  certificate itself advertises and appended to the system CA bundle, giving a fully verified
  connection — `curl -k` was **not** used and should not be. Both load-bearing papers acquired.
- **brill.com serves its open-access PDFs only to browser user-agents** — several BKI items are
  genuinely OA but will fail a scripted fetch.
- **The machine-ethics half of Part 8 is almost entirely open access; the human half is almost
  entirely closed.** Nearly everything notes 8.2 and 8.4 imported without URLs is downloadable
  today, while the 'Ata record is walled end to end.
- Two errors in the tasking of this pass, caught by the reviewers and recorded here so they do not
  propagate: Paul Stange's PhD is **Wisconsin–Madison**, not ANU; and "Howell" is **Howe**.

## Provenance

Everything in these reviews is a *pointer*, not an acquisition. Many book-length items are
community uploads of in-copyright works — live today, gone tomorrow, not publisher-authorised. Per
the project's source policy they are read and turned into **attributed summary notes** staged at
`$VECTORDBS/appliedanthropology/workshops/DD/sources/`, never redistributed. Items marked **OA**
are genuinely open-licensed. Whether any staged note is folded into the corpus remains an editorial
decision, made by hand.

#fin
