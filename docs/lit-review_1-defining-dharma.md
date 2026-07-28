# Literature review — Part 1, *Defining Dharma*

**Date:** 2026-07-28 · **Scope:** downloadable full-text sources bearing on `1-defining-dharma.md`
and its underlying notes (1.1, 1.2, 1.3, 1.4, 3.3, 3.4).

## Why this review exists

The essay is finished and well argued, but an audit of the ~50 sources behind it shows that
several **load-bearing claims rest on tertiary sources** — Wikipedia, Wiktionary, encyclopedia
summaries, publisher blurbs, or abstract-only records. Specifically:

| Claim in the essay | Currently sourced to | Status |
|---|---|---|
| √dhṛ → PIE, *firmus* cognate | Wiktionary (which cites Mayrhofer) | tertiary |
| *dhárman-* 63× in the Rigveda | Wikipedia, quoting Brereton | tertiary |
| semantic broadening cosmic→social→personal→Buddhist | Wikipedia + a linguistics textbook | tertiary |
| Abhidharma "dharmas" as momentary constituents | corpus + encyclopedic | thin |
| Gallie, essentially contested concepts | OUP **abstract page** | not read |
| Waismann, open texture | **Wikipedia** | not read |
| Asad, "there cannot be a universal definition" | publisher blurb, "excerpt level" | not read |
| Curry, seven moral rules / 60 societies | prosocial.world blog posts | secondary |
| Brown, human universals | **Wikipedia** article | tertiary |

> **Acquisition status (2026-07-28):** 85 of these sources — 928 MB, 0 corrupt — have been
> downloaded to `scratch/sources/part1/` (gitignored). See
> [`scratch/sources/README.md`](../scratch/sources/README.md) for the inventory, per-file
> provenance/licence status, and the four open-access items that still need a manual browser
> download (Stenmark EJPR, Weir, Kollmar-Paulenz, Flügel).
>
> **Staging status (2026-07-28):** 26 attributed summary notes — ~64,000 words, every quotation
> page-anchored and verified against the source (see `scratch/sources/verify-anchors.py`) — are
> staged at `$VECTORDBS/appliedanthropology/workshops/DD/sources/` covering the Asad objection
> and reply, cooperation science and its critics, Indology/philology, cosmic-order cognates,
> definition theory, and the borderline cases. Aquinas ST I-II qq. 90–97 was additionally
> acquired (New Advent HTML) during this pass.

Everything below was **link-verified on 2026-07-28** (HTTP status + content-type; key items
downloaded and text-searched). Access flags are honest: `verified` = live full text retrieved;
`lending` = archive.org borrow required; `browser` = OA but bot-blocked to scripted fetches;
`walled` = no free copy found.

▲ **Provenance warning.** Many book-length items below are *community uploads of in-copyright
works* on archive.org and course sites — live today, removable tomorrow, and not publisher-authorised
OA. Per this project's source policy, these should be read and turned into **attributed summary
notes** in `$VECTORDBS/appliedanthropology/workshops/DD/`, not redistributed. Items marked
**OA** are genuinely open-licensed and safe to archive.

---

## Tier 0 — The five that change the most, soonest

1. **Talal Asad, *Genealogies of Religion* (JHU Press, 1993) — full text, 346 pp.**
   <https://archive.org/download/AsadTalalGenealogyOfReligion/Asad_Talas_Genealogy_of_Religion_text.pdf>
   `verified` · grey upload.
   Ch. 1 "The Construction of Religion as an Anthropological Category" begins p. 27. The sentence
   the essay quotes was confirmed **verbatim** in this file. The essay's most serious published
   opponent is currently cited from a blurb; this makes the engagement first-hand.

2. **Patrick Olivelle (ed.), *Dharma: Studies in its Semantic, Cultural and Religious History*
   (MLBD 2009 = *JIP* 32/5–6, 2004) — partial scan, 133 pp.**
   <https://archive.org/details/dharmastudiesinitssemanticculturalandreligioushistorypatrickolivellecollectionof>
   `verified` (contents confirmed by text extraction) · grey upload · **scan marked "Incomplete"**.
   Contains **in full**: Olivelle, "The Semantic History of Dharma: The Middle and Late Vedic
   Periods"; Gethin, "He Who Sees Dhamma Sees Dhammas"; Cox, "From Category to Ontology"
   (Sarvāstivāda Abhidharma); part of Bronkhorst. **Does not contain** Horsch or Brereton.
   Replaces Wikipedia for both the broadening narrative and the Abhidharma plural.

3. **Curry, Mullins & Whitehouse (2019), "Is It Good to Cooperate?", *Current Anthropology*
   60(1):47–69 — typeset published version *with* peer commentaries and reply.**
   <https://ora.ox.ac.uk/objects/uuid:8dd8d82d-3829-4857-bcf4-eebf196d11be/files/r3r074t925>
   `verified` (commentaries confirmed present) · Oxford ORA deposit.
   Carries the published critiques of Paul Bloom, Herbert Gintis, Smith & Kurzban ("Morality Is
   Not Always Good") and David B. Wong, plus the authors' reply — the primary source and its
   strongest critics in one file. Supplement (HRAF coding tables):
   <https://ora.ox.ac.uk/objects/uuid:8dd8d82d-3829-4857-bcf4-eebf196d11be/files/r5d86p0205>

4. **W. B. Gallie, "Essentially Contested Concepts", *PAS* 56 (1956): 167–198 — full text.**
   <https://cooperism.law.columbia.edu/files/2023/12/Gallie-Essentially-Contested-Concepts-1955-CL.pdf>
   `verified`. The essay currently cites an abstract page for a claim it leans on twice.

5. **Mikael Stenmark, "Worldview studies", *Religious Studies* 58 (2022), 564–582 (online-first 2021).** **OA CC-BY**
   <https://www.cambridge.org/core/services/aop-cambridge-core/content/view/F3445C11686C131AA1FC36533944AB45/S0034412521000135a.pdf/div-class-title-worldview-studies-div.pdf>
   `verified`. A philosopher of religion arguing precisely the essay's central move — that secular
   outlooks belong in the *same* comparative category as religious ones, rather than counting as
   the absence of one. Citations rising steeply (14 in 2026 alone). The essay makes this move on
   its own authority; here is a published ally.

---

## 1 · Etymology, philology, Indology  (note 1.1)

- **Pokorny *IEW* 2. \*dher- "to hold, support"** — UT Austin LRC Indo-European Lexicon.
  <https://lrc.la.utexas.edu/lex/master/0399> `verified` (reflex table confirmed to list **both**
  Latin *firmus* and Sanskrit *dharma*). Scholarly replacement for the Wiktionary PIE claim.
  ▲ neighbouring entry /0398 is a homophone meaning "dirt, dregs" — do not cite by accident.
- **Cologne Digital Sanskrit Dictionaries** <https://www.sanskrit-lexicon.uni-koeln.de/> `verified`.
  One portal for Monier-Williams (1899), Böhtlingk–Roth, **Grassmann's *Wörterbuch zum Rig-Veda***
  (1873), Apte, Macdonell. Grassmann sources the Vedic n-stem *dhárman-* directly.
- **Rigveda, Aufrecht ed. (GRETIL)** — HTML/plaintext/TEI.
  <https://gretil.sub.uni-goettingen.de/gretil/corpustei/transformations/html/sa_Rgveda-edAufrecht.htm> `verified`
- **Griffith, *Hymns of the Rigveda*** (1896, public domain)
  <https://archive.org/details/hymns-of-the-rigveda-english-translation-of-the-rigveda-complete-2-volumes> `verified`
- **Halbfass, *India and Europe*** (SUNY 1988), ch. 17 on dharma's untranslatability.
  <https://archive.org/details/India_and_Europe_An_Essay_in_Philosophical_Understanding_Wilhelm_Halbfass> `verified` · grey
- **Olivelle (trans.), *Dharmasūtras*** (OUP 1999)
  <https://archive.org/details/dharmasutrasthelawcodesofancientindiapatrickolivelleoup_202003_809_K> `verified` · grey
- **Olivelle, *Manu's Code of Law*** (OUP 2005) — *svadharma*, varṇa duty, dharma vs *daṇḍa*.
  <https://archive.org/details/manus-code-of-law-a-critical-edition-and-translation-of-the-manava-dharmasastra-pdfdrive> `verified` · grey
  ▲ the UT Austin `manuscode.pdf` that looks official is only a 3-page excerpt.
- **Bühler, *The Laws of Manu*** (SBE 25, 1886) <https://archive.org/details/wg925> `verified` · public domain
- **Telang, *Bhagavadgītā*** (SBE 8, 1882)
  <https://archive.org/details/kpln_the-sacred-books-of-the-east-ed-by-f-max-muller-vol-8-the-bhagavad-gita-with-san> `verified`
  → **replaces the anonymous Gita translation** currently flagged *unverified* in notes 1.3 and 3.4.
- **P. V. Kane, *History of Dharmaśāstra*** (DLI scans) e.g. <https://archive.org/details/dli.ernet.104122> `verified`
- **Macdonell, *A Vedic Reader for Students*** <https://archive.org/details/in.ernet.dli.2015.383604> `verified`

### Abhidharma and Jain usages
- **Y. Karunadasa, *The Dhamma Theory*** (BPS Wheel 412/413, 1996) — **free-distribution licence**.
  <https://www.bps.lk/olib/wh/wh412_Karunadasa_Dhamma-Theory--Philosophical-Cornerstone-of-Abhidhamma.pdf> `verified`
  Warns against pressing the "atoms" gloss — relevant to the essay's wording "atoms of mind and matter".
- **Noa Ronkin, "Abhidharma", *SEP*** <https://plato.stanford.edu/entries/abhidharma/> `verified`
  (citable stand-in for her paywalled *Early Buddhist Metaphysics*).
- **Nyanaponika Thera, *Abhidhamma Studies*** <https://archive.org/details/abhidhammastudie00nyan> `verified`
  Argues dhammas are events/processes, not substances — nuances the same sentence.
- **Umāsvāti, *Tattvārtha Sūtra*, trans. Tatia** — ch. 5, *dharmāstikāya* as medium of motion.
  <https://archive.org/details/ThatWhichIsTattvarthaSutraNathaMalaTatia> `verified` · grey
- **Jaini, *The Jaina Path of Purification*** <https://archive.org/details/ukhx_the-jaina-path-of-purification-by-padmanabh-s-jaini-jainism-1979-delhi-motilal-banarsidass> `verified` · grey
- **Peter Flügel, "A Short History of Jaina Law"** (SOAS) <https://eprints.soas.ac.uk/3169/1/Jaina_Law.pdf> `browser`

### ▲ Substantive challenge found here
**Olivelle's own paper complicates the essay's smooth broadening story.** Confirmed by text
extraction: he shows that dharma is *marginal* in exactly the middle- and late-Vedic texts where
one "would expect" it to become central, and that its later prominence owes much to **Aśokan and
Buddhist adaptation** rather than a continuous Brahmanical relay. The essay's "From there, the
meaning broadens, as meanings do" is tidier than the philology. Worth a sentence.

### Unobtainable (honest)
- **Brereton, "Dhárman in the Ṛgveda", *JIP* 32 (2004)** — the actual source of the **63 occurrences**
  figure. Confirmed **absent** from the Olivelle scan. Springer `walled`; Academia.edu and JSTOR
  login-walled. Until retrieved, that number stays Wikipedia-sourced.
- **Horsch, "From Creation Myth to World Law"** — same situation; also absent from the scan.
- **Hiltebeitel, *Dharma*** (2010/2011) — `lending` only.
- **Mayrhofer, *EWAia*** — no digital copy; Pokorny/Cologne are the practical substitutes.

---

## 2 · Cosmic-order cognates: ṛta, ma'at, asha, logos, Tao, natural law  (note 1.4)

- **Emily Teeter, *The Presentation of Maat*** (SAOC 57, Oriental Institute 1997). **OA — official**
  <https://isac.uchicago.edu/sites/default/files/uploads/shared/docs/saoc57.pdf> `verified`
- **Miriam Lichtheim, *Maat in Egyptian Autobiographies*** (OBO 120, 1992). **OA — official**
  <https://www.zora.uzh.ch/server/api/core/bitstreams/11b3d8b8-e7d8-4679-8458-d311f2eee25b/content> `verified`
  Ma'at as a lived moral code traced through first-person autobiographies — the strongest evidence
  for ma'at binding cosmos to individual conduct. Replaces the EBSCO/ancient-egypt-online pages.
- **Schlerath & Skjærvø, "AŠA", *Encyclopædia Iranica*** — derives *aša* and Vedic *ṛtá* from common
  Indo-Iranian \**ṛtá-*. Live site bot-blocks; verified snapshot:
  <https://web.archive.org/web/20231117000525id_/https://iranicaonline.org/articles/asa-means-truth-in-avestan> `verified`
- **Mahmoudi (2024), "Ṛta and Aša", *Ethics and Normativity* 1.1.** **OA**
  <https://ean.urd.ac.ir/article_200158_c157984bdafaca36d69d80cbcece3b98.pdf> `verified`
- **Yasna incl. the Gathas, trans. Mills** <https://www.avesta.org/yasna/yasna.htm> `verified` — primary
  Avestan text for *asha*, replacing zoroastrian.org.
- **Slingerland (2000), "Effortless Action: wu-wei", *JAAR* 68.2**
  <https://www.edwardslingerland.com/s/effortless_action.pdf> `verified` — the canonical treatment of
  *wu wei* as attunement to a normative cosmic order.
- **Thomas Michael (2023), "Laozi's Conception of Justice", *Religions* 14:771.** **OA CC BY**
  <https://res.mdpi.com/d_attachment/religions/religions-14-00771/article_deploy/religions-14-00771.pdf> `verified`
- **Legge, *The Texts of Taoism*** (SBE 39–40) <https://archive.org/details/wg940> `verified` · public domain;
  Daodejing text-only at <https://www.gutenberg.org/ebooks/216>; Chinese at <https://ctext.org/zhuangzi>
- **Ostwald, "Nomos and Phusis in Antiphon"** (UC Berkeley 1990)
  <https://escholarship.org/content/qt7kg1w5zm/qt7kg1w5zm.pdf> `browser` — the authority on *nomos*,
  and Antiphon is the earliest explicit made-vs-discovered statement.
- **Gülenç (2016), "An Enquiry on Physis–Nomos Debate: Sophists", *Synthesis Philosophica* 31.1.** **OA**
  <https://pdfs.semanticscholar.org/2c84/cebfc8f02bd6bd2a7253be1eda7e1f9dbee7.pdf> `verified`
  Includes thinkers who *blur* the made/discovered line — usefully complicates the essay's binary.
- **Burnet, *Early Greek Philosophy*** (1920) — public-domain Heraclitus fragments on *logos*.
  <https://archive.org/download/earlygreekphilos00burnrich/earlygreekphilos00burnrich.pdf> `verified`
- **Diels, *Die Fragmente der Vorsokratiker*** vol. 1 <https://archive.org/details/diefragmentederv01dieluoft> `verified`
- **von Arnim, *Stoicorum Veterum Fragmenta*** vol. 1 <https://archive.org/details/stoicorumveterum01arniuoft> `verified`
- **Cicero, *De Legibus* / *De Re Publica*** (OLL) — *"true law is right reason in agreement with nature"*.
  <https://oll-resources.s3.us-east-2.amazonaws.com/oll3/store/titles/545/Cicero_0044-02_EBk_v6.0.pdf> `verified`
- **Aquinas, *Summa* I-II qq. 90–97** <https://www.gutenberg.org/ebooks/17897> `verified` — eternal law →
  natural law → human law, structurally parallel to the essay's ṛta→dharma two-storey design.
- **Llano Alonso (2012), "Cicero and Natural Law"**
  <https://cooperative-individualism.org/alonso-fernando_cicero-and-natural-law-2012.pdf> `verified` · grey
- **Frankfort et al., *The Intellectual Adventure of Ancient Man*** (1946)
  <https://archive.org/download/intellectual_adventure/intellectual_adventure.pdf> `verified`
  The classic comparative statement of conduct embedded in cosmic order — best free framing for
  the "many civilisations independently reached for it" claim.

### ▲ Substantive challenge found here
**Heinrich Lüders, *Varuṇa II: Varuṇa und das Ṛta*** (1959, German)
<https://archive.org/details/relig-ie-indo-varuna-2-varuna-rta-lu-ders-livro> `verified`.
The foundational argument that *ṛta* means **"truth"**, not "cosmic order" — i.e. a direct
challenge to how the essay glosses the term, and the debate the Iranica entry presupposes.

### Unobtainable
Assmann, *Ma'at* (1990) — no legal OA copy anywhere; Lichtheim + Teeter are the substitutes.
Karenga, *Maat, the Moral Ideal* — nothing, not even lending. Boyce, *Textual Sources* — `lending`.
Faulkner's *Book of the Dead* — `lending` (Budge 1898 is free but dated).

---

## 3 · Definition, family resemblance, contestedness  (note 1.3)

- **Gallie 1956** — see Tier 0.
- **Collier, Hidalgo & Maciuceanu (2006), "Essentially contested concepts: Debates and applications"**
  <https://polisci.berkeley.edu/sites/default/files/people/u3827/Collier%20Gallie.pdf> `verified`
  The standard systematisation of Gallie's criteria and fifty years of use — grounds *and* stress-tests.
- **Waldron, "Is the Rule of Law an Essentially Contested Concept (in Florida)?"**
  <https://users.ox.ac.uk/~lawf0068/ROL_ECC.LP.perps.pdf> `verified`
- **Waismann, "Verifiability" (1945)** — full symposium, the *open texture* source.
  <https://sites.ualberta.ca/~francisp/Phil448/WaismannVerifiability45.pdf> `verified`
  Replaces the current Wikipedia citation.
- **Rosch & Mervis (1975), "Family Resemblances"**
  <http://matt.colorado.edu/teaching/categories/rm75.pdf> `verified` — the empirical bridge from
  Wittgenstein to prototype theory; directly supports the magpie/penguin passage.
- **Wittgenstein, *The Blue and Brown Books*** <https://www.wittgensteinproject.org/w/index.php/Blue_Book>
  `verified` — free full text; contains the attack on "the craving for generality".
  ▲ *Philosophical Investigations* in English is **still in copyright**: `lending` at
  <https://archive.org/details/philosophicalinv0000witt_q0w3>. The German *PU* is free at the same project.
- **Lakoff, *Women, Fire, and Dangerous Things*** <https://archive.org/details/womenfiredangero00lako> `lending`
- **Hart, *The Concept of Law*** ch. VII (open texture in law) <https://archive.org/details/conceptoflaw00hart> `lending`
- **Andrew McKinnon (2002), "Sociological definitions, language games, and the 'essence' of religion"**
  <https://aura.abdn.ac.uk/bitstream/2164/3073/1/McKinnon_Definition_of_Religion_author_version_no_format.pdf> `verified`
  Uses Wittgenstein's language games to build a non-essentialist definition that survives the
  constructionist critique — effectively the published form of this essay's own answer to Asad.

### Counterweights (wanted, and found)
- **Ruben, "W. B. Gallie and Essentially Contested Concepts"** <https://philarchive.org/archive/RUBWGA> `browser`
  — argues the contestedness thesis is far weaker than those who invoke it assume.
- **Kripke, *Naming and Necessity*** <https://archive.org/details/namingnecessity0000krip> `lending`
- **Putnam, "The Meaning of 'Meaning'"** <https://hdl.handle.net/11299/185225> `browser`
- **Swanton (1985), "On the 'Essential Contestedness' of Political Concepts"** — `walled`; JSTOR only.

---

## 4 · The Asad problem: manufactured categories, and the reply  (note 1.3, Part 6 forward-link)

### The objection
- **Asad, *Genealogies of Religion*** — see Tier 0.
- **Asad, *Formations of the Secular*** (2003)
  <https://archive.org/details/TalalAsadFormationsOfTheSecularChristianityIslamModernityPdf> `verified` · grey
  Extends the genealogy to *the secular* — which the phrase "secular dharma" inherits.
- **Geertz, "Religion as a Cultural System"** in *The Interpretation of Cultures*
  <https://archive.org/details/clifford-james-geertz-1973-the-interpretation-of-cultures-selected-essays> `verified` · grey
  **Needed**: this is the functional definition Asad attacks line by line, and the essay's own
  four-feature definition stands structurally where Geertz stood.
- **J. Z. Smith, "Religion, Religions, Religious"** in Taylor (ed.), *Critical Terms*
  <https://archive.org/details/mark-c.-taylor-critical-terms-for-religious-studies-1998> `verified` · grey
  Source of "religion is solely the creation of the scholar's study".
- **Richard King, *Orientalism and Religion*** — applies the genealogy to *Hinduism* and *Buddhism*
  specifically, i.e. to dharma traditions.
  <https://foldxx.wordpress.com/wp-content/uploads/2011/02/orientalism-and-religion-post-colonial-theory-india-and-the-mystic-east.pdf> `verified` · grey, impermanent
- **Almond, *The British Discovery of Buddhism*** (1988)
  <http://wiswo.org/books/_resources/book-reference-pdfs/Almond-1988-The-British-Discovery-of-Buddhism.pdf> `verified` · grey
  The case study for "Buddhism" assembled in Victorian texts before being "found" in Asia.
- **Lopez (ed.), *Curators of the Buddha*** <https://archive.org/details/curators-of-the-buddha-the-study-of-buddhism-under-colonialism-includes-tibet> `verified` · grey
- **Nongbri, *Before Religion*, chs. 2–3** <https://classics.osu.edu/sites/classics.osu.edu/files/Before%20Religion--Brent%20Nongbri%20Chapters%202%20%26%203.pdf> `verified` (partial; full book `lending`)
- **Dubuisson, *The Western Construction of Religion*** <https://archive.org/details/daniel-dubuisson-the-western-construction-of-religion-myths-knowledge-and-ideolo> `verified` · grey
  The most radical form of the objection — and his proposed replacement term is a useful comparandum.
- **Todd H. Weir (2025), "Forging 'worldview' in modern culture wars", *Religion*.** **OA**
  <https://www.tandfonline.com/doi/pdf/10.1080/0048721X.2025.2588267?needAccess=true> `browser`
  Conceptual history of *worldview* since 1790 — the Asad-shaped genealogy of the very category
  the essay reaches for.

### The reply (the half the project was missing)
- **Kevin Schilbrack, "The Concept of Religion", *SEP*** (2022) <https://plato.stanford.edu/entries/concept-religion/> `verified`
  The best single reply source: why the genealogy does not entail abandoning the category.
  ▲ **Correction after full reading (2026-07-28):** this entry does **not** license the essay's
  "disclose authorship, keep the tool" move — disclosure is nowhere among Schilbrack's defences,
  and he holds that a polythetic framing is "equally ethnocentric" anyway. His actual defence is
  indifferent to the author's candour: realism about social structures, plus testing the map
  against the territory. Two passages also cut *against* DD — that creed/cult/code are "not even
  distinctively religious" without a delimiting criterion, and that when religion is defined
  functionally "the universality of religion that one then finds is not a discovery but a product
  of one's definition." See the staged note for the detail.
- **Riesebrodt, *The Promise of Salvation*** <https://archive.org/details/the-promise-of-salvation-a-theory-of-religion-2010> `verified` · grey
  Ch. 1 answers the Western-construction objection and then builds a universal **functional**
  definition in full awareness of it — the closest structural precedent for what this essay does.
- **Taves, *Religious Experience Reconsidered*** <https://archive.org/details/ann-taves-religious-experience-reconsidered-a-building-block-approach-to-the-stu> `verified` · grey
  Concede the aggregate is a scholar's construct, rebuild comparison from smaller units.
- **Lorenzen (1999), "Who Invented Hinduism?"** <https://archive.org/details/who-invented-hinduism> `verified`
  Surveys the constructionist consensus, then argues Hindu self-identity predates the British —
  a built-in check against overstating the "nineteenth century manufactured the containers" line.
- **Sweetman (2003), "'Hinduism' and the History of 'Religion'"** <https://brill.com/downloadpdf/journals/mtsr/15/4/article-p329_2.pdf> `browser`
  Argues the *critics* of the category smuggle in Protestant assumptions.
- **Abbasi (2021), "Islam and the Invention of Religion: Medieval Muslim Discourses on Dīn"**
  <https://www.multiple-secularities.de/media/abbasi_islam_and_the_invention_of_religion.pdf> `verified`
  Tests the Nongbri/Asad thesis against a **non-Western** concept and finds a pre-modern
  religion-like category — a close parallel to this project's wager about *dharma*.
- **Kollmar-Paulenz (2023), "Nga rang gi chos khyod rang gi chos"** <https://doi.org/10.30965/23642807-bja10082> `browser`
  Non-European taxonomies of religion predating European contact — same counterweight, Tibetan case.
- **Masuzawa, *The Invention of World Religions*** — `lending` only; Fitzgerald, McCutcheon — `lending`.

---

## 5 · Cooperation, universals, function-vs-mechanism  (note 1.2)

- **Curry, Mullins & Whitehouse (2019) + commentaries** — see Tier 0.
- **Curry (2016), "Morality as Cooperation: A Problem-Centred Approach"**
  <https://www.oliverscottcurry.com/s/currymac2016.pdf> `verified` — the theory behind the test,
  and where the universal-problem / plural-solution logic is set out.
- **Curry et al. (2021), "Moral Molecules: Morality as a Combinatorial System".** **OA**
  <https://link.springer.com/content/pdf/10.1007/s13164-021-00540-x.pdf> `verified`
  The best published statement of *one function, many mechanisms* — the essay's Tinbergen point.
- **Alfano, Cheong & Curry (2024), "Moral universals: a machine-reading analysis of 256 societies".** **OA**
  <https://europepmc.org/articles/PMC10945118?pdf=render> `verified` — the scaled-up successor that
  partly answers the sampling objection.
- **Tinbergen (1963), "On Aims and Methods of Ethology"**
  <https://www.esf.edu/biology/faculty/documents/Tinbergen1963onethology.pdf> `verified`
- **Nesse (2019)** <https://europepmc.org/articles/PMC6343817?pdf=render> and **Bateson & Laland (2013)**
  <https://lalandlab.wp.st-andrews.ac.uk/files/2015/08/Publication199.pdf> — modern restatements. **OA**
- **Brown (2004), "Human Universals, Human Nature & Human Culture", *Daedalus***
  <https://www.humiliationstudies.org/documents/BrownUniversalsDaedalus.pdf> `verified`
  Brown in his own words, explicitly listing exchange, cooperation and reciprocity — replaces the
  Wikipedia citation. The 1991 book itself is `lending` only.
- **Trivers (1971), "The Evolution of Reciprocal Altruism"**
  <https://greatergood.berkeley.edu/images/uploads/Trivers-EvolutionReciprocalAltruism.pdf> `verified`
  The closest single source for the essay's list of moral emotions (reciprocity, gratitude, guilt,
  cheater-detection).
- **Axelrod & Hamilton (1981)** <https://websites.umich.edu/~axe/research/Axelrod%20and%20Hamilton%20EC%201981.pdf> `verified`
- **Nowak (2006), "Five Rules"** <https://pdodds.w3.uvm.edu/files/papers/others/2006/nowak2006a.pdf> `verified`
- **Nowak & Sigmund (2005), indirect reciprocity** <http://pure.iiasa.ac.at/id/eprint/7763/1/IR-05-079.pdf> `verified`
- **Fehr & Gächter (2002), altruistic punishment** <https://www.econ.uzh.ch/dam/jcr:ffffffff-9758-127f-ffff-fffffd123b6f/AltruisticPunishment.pdf> `verified`
- **Richerson et al. (2016), cultural group selection, *BBS*.** **OA publisher**
  <https://www.cambridge.org/core/services/aop-cambridge-core/content/view/638ED0187A9727D9D327661A91DE0759/S0140525X1400106Xa.pdf/div-class-title-cultural-group-selection-plays-an-essential-role-in-explaining-human-cooperation-a-sketch-of-the-evidence-div.pdf> `verified`
- **Boyd & Richerson (1985, 2005)** <https://archive.org/details/BoydRicherson2005TheOriginAndEvolutionOfCulturesBook> `verified` · grey
- **Ostrom, *Governing the Commons*** <https://archive.org/details/governing-the-commons> `verified` · grey;
  **Nobel lecture** <https://www.nobelprize.org/uploads/2018/06/ostrom_lecture.pdf> `verified` · unambiguously free
- **Tomasello & Vaish (2013), "Origins of Human Cooperation and Morality"**
  <https://www.eva.mpg.de/documents/Annual%20Reviews/Tomasello_Origins_AnnRevPsych_2013_1737970.pdf> `verified`
- **Norenzayan et al. (2016), "The cultural evolution of prosocial religions", *BBS*.** **OA publisher**

### ▲ Challenges to the universality claims — the section the notes most need
The essay states flatly that Curry "found not a single culture that ran the rules in reverse", and
that reciprocity and fairness sit on Brown's list with "no known exceptions". These are contested:

- **Gellner, Curry, Cook, Alfano & Venkatesan (2020), *JRAI* 26(2) — formal GDAT debate.** **OA CC BY-NC**
  <https://ora.ox.ac.uk/objects/uuid:b9edad56-a481-41cb-a956-3b4aacb2aa50/files/rr207tp40k> `verified`
  Curry proposing, social anthropologists opposing — the discipline-level rebuttal, in motion-and-
  opposition format, unusually citable.
- **Slingerland, Atkinson, Ember et al. (2020), "Coding culture", *Evol. Hum. Sci.*** **OA**
  <https://europepmc.org/articles/PMC10427479?pdf=render> `verified`
  The eHRAF coding-validity critique co-written by HRAF insiders — coder reliability, uneven
  coverage, construct non-equivalence. The methodological soft spot beneath "we coded 60 societies".
- **Bromham et al. (2018), "Parasites and politics", *R. Soc. Open Sci.*** **OA**
  <https://openresearch-repository.anu.edu.au/server/api/core/bitstreams/725f4599-53b0-4ad1-a2e7-56ee74b8101d/content> `verified`
  Galton's problem: societies are not independent data points, so shared ancestry and diffusion
  inflate universality counts.
- **Geertz (1973), "The Impact of the Concept of Culture on the Concept of Man"**
  <https://web.mit.edu/allanmc/www/geertz.pdf> `verified`
  The deepest objection: universals reached by subtraction are so abstract as to be vacuous, and
  there is no *consensus gentium* to poll.
- **Prinz (2008), "Is Morality Innate?"** <https://www.joelvelasco.net/teaching/3334/prinz07-is_morality_innate.pdf> `verified` · grey
- **Machery (2012), "Delineating the Moral Domain".** **OA**
  <https://journals.newprairiepress.org/biyclc/article/17130/galley/16632/download/> `verified`
  With no moral/non-moral boundary, any cooperative norm counts as evidence — the falsifiability worry.
- **Rai & Fiske (2011), "Moral Psychology Is Relationship Regulation"** <https://sdimakis.github.io/moral_psychology/readings/week_1/Optional/Rai_2011.pdf> `verified` · grey
  Violence and hierarchy are often experienced as *morally required*, so scoring cooperation as
  uniformly "good" assumes the conclusion.
- **Suhler & Churchland (2011)** <https://patriciachurchland.com/wp-content/uploads/2020/05/2011-Innate-Modular-Foundations.pdf> `verified`
- **Singh & Glowacki (2022), "Beyond the nomadic-egalitarian model", *EHB*.** **OA**
  <https://ecoevorxiv.org/repository/object/4128/download/8198/> `verified`
  34 world regions: the uniform ancestral-society baseline is an artefact of selective sampling —
  the strongest challenge to "social suite" framings.
- **Henrich, Heine & Norenzayan (2010), "The weirdest people in the world?"**
  <https://www2.psych.ubc.ca/~henrich/pdfs/WeirdPeople.pdf> `verified`; **Barrett (2020)**
  <http://www.hclarkbarrett.com/uploads/4/3/8/0/43803347/barrett_2020_towards_a_cognitive_science_of_the_human.pdf> `verified`
- **Floyd et al. (2018), gratitude across languages.** **OA** <https://europepmc.org/articles/PMC5990755?pdf=render> `verified`
  Cuts both ways: reciprocity universal, overt thanking rare — complicates "gratitude" as a universal.

### Honest gaps
- **Shultz, Opie & Atkinson (2011)**, the empirical source for the ~52-million-year figure behind
  the essay's "fifty million years", is `walled`. Nearest OA adjacent: Kappeler & Pozzi (2019)
  <https://europepmc.org/articles/PMC6989303?pdf=render>, which *challenges* the stepwise model.
- **No peer-reviewed David Sloan Wilson paper applying Tinbergen specifically to morality exists.**
  The prosocial.world post the notes cite appears to be the only place he makes that argument in
  that form. Cite Tinbergen 1963, Nesse 2019 and Curry 2016/2021 for the same move in print.

---

## 6 · The borderline cases the essay names but does not source

The four-feature test is applied to environmentalism, professional ethos and punk "scoring two or
three out of four". There is an existing literature on exactly this, currently uncited.

- **Stenmark, "Worldview studies" (2021)** — see Tier 0; and **Stenmark, "Secular Worldviews:
  Scientific Naturalism and Secular Humanism", *EJPR* (2022)** <https://philpapers.org/archive/STESWS-2.pdf> `browser`
- **Gürlesin (2024), "Social Media, Environmental Activism and Implicit Religion: Extinction
  Rebellion", *Religions* 15:1458.** **OA CC BY** — `browser` (MDPI bot-blocks; use `res.mdpi.com`)
  Applies Edward Bailey's *implicit religion* framework to climate activism: shared beliefs, moral
  imperatives, collective identity, transcendent purpose. Directly serves the environmentalism case.
- **Kurenlahti & Salonen (2018), "Rethinking Consumerism from the Perspective of Religion",
  *Sustainability* 10:2454.** **OA** — consumerism as implicit religion.
- **Robert H. Nelson, "Rethinking Church and State: The Case of Environmental Religion"**
  <https://digitalcommons.pace.edu/cgi/viewcontent.cgi?article=1684&context=pelr> `verified`
- **Francis Stewart (2015), "The anarchist, the punk rocker and the Buddha walk into a bar(n):
  Dharma Punx and Rebel Dharma", *Punk & Post Punk* 4(1)** — `browser` (Stirling repository).
  Fieldwork on an actual punk/dharma fusion — the punk case, evidenced rather than asserted.
- **Batchelor (2012), "A Secular Buddhism", *JGB* 13.** **Diamond OA**
  <https://www.globalbuddhism.org/article/download/1189/1024/2236> `verified`
  Batchelor openly "rethinking the core ideas on which the very notion of 'Buddhism' is based" —
  authorship disclosed, the same move this essay defends.
- **Higgins (2017), "The Flexible Appropriation of Tradition: Stephen Batchelor's Secular
  Buddhism", *JGB* 18.** **Diamond OA** <https://www.globalbuddhism.org/article/download/1238/1073/2326> `verified`
- **Truschke (2023), "Hindu: A History", *CSSH*.** **OA**
  <https://www.cambridge.org/core/services/aop-cambridge-core/content/view/413B7D68F16E4068FBCD53E3E0DD181D/S0010417522000524a.pdf/div-class-title-hindu-a-history-div.pdf> `verified`

---

## Recommended acquisition order

1. Asad full text, Geertz "Religion as a Cultural System", Schilbrack SEP → makes the Part-1
   Asad engagement first-hand, and supplies the reply the project currently lacks.
2. Olivelle volume + Karunadasa + Pokorny + Cologne → retires Wikipedia/Wiktionary from the
   etymology and Abhidharma claims.
3. Curry ORA package + Gellner debate + Slingerland "Coding culture" → converts the seven-rules
   claim from blog-sourced assertion into a properly contested finding.
4. Gallie, Waismann, Rosch & Mervis, McKinnon → retires abstract- and Wikipedia-level citations
   in note 1.3.
5. Teeter, Lichtheim, Iranica AŠA, Slingerland *wu wei*, Cicero, Aquinas → note 1.4.
6. Stenmark, Gürlesin, Stewart → sources the borderline cases in the four-feature section.

## Claims that should be softened or footnoted regardless of acquisition

- **"63 occurrences in the Rigveda"** — traceable only to Wikipedia until Brereton is obtained.
- **The smooth broadening narrative** — Olivelle shows dharma is marginal in middle/late Vedic and
  owes its prominence partly to Aśokan and Buddhist adaptation.
- **"ṛta = cosmic order"** — Lüders's standing thesis is that it means *truth*.
- **"not a single culture that ran the rules in reverse"** — four published commentaries, a formal
  anthropological debate, and an HRAF coding critique bear on this.
- **"fifty million years"** — the underlying primate-sociality paper is paywalled and its stepwise
  model is itself challenged.

#fin
