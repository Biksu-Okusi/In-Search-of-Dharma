# SOURCES — DD citation register

One entry per cited **work**. Resolve once, reuse across every note. See `SOURCE-CITATION-POLICY.design.md` for the policy this implements.

**Fields**

- `status:` `usable` | `barred`

- `barred:` `self` | `ephemera`  (present only when `status: barred`)

- `medium:` `text` | `text-ocr` | `transcript`

  ▲ `text-ocr` marks a sourcedoc whose text was recovered by OCR from a page scan,
  not supplied as digital text. Such a file is sound for retrieval but **unreliable
  word-for-word**: measured in-vocabulary rates run 79–85% against a 98% baseline for
  born-digital text in the same corpus, so roughly one word in six is garbled. Treat
  an OCR'd passage as a pointer to the claim, never as a quotable string — verify any
  wording against the printed original before it carries an `[S#]` quotation.

- `cite:` resolved human-readable reference (usable only). Transcripts:
  `Speaker, "Talk title" (platform, id/URL, year)`.

- `kb:` sourcedoc filename(s), backticked, comma-separated — the retrieval key(s).

- `verified:` `web (ISBN…/DOI…)` | `video-URL` | `file (…)` (checked only against the kb file itself) | `acquired (…)` (full text on hand, not web-checked) | `partial (…)` | `unverified`.

- `note:` optional free text.

A note's `[S#]` line points here via `[src:<key>]`. No `[S#]` may point at a `status: barred` entry. Author's-own claims use `[A]` and have NO entry here.

---

### abbasi-2021-islam-and-the-invention-of-religion
- status: usable
- medium: text
- cite: Rushain Abbasi, "Islam and the Invention of Religion: A Study of Medieval Muslim Discourses on Dīn," *Studia Islamica* 116 (2021), 1–106, DOI 10.1163/19585705-12341437
- kb: `Abbasi_Islam-and-the-Invention-of-Religion_StudiaIslamica-2021.md`
- verified: file (Brill masthead, DOI and page range at seg 0; thesis statement at segs 6–7)
- note: Counter to the "religion is a modern Western invention" genealogy for the Islamic case — premodern Muslims had a robust concept of *dīn* and a dīn/dunyā distinction.

### adam-bagir-2022-indigenous-politics-of-justice-sedulur-sikep
- status: usable
- medium: text
- cite: Ronald Adam & Zainal Abidin Bagir, "The Indigenous Politics of Justice: The Case of the Sedulur Sikep Movement," *Kawistara* 12:2 (30 August 2022): 181–199, DOI 10.22146/kawistara.67991
- kb: `Adam-Bagir_The-Indigenous-Politics-of-Justice-Sedulur-Sikep_Kawistara-2022.md`
- verified: file (abstract at seg 0; volume, pages and DOI at seg 1; running head with authors at seg 3)
- note: Four months with Wong Sikep households in Pati; redistribution and recognition inseparable in the peasant identity.

### al-mufakhir-2025-multikulturalisme-ajaran-sumarah
- status: usable
- medium: text
- cite: Al-Mufakhir, *Multikulturalisme dalam Ajaran Sumarah: Tuntunan Wewarah dan Ritual Sujud Sumarah di Pendopo Agung Sumarah, Wirobrajan, Yogyakarta* (skripsi, UIN Sunan Kalijaga Yogyakarta, 2025), Bab I–IV
- kb: `AlMufakhir_Multikulturalisme-dalam-Ajaran-Sumarah_UINSuka-2025_BAB-I-IV.md`
- verified: file (abstract at seg 0; fieldwork interview dated 18 November 2024 at seg 10; author's given name and exact title not recoverable from the ingested chapters — check the UIN repository record)
- note: Indonesian field study (Bikhu Parekh multiculturalism frame) of the Wewarah (compiled dhawuh) and Sujud at the Yogyakarta Pendopo; documents the textual dimension, the 1980 AD/ART, and the dominant/minority split over revelation. Non-Stange witness. Cited by DD notes 3.5, 3.5.1, 3.5.2, 3.5.3, 3.5.4.

### alan-barnard-1993-kropotkin-visits-the-bushmen
- status: usable
- medium: text
- cite: Alan Barnard, "Primitive Communism and Mutual Aid: Kropotkin Visits the Bushmen," in C. M. Hann (ed.), *Socialism: Ideals, Ideologies, and Local Practice* (ASA Monographs 31; London: Routledge, 1993), pp. 27–42
- kb: `Alan-Barnard_Primitive-Communism-and-Mutual-Aid_Kropotkin-Visits-the-Bushmen_1992.md`
- verified: web (Taylor & Francis chapter page for *Socialism: Ideals, Ideologies and Local Practice*, ASA Monographs 31, ch. 10, DOI 10.4324/9780203392676; Namibia Scientific Society library catalogue record 51105 gives pp. 27–42, Routledge 1993)
- note: Kalahari specialist auditing Kropotkin's mutual-aid reading against San ethnography — confirms the sharing pattern, qualifies it as theory-laden, bounded to the band cluster, and partly envy-management. The corpus's most nearly neutral check on the cooperative-forager picture. ▲ The KB filename year (1992) is the Anarchist Library posting date; the published chapter is 1993 — cite 1993.

### alfano-cheong-curry-2024-moral-universals-256-societies
- status: usable
- medium: text
- cite: Mark Alfano, Marc Cheong & Oliver Scott Curry, "Moral universals: A machine-reading analysis of 256 societies," *Heliyon* 10 (2024) e25940, DOI 10.1016/j.heliyon.2024.e25940 (CC BY-NC-ND)
- kb: `Alfano-Cheong-Curry_Moral-Universals-256-societies_Heliyon-2024.md`
- verified: file (masthead, DOI, received/accepted dates and CC licence in seg 0; Table 6 in seg 21; limitations in segs 25–27)
- note: MAC-D/LIWC machine-coded extension of the 60-society study to the full eHRAF ethics corpus; authors report over-detection (κ 0.08–0.25) and no valence measurement.

### ambedkar-1936-annihilation-of-caste
- status: usable
- medium: text
- cite: BR Ambedkar, *Annihilation of Caste* (undelivered presidential address to the Jat-Pat-Todak Mandal, Lahore, 1936; 3rd ed. 1944), annotated edition ed. Frances W Pritchett (Columbia University, 2004)
- kb: `Ambedkar_Annihilation-of-Caste_annotated-2004.md`
- verified: file (prologue with the 12 December 1935 Sant Ram letter at seg 0; section headings and paragraph numbers of the annotated edition; Chaturvarnya sections at segs 45–49, Manu at seg 52, Shastras at seg 61)
- note: The tradition-internal reformer's case against caste on grounds of practicability, harm and coercion — the counter to Dumont.

### analayo-2016-foundation-history-of-the-nuns-order
- status: usable
- medium: text
- cite: Bhikkhu Anālayo, *The Foundation History of the Nuns' Order* (Hamburg Buddhist Studies 6; Bochum/Freiburg: projekt verlag, 2016), ISBN 978-3-89733-387-1
- kb: `Analayo_The-Foundation-History-of-the-Nuns-Order_2016.md`
- verified: file (imprint with ISBN at seg 0; OCR provenance header lists only pages 1–2, 6, 12, 176, 268 as OCR'd — body is born-digital; Conclusion at segs 225–228)
- note: Comparative study of the seven canonical versions of the founding of the bhikkhunī order; the garudhammas as later "instruments of submission," the prediction of decline migrating from the first saṅgīti account, the ascetic-brahminical faction's control of transmission. Method explicitly textual, not historical reconstruction.

### anarchybooks-corpus-status
- status: barred
- barred: ephemera
- medium: text
- kb: `anarchybooks-corpus-status.md`
- verified: unverified
- note: corpus inventory report (238 epub entries checked against the KB, 2026-07-27). Build metadata about the corpus, not evidence about the world. Surfaces as noise on most anarchism probes; discard from results.

### ancient-minds-autistic-traits-ancient-tribes
- status: barred
- barred: ephemera
- medium: transcript
- kb: `Ancient-Minds_Did-Autistic-Traits-Help-Ancient-Tribes_2026.md`
- verified: unverified
- note: anonymous YouTube video essay (channel "Ancient Minds", youtube.com watch?v=88xZotShpxY). Popular-science gloss on the evolutionary-niche argument for autistic traits, with no named author and no cited primary research. The 2026-07-24 pass deliberately removed this class of source from load-bearing claims in the 5.6 block; it is barred here to keep it out. Anything it asserts must be re-grounded in the peer-reviewed literature already cited by note 5.6.1.

### anna-prouty-2017-anarcho-taoist-manifesto
- status: usable
- medium: text
- cite: Anna Prouty, "An Anarcho-Taoist Manifesto: Emotional Responsibility, Needs, and Amorphous Activism," self-published essay, 23 March 2017 (Medium — author later writing as Anna Mercury; repr. The Anarchist Library)
- kb: `Anna-Prouty_An-Anarcho-Taoist-Manifesto_Emotional-Responsibility-Needs-and-Amorphous-Activism_2017.md`
- verified: web (annamercury.medium.com; theanarchistlibrary.org/library/anna-prouty-an-anarcho-taoist-manifesto)
- note: second fusion specimen — anarchist consent theory fused with *wu wei* and a needs/feelings psychology; explicitly touches Buddhism ("freeing yourself from desire, in a full Buddhist sense"). Same SPECIMEN-GRADE caveat as the Ronan entry. Cited by DD note 8.3.

### anna-ronan-2019-anarchism-as-a-spiritual-practice
- status: usable
- medium: text
- cite: Anna Ronan, "Anarchism as a Spiritual Practice," DSA Libertarian Socialist Caucus Pamphlet Program, 23 May 2019 (repr. The Anarchist Library)
- kb: `Anna-Ronan_Anarchism-as-a-Spiritual-Practice_2019.md`
- verified: web (dsa-lsc.org 2019-05-24 posting; theanarchistlibrary.org/library/anna-ronan-anarchism-as-a-spiritual-practice). The caucus's own disclaimer marks it as the author's opinion, not caucus consensus.
- note: primary specimen of a live anarchist–contemplative fusion ("Anarchism is my religion"; Taoism via *The Tao of Pooh*). SPECIMEN-GRADE ONLY: a self-published movement pamphlet with no scholarly or institutional standing — citable as evidence the fusion is being attempted and for how it assembles, never as authority on whether it works. Cited by DD note 8.3.

### anscombe-1958-modern-moral-philosophy
- status: usable
- medium: text-ocr
- cite: GEM Anscombe, "Modern Moral Philosophy," *Philosophy* 33:124 (January 1958), 1–19
- kb: `Anscombe_Modern-Moral-Philosophy_Philosophy-1958.md`
- verified: file (masthead "Philosophy 33, No. 124 January 1958" and the three theses at seg 0; tesseract OCR, 37 low-confidence words marked `[?]`, seg 8 scrambled)
- note: The law-conception argument — moral "ought" as a survival from divine law, now "a word of mere mesmeric force"; moral philosophy to wait on a philosophy of psychology. Pointer for wording; check print before quoting.

### aquinas-summa-treatise-on-law
- status: usable
- medium: text
- cite: Thomas Aquinas, *Summa Theologiae* I-II, qq. 90–97 ("Treatise on Law"), trans. Fathers of the English Dominican Province (2nd rev. ed., 1920)
- kb: `Aquinas_ST-I-II_qq90-97_2090.md`, `Aquinas_ST-I-II_qq90-97_2091.md`, `Aquinas_ST-I-II_qq90-97_2092.md`, `Aquinas_ST-I-II_qq90-97_2093.md`, `Aquinas_ST-I-II_qq90-97_2094.md`, `Aquinas_ST-I-II_qq90-97_2095.md`, `Aquinas_ST-I-II_qq90-97_2096.md`, `Aquinas_ST-I-II_qq90-97_2097.md` (one file per quaestio, qq. 90–97) (full text, folded into the corpus 2026-08); `cicero-aquinas_natural-law-primary-texts.md` (attributed summary, in corpus under staging.text/DD/sources/oldsources/)
- verified: web (newadvent.org/summa, qq. 90–97 saved to DD archive 2026-07-28)
- note: attributed summary note with verified page anchors, shared with the Cicero entry. Natural law defined as the rational creature's participation in eternal law, knowable by 'the light of natural reason' (q. 91 a. 2) — the reason-accessible lower storey that weakens Part 1's 'cannot be secularised' contrast. Anchored edition-independently by q./a. Public domain.

### aristotle-nicomachean-ethics-ross
- status: usable
- medium: text
- cite: Aristotle, *Nicomachean Ethics*, trans. WD Ross (Oxford, 1908), electronic text at MIT Internet Classics Archive; also Gutenberg #8438 (trans. FH Peters)
- kb: `Aristotle_Nicomachean-Ethics_trans-Ross_classics-MIT.txt`, `Aristotle_Nicomachean-Ethics_Gutenberg-8438.txt`
- verified: file (Ross text; Book II.1 habituation passage at segs 29–30; born-digital plain text, not OCR)
- note: Primary for virtue as habituation — "we become just by doing just acts"; the same means produce and destroy every virtue. Not to be confused with the barred Durant paraphrase ("we are what we repeatedly do"). Cited by DD note 5.4.

### asad-1986-the-idea-of-an-anthropology-of-islam
- status: usable
- medium: text
- cite: Talal Asad, *The Idea of an Anthropology of Islam*, Occasional Papers Series (Washington, DC: Center for Contemporary Arab Studies, Georgetown University, 1986); repr. *Qui Parle* 17:2 (2009), 1–30
- kb: `Asad_The-Idea-of-an-Anthropology-of-Islam_1986.md`
- verified: file (JSTOR download footer on the pages; the *Qui Parle* editorial headnote at seg 0; the definition of a discursive tradition at seg 22)
- note: Source of "discursive tradition" — discourses instructing practitioners in the correct form and purpose of an established practice; reasoning intrinsic to tradition.

### asad-1993-genealogies-of-religion
- status: usable
- medium: text-ocr
- cite: Talal Asad, *Genealogies of Religion: Discipline and Reasons of Power in Christianity and Islam* (Baltimore: Johns Hopkins University Press, 1993)
- kb: `Asad_Genealogies-of-Religion_1993.md` (full text, folded into the corpus 2026-08); `talal-asad_genealogies-of-religion_1993.md` (attributed summary, in corpus under staging.text/DD/sources/oldsources/)
- verified: web (ISBN 978-0-8018-4632-8); central quotation confirmed verbatim at p. 29 of the full text
- note: attributed summary note with verified page anchors of ch. 1, 'The Construction of Religion as an Anthropological Category' (pp. 27–54) — the strongest published opponent of DD's central move, previously cited at blurb level. Full text in DD local archive (scratch/sources/part1/, gitignored); community upload, reading copy only. Cited by DD note 1.3 (S18) and Part 1.

### asad-2003-formations-of-the-secular
- status: usable
- medium: text-ocr
- cite: Talal Asad, *Formations of the Secular: Christianity, Islam, Modernity* (Stanford: Stanford University Press, 2003)
- kb: `Asad_Formations-of-the-Secular_2003.md`
- verified: file (running head "SECULAR" with pagination at seg 114; ch. 7 on Egypt with the Qasim Amin/Leila Ahmed passage and its footnotes at segs 281–282)
- note: Ch. 7 "Reconfigurations of Law and Ethics in Colonial Egypt": Qasim Amin's "liberation of woman" as the colonizer's attack on native culture (via Leila Ahmed); the family as a new category. OCR — quotations checked against the chunks.

### asrawijaya-hudayana-2021-power-of-a-leader-samin-opposition
- status: usable
- medium: text
- cite: Enkin Asrawijaya & Bambang Hudayana, "The Power of a Leader in the Samin People's Opposition Movement to the Development of a Cement Factory in the North Kendeng Mountains," *Humaniora* 33:1 (February 2021)
- kb: `Asrawijaya-Hudayana_The-Power-of-a-Leader-in-the-Samin-Opposition-Movement_Humaniora-2021.md`
- verified: file (UGM Humaniora masthead, title and authors at seg 0)
- note: Gunretno's social-capital leadership contrasted with Samin Surosentiko's charisma and ideology.

### atari-haidt-et-al-2023-morality-beyond-the-weird
- status: usable
- medium: text
- cite: Mohammad Atari, Jonathan Haidt, Jesse Graham, Sena Koleva, Sean T Stevens & Morteza Dehghani, "Morality Beyond the WEIRD: How the Nomological Network of Morality Varies Across Cultures," *Journal of Personality and Social Psychology* 125:5 (2023), 1157–1188, DOI 10.1037/pspp0000470
- kb: `Atari-Haidt-Graham-et-al_Morality-Beyond-the-WEIRD_JPSP-2023_preprint.md`
- verified: file (in-press author preprint header with APA copyright line at seg 0; abstract with study Ns and 25 populations at seg 1; volume/pages from the published record)
- note: MFQ-2 validation; the network of moral foundations varies by cultural context. Preprint, "not the copy of record".

### auda-2008-maqasid-al-shariah-as-philosophy-of-islamic-law
- status: usable
- medium: text
- cite: Jasser Auda, *Maqāṣid al-Sharīʿah as Philosophy of Islamic Law: A Systems Approach* (London/Washington: International Institute of Islamic Thought, 2008; reprint 2021)
- kb: `Auda_Maqasid-al-Shariah-as-Philosophy-of-Islamic-Law_IIIT-2008.md`
- verified: file (title page and blurb at seg 0; "REPRINT 2021" running footer; levels of necessity and Chart 1.1 at segs 11–12; diacritics mangled by the PDF font — "maq¥|id" = maqāṣid)
- note: Insider treatise on the higher objectives of Islamic law; the five necessities, al-Shāṭibī's levels, Auda's own Maslow comparison and the modern additions of justice and freedom.

### autor-2014-polanyis-paradox
- status: usable
- medium: text
- cite: David H Autor, "Polanyi's Paradox and the Shape of Employment Growth," NBER Working Paper 20485 (September 2014), DOI 10.3386/w20485
- kb: `Autor_Polanyis-Paradox-and-the-Shape-of-Employment-Growth_NBER-w20485-2014.md`
- verified: file (abstract at seg 0 with the Polanyi quotation; "overstate the extent of machine substitution" at seg 2)
- note: The standing counterweight to automation alarm — tacit knowledge, complementarities, employment polarisation. Paired with Frey & Osborne as a bracket, not a verdict.

### bahna-2022-review-of-whitehouse-ritual-animal
- status: usable
- medium: text
- cite: Vladimír Bahna, review of Harvey Whitehouse, *The Ritual Animal: Imitation and Cohesion in the Evolution of Social Complexity* (OUP 2021), *Slovenský národopis* 70:2 (2022), 305–309, DOI 10.61577/SN.2022.2.25
- kb: `Bahna_Review-of-Whitehouse-The-Ritual-Animal_SlovenskyNarodopis-2022.md`
- verified: file (bibliographic header with DOI and CC licence at seg 0; page numbers in running text)
- note: Sympathetic but sceptical review of the modes theory's applied turn ("realistic, exaggerated or naive"); notes the Seshat retraction.

### bakunin-1882-god-and-the-state
- status: usable
- medium: text
- cite: Mikhail Bakunin, *God and the State* (written 1871; pub. posthumously 1882, ed. Carlo Cafiero & Élisée Reclus)
- kb: `michail-bakunin_god-and-the-state.md` (under ``; pre-existing corpus file, not part of the 2026-07-27 fold)
- verified: web (composition 1871, publication 1882 by Cafiero & Reclus — Wikipedia, The Anarchist Library, marxists.org; early editions contain Cafiero/Reclus rewrites)
- note: primary text for "If God is, man is a slave", "the abdication of human reason and justice", "a master… remains none the less always a master", "if God really existed, it would be necessary to abolish him" — all four verified verbatim in the KB file (lines 140–162). Prefer this over the secondary treatments for any Bakunin quotation. Cited by DD note 7.3.

### baltzly-sep-stoicism
- status: usable
- medium: text
- cite: Dirk Baltzly, "Stoicism," *The Stanford Encyclopedia of Philosophy*, https://plato.stanford.edu/entries/stoicism/
- kb: `SEP_Stoicism.md`
- verified: file (section numbering §2.7 "God" at :16 matches the live entry)
- note: Stoic physics/theology — God as active principle and eternal *logos*.

### baron-cohen-2026-we-need-to-change-how-we-view-autism
- status: usable
- medium: transcript
- cite: Simon Baron-Cohen, "We need to change how we view autism," interview, Institute of Art and Ideas (How the Light Gets In), 14 August 2026
- kb: `Simon-Baren-Cohen_We-need-to-change-how-we-view-autism.md`
- verified: file (IAI header, date and speaker bio in seg 0; 7 segments; corpus filename misspells the surname "Baren")
- note: The E-S / Pattern Seekers author in his own voice: "if-and-then" pattern-seeking and the STEM link, the affective/cognitive empathy split, the "male brain / female brain" headlines called "totally misleading," masking in girls and women. Interview transcript, not peer-reviewed.

### batchelor-2012-a-secular-buddhism-jgb
- status: usable
- medium: text
- cite: Stephen Batchelor, "A Secular Buddhism," *Journal of Global Buddhism* 13 (2012): 87–107
- kb: `batchelor-higgins_a-secular-buddhism-and-its-analysis_2012-2017.md` (attributed summary, staged at workshops/DD/sources/ — not yet folded into corpus)
- verified: web (globalbuddhism.org, diamond OA)
- note: attributed summary note with verified page anchors, shared with the Higgins entry. The programmatic founding document of 'secular dharma': three senses of 'secular'; Four Noble Truths recast as four tasks; 'Buddhism 2.0' coined here with a 'touch of irony' (p. 91). ▲ Partisan witness the project is personally close to — flag per bias policy. Distinct work from the KB's Batchelor lecture transcripts.

### batchelor-wellington-talk-nirvana-mcmindfulness-ethics
- status: usable
- medium: transcript
- cite: Stephen Batchelor, "Nirvana, McMindfulness and Ethics," talk to One Mindful Breath, Wellington (YouTube, undated; the host dates his previous visit to 2012)
- kb: `Stephen-Batchelor-on-Nirvana-McMindfulness-and-Ethics.transcript.txt`
- verified: file (host's introduction in seg 0 names venue and prior 2012 visit; 15 segments; LLM-cleaned transcript)
- note: Batchelor's rebuttal of the McMindfulness argument as "overly simplistic"; prison chaplaincy and British Army symposium anecdotes; "a secular dharma should be open to the whole world."

### baumard-hyafil-boyer-2015-what-changed-during-the-axial-age
- status: usable
- medium: text
- cite: Nicolas Baumard, Alexandre Hyafil & Pascal Boyer, "What changed during the axial age: Cognitive styles or reward systems?", *Communicative & Integrative Biology* 8:5 (2015), e1046657 — addendum to Baumard, Hyafil, Morris & Boyer, *Current Biology* 25 (2015), 10–15
- kb: `Baumard-Hyafil-Boyer_What-Changed-During-the-Axial-Age_CIB-2015.md`
- verified: file (journal masthead, volume and article number at seg 2; reference list segs 6–8)
- note: The authors' own framing of the affluence hypothesis as a rival *definition* of the Axial Age (reward orientation vs cognitive style) and their scope restriction to an elite interest.

### beheim-et-al-2021-treatment-of-missing-data-moralizing-gods
- status: usable
- medium: text
- cite: Bret Beheim, Quentin D Atkinson, Joseph Bulbulia, Will Gervais, Russell D Gray, Joseph Henrich, Martin Lang, M Willis Monroe, Michael Muthukrishna, Ara Norenzayan, Benjamin Grant Purzycki, Azim Shariff, Edward Slingerland, Rachel Spicer & Aiyana K Willard, "Treatment of missing data determined conclusions regarding moralizing gods," *Nature* 595 (2021), E29–E34 — corpus holds the 2020 preprint
- kb: `Beheim-et-al_Treatment-of-Missing-Data-Seshat-Critique_preprint-2020.md`
- verified: file (title and author list at seg 0; published venue from the *Nature* retraction note's reference 1, not re-checked online)
- note: The Matters Arising showing that recoding unknowns as absences produced the "complex societies precede moralizing gods" result.

### bellah-2011-religion-in-human-evolution
- status: usable
- medium: text
- cite: Robert N Bellah, *Religion in Human Evolution: From the Paleolithic to the Axial Age* (Cambridge, MA: Belknap/Harvard, 2011), ISBN 978-0-674-06143-9
- kb: `Bellah_Religion-in-Human-Evolution_2011.md`
- verified: file (running heads "God and King", "China in the Late First Millennium bce" with page numbers at :326, :356, :557; ligature artefacts "Th e" indicate a digital PDF, not OCR)
- note: Archaic/axial synthesis; reports Assmann's three-level ma'at and "connective justice," Jacobsen's cosmos-as-state, and the *Analects'* Dao as the Way of the former kings. Likely to serve 2.1 and 2.2 as well.

### benda-castles-1969-the-samin-movement
- status: usable
- medium: text
- cite: Harry J Benda & Lance Castles, "The Samin Movement," *Bijdragen tot de Taal-, Land- en Volkenkunde* 125:2 (1969): 207–240, DOI 10.1163/22134379-90002844
- kb: `Benda-Castles_The-Samin-Movement_BKI-1969.md`, `H-Benda+L-Castles_The-Samin-Movement.md` (earlier copy under staging.text/samin/)
- verified: file (KITLV PDF header with journal, volume and pages at seg 0; running heads "HARRY J. BENDA AND LANCE CASTLES" with page numbers)
- note: The canonical English study; the illiteracy finding, "probably in 1859", the 1897 houtvesterijen, the 1907 arrests and exile ("died in exile at Padang, Sumatra, in 1914"). Born-digital KITLV text with some Dutch-typesetting OCR residue ("economie", "feit").

### berlin-1958-two-concepts-of-liberty
- status: usable
- medium: text
- cite: Isaiah Berlin, *Two Concepts of Liberty* (Oxford: Clarendon Press, 1958); Isaiah Berlin Virtual Library text with original pagination
- kb: `Berlin_Two-Concepts-of-Liberty_1958.md`
- verified: file (Virtual Library header and bracketed page numbers at seg 0; negative-liberty definition seg 3, "real self" passages segs 15–16)
- note: The classic defence of negative liberty and the anatomy of positive liberty's slide into collective coercion.

### berlin-1988-the-pursuit-of-the-ideal
- status: usable
- medium: text
- cite: Isaiah Berlin, "The Pursuit of the Ideal" (Agnelli Prize address, Turin, 15 February 1988), in *The Crooked Timber of Humanity: Chapters in the History of Ideas*, ed. Henry Hardy, 2nd ed. (Princeton University Press, 2013), pp. 1–20
- kb: `Berlin_The-Pursuit-of-the-Ideal_1988.md`
- verified: file (headnote at seg 0 gives the 1988 Turin occasion and "second edition" provenance; running heads "THE PURSUIT OF THE IDEAL"; the pluralism-vs-relativism passage at seg 10)
- note: Berlin's own statement of value pluralism against relativism — "a world of objective values… many. But not infinitely many".

### blair-2013-neurobiology-of-psychopathic-traits-in-youths
- status: usable
- medium: text
- cite: R James R Blair, "The neurobiology of psychopathic traits in youths," *Nature Reviews Neuroscience* 14 (2013), 786–799, DOI 10.1038/nrn3577
- kb: `Blair_The-Neurobiology-of-Psychopathic-Traits-in-Youths_NatRevNeurosci-2013.md`
- verified: file (title, author affiliation and abstract at seg 0; volume/pages/DOI from the published record, not web-checked)
- note: The two-impairment model for CU youth: reduced amygdala responsiveness to distress cues; vmPFC/striatal decision-making deficits.

### bodhi-2011-what-does-mindfulness-really-mean
- status: usable
- medium: text
- cite: Bhikkhu Bodhi, "What Does Mindfulness Really Mean? A Canonical Perspective," *Contemporary Buddhism* 12:1 (2011), 19–39, DOI 10.1080/14639947.2011.564813
- kb: `Bodhi_What-Does-Mindfulness-Really-Mean-A-Canonical-Perspective_2011.md`
- verified: file (journal masthead and DOI in seg 1; 26 segments)
- note: Canonical philology of sati (path factor, "guarantor" of the other factors; reservations about "bare attention") ending with an explicit licence to clinical extraction — "the right to take what they need" — under a reminder of the "sanctuary."

### bodhi-2015-facing-the-great-divide
- status: usable
- medium: text
- cite: Bhikkhu Bodhi, "Facing the Great Divide," *Inquiring Mind* 31:2 (Spring 2015)
- kb: `Bodhi_Facing-the-Great-Divide_InquiringMind-2015.md`
- verified: file (masthead "Spring 2015 Vol. 31 #2" and byline at seg 0; born-digital web capture)
- note: The Theravāda traditionalist statement of the Classical/Secular divide — secular Buddhism as "a rupture with Buddhist tradition"; the counterweight to Batchelor on grain vs accretion. Cited by DD note 3.5.4.

### boehm-1999-hierarchy
- status: usable
- medium: text
- cite: Christopher Boehm, *Hierarchy in the Forest: The Evolution of Egalitarian Behavior* (Harvard University Press, 1999)
- kb: `Christopher-Boehm_Hierarchy-in-the-Forest_The-Evolution-of-Egalitarian-Behavior_HarvardUP-1999.md`, `04-chapter.md`
- verified: web (ISBN 978-0-674-39031-7)
- note: reverse dominance hierarchy; foragers as moral communities. Cited by DD note 7.3.

### bookchin-1997-reader
- status: usable
- medium: text
- cite: Murray Bookchin, *The Murray Bookchin Reader*, ed. Janet Biehl (Cassell, 1997)
- kb: `Murray-Bookchin_The-Murray-Bookchin-Reader_1999.md`
- verified: web (ISBN 978-0-304-33874-0 pbk / 978-0-304-33873-3 hbk; Cassell, London 1997 — Blackwell's, AbeBooks, WorldCat)
- note: hierarchy precedes class; gerontocracy/patriarchy/priestly guilds as first hierarchies; domination of nature projected from domination of human by human. ▲ Mixed authorship — Biehl's editorial synopses frame excerpts of Bookchin's own texts; any quotation must be attributed to the right voice (note 7.3 marks this in-text). KB filename says 1999 (Black Rose reprint); first edition Cassell 1997. Cited by DD note 7.3.

### bookchin-brecher-1973-post-affluence-anarchy
- status: usable
- medium: text
- cite: Murray Bookchin & Jeremy Brecher, "Post-Affluence Anarchy: A Dialogue" (1973) — Brecher's review of *Post-Scarcity Anarchism* (Ramparts Press, 1971), Bookchin's reply, and Brecher's rejoinder
- kb: `Murray-Bookchin+Jeremy-Brecher_Post-Affluence-Anarchy-a-Dialogue_1973.md`
- verified: partial (Ramparts Press 1971 for the book under review is stated in-file; the 1973 dialogue's venue is inferred from in-file internal evidence pointing to *Root & Branch* — Bookchin addresses "the *Root and Branch* people" directly; venue not independently web-confirmed)
- note: the post-scarcity thesis carried inside its own strongest rebuttal — Brecher: projections are "science fiction," and the youth post-scarcity lifestyle ran "on the basis of parental subsidy, educational advantage, personal connections, and other forms of privilege" ("simulate 'post-scarcity'"). ▲ The thesis-statement quoted in note 6.3 is Brecher's paraphrase of Bookchin, and Bookchin protests "selective quoting" in his reply — cite as dialogue, not as Bookchin's own text. A future pass should check against `Murray-Bookchin_The-Murray-Bookchin-Reader_1999.md` (in-corpus) for Bookchin's own wording. Quotations verified verbatim against the staging.text file (segs 1, 7, 22, 26, 36). Cited by DD note 7.3.

### bookchin-foreman-1991-defending-the-earth
- status: usable
- medium: text
- cite: Murray Bookchin & Dave Foreman, *Defending the Earth: A Dialogue Between Murray Bookchin and Dave Foreman*, ed. Steve Chase (Boston: South End Press, 1991), 147 pp. — transcript of the Learning Alliance public dialogue, New York, November 1989
- kb: `Murray-Bookchin+Dave-Foreman_Defending-the-Earth-a-Debate_1991.md`
- verified: web (South End Press 1991, ed. Steve Chase, ISBN 0-89608-383-7 / 0-89608-382-9, 147 pp. — confirmed via the *Bulletin of Science, Technology & Society* review record at https://journals.sagepub.com/doi/abs/10.1177/027046769301300212 and the Internet Archive scan https://archive.org/details/DefendingTheEarth_201809; full text also at https://theanarchistlibrary.org/library/murray-bookchin-and-dave-foreman-defending-the-earth-a-debate. All quotations additionally checked against staging.text.)
- note: the primary text for the social-ecology vs deep-ecology grounding dispute — whether the ecological crisis follows from human hierarchy or from human numbers and presence as such. Both principals speak at length in their own words; the KB file carries Foreman's own chapter ("Second Thoughts of an Eco-Warrior") including his retraction of the 1986 Ethiopia and immigration remarks, so the deep-ecology side can be quoted *from* rather than only quoted *against*. ▲ Framing caution: the volume is edited by a social ecologist (Steve Chase) and published by a left press; Chase's 30-page introduction argues the social-ecology case before either principal speaks. Treat the deep-ecology position here as reconstructed inside its opponent's book — Naess, Sessions, Devall and Fox are absent from the corpus. Cited in 8.1 [S20].

### botero-et-al-2014-ecology-of-religious-beliefs
- status: usable
- medium: text
- cite: Carlos A Botero, Beth Gardner, Kathryn R Kirby, Joseph Bulbulia, Michael C Gavin & Russell D Gray, "The ecology of religious beliefs," *PNAS* 111:47 (2014), 16784–16789, DOI 10.1073/pnas.1408701111
- kb: `Botero-et-al_The-Ecology-of-Religious-Beliefs_PNAS-2014.md`
- verified: file (authors and affiliations at seg 0; n = 583 and result sentences at segs 0 and 4)
- note: Cross-sectional ecological analysis: moralizing high gods more prevalent under ecological duress and in politically complex, property-recognising societies. Not a longitudinal secularisation finding.

### boy-torpey-2013-inventing-the-axial-age
- status: usable
- medium: text
- cite: John D Boy & John Torpey, "Inventing the Axial Age: The Origins and Uses of a Historical Concept," *Theory and Society* 42:3 (2013), 241–259
- kb: `Boy-Torpey_Inventing-the-Axial-Age_2013.md`
- verified: file (running head "Theor Soc" at seg 13; Jaspers 1953 p. 23 citation and Assmann 1989/1990 citations in-text; volume/pages from the published article, not re-checked online)
- note: Sociology-of-knowledge history of the concept — Weber's world-religions studies as precursor, Jaspers's anti-Hegelian motive, Eurasiancentrism and diffusionism, the Assmanns' critiques, Morris's "second-wave" axiality.

### boyer-2001-religion-explained
- status: usable
- medium: text-ocr
- cite: Pascal Boyer, *Religion Explained: The Evolutionary Origins of Religious Thought* (New York: Basic Books, 2001), ISBN 0-465-00695-7
- kb: `Boyer_Religion-Explained_2001.md`
- verified: file (tesseract OCR provenance header and subtitle at seg 0; chapter structure matches the printed edition)
- note: Cognitive science of religion — selection among concept variants "inside each individual mind"; counterintuitive ("counterontological") concepts as the transmissible ones. OCR: the label "minimally counterintuitive" is not string-locatable; cite print for it.

### brian-morris-1998-anthropology-and-anarchism
- status: usable
- medium: text
- cite: Brian Morris, "Anthropology and Anarchism: Learning from Stateless Societies," *Anarchy: A Journal of Desire Armed* #45, Vol. 16 No. 1 (Spring/Summer 1998); repr. in *Anthropology, Ecology, and Anarchism: A Brian Morris Reader* (PM Press, 2015)
- kb: `Brian-Morris_Anthropology-and-Anarchism_Learning-from-Stateless-Societies_1998.md`
- verified: web (Anarchist Library; PM Press reader contents)
- note: the "elective affinity" of anthropology and anarchism; used in 4.3 solely for the internal anarchist critique of primitivist projection (Zerzan's "illusory images of Green primitivism," via Bookchin and Ellen).

### brian-morris-2007-people-without-government
- status: usable
- medium: text
- cite: Brian Morris, "People Without Government," *Anarchy: A Journal of Desire Armed* #63 (Spring/Summer 2007); repr. in *Anthropology, Ecology, and Anarchism: A Brian Morris Reader* (Oakland: PM Press, 2015)
- kb: `Brian-Morris_People-Without-Government_2007.md`
- verified: web (Anarchist Library; PM Press reader contents list "People without Government (2007)")
- note: anarchist synthesis of Clastres, Silberbauer, Harris, Overing on stateless societies; procedural machinery of unwritten orders (consensus, chief-without-coercion, own-kill taboo); also corrects romanticism (!Kung not "peaceful paragons"; critique of ecofeminist matriarchy myth). Secondary synthesis of others' fieldwork.

### brian-morris-2008-basic-kropotkin
- status: usable
- medium: text
- cite: Brian Morris, *Basic Kropotkin: Kropotkin and the History of Anarchism* (Anarchist Federation, Anarchist Communist Editions pamphlet no. 17, October 2008)
- kb: `Brian-Morris_Basic-Kropotkin_Kropotkin-and-the-History-of-Anarchism_2008.md`
- verified: web — publisher and pamphlet number confirmed via The Anarchist Library and libcom.org (AFed ACE #17, Nov 2008 announcement)
- note: scholarly outside arc — 1871–72 First International split as origin; Marshall's "river"/"libertarian impulse" historiography; afterlife of Kropotkin's ideas in ecology, feminism, Bookchin, Foucault, Deleuze. Sympathetic (anarchist press), not neutral.

### brian-morris-2022-kropotkins-ecology
- status: usable
- medium: text
- cite: Brian Morris, "Kropotkin's ecology" (22 January 2022)
- kb: `Brian-Morris_Kropotkins-Ecology_2022.md`
- verified: web (text and date confirmed at https://theanarchistlibrary.org/library/brian-morris-kropotkin-s-ecology and https://www.anarchistfederation.net/brian-morris-kropotkins-ecology-2/; ▲ some listings attribute first publication to *The Ecologist*, 22 January 2022 — the venue is not confirmed by the archived text itself, so the date alone is asserted.)
- note: short survey of Kropotkin as evolutionary naturalist, geographer and ethicist; mutual aid against the Huxley/Social-Darwinist reading; three tenets of an ecological society. Used in 8.1 only for the anti-statist counter to Green New Deal governance optimism ("the capitalist state rather than being the solution to the ecological crisis was in fact the cause of it"), which is framed as what Kropotkin *would have* insisted — a counterfactual attribution, flagged as such in the note. Cited in 8.1 [S23].

### brian-morris-ecology-recuperation-by-capitalists
- status: usable
- medium: text
- cite: Brian Morris, "Ecology and its recuperation by capitalists," orig. *Freedom* (London); text as archived at libcom.org / The Anarchist Library (retrieved there 25 May 2010)
- kb: `Brian-Morris_Ecology-and-its-Recuperation-by-Capitalists.md`
- verified: web (https://theanarchistlibrary.org/library/brian-morris-ecology-and-its-recuperation-by-capitalists — authorship, *Freedom* provenance and text confirmed; ▲ no publication year is given by the source, and none should be asserted. Mirrored at https://libcom.org/article/ecology-and-its-recuperation-capitalists.)
- note: the named failure mode of a green ethic absorbed by the system it was meant to constrain — corporations "leapt aboard the green bandwagon"; "sustainable development" as sustaining capitalist growth; responsibility relocated onto individual consumers; "global management" and eco-technocracy; Sachs's line that "saving" the planet licenses "a new wave of state interventions." Short piece (4 segments), polemical register, no citations of its own beyond Bookchin, Kovel and Sachs. Cited in 8.1 [S21].

### britton-2019-too-much-of-a-good-thing
- status: usable
- medium: text
- cite: Willoughby B Britton, "Can mindfulness be too much of a good thing? The value of a middle way," *Current Opinion in Psychology* 28 (2019), 159–165, DOI 10.1016/j.copsyc.2018.12.011
- kb: `Britton_Can-Mindfulness-Be-Too-Much-of-a-Good-Thing_CurrOpinPsychol-2019.md`
- verified: file (accepted-manuscript header and abstract at segs 0–1; volume/pages from the published record)
- note: Non-monotonic (inverted-U) model of mindfulness processes, decentering included. Cited by DD note 5.1.

### britton-et-al-2021-meditation-related-adverse-effects
- status: usable
- medium: text
- cite: Willoughby B Britton, Jared R Lindahl, David J Cooper, Nicholas K Canby & Roman Palitsky, "Defining and Measuring Meditation-Related Adverse Effects in Mindfulness-Based Programs," *Clinical Psychological Science* 9:6 (2021), 1185–1201, DOI 10.1177/2167702621996340
- kb: `Britton-et-al_Defining-and-Measuring-Meditation-Related-Adverse-Effects_CPS-2021.md`
- verified: file (abstract with MedEx-I figures at seg 0; journal/volume/pages from the published record, not web-checked)
- note: The measured side-effect rates after an 8-week MBP (83% / 58% / 37% / 6–14% lasting). Cited by DD note 5.1.

### brown-2004-human-universals-daedalus
- status: usable
- medium: text
- cite: Donald E Brown, "Human Universals, Human Nature, Human Culture," *Daedalus* 133:4 (2004): 47–54
- kb: `Brown_Human-Universals-Human-Nature-Human-Culture_Daedalus-2004.md`
- verified: file (title/author and abstract in seg 0; copyright line "© Donald E. Brown" in seg 7)
- note: Brown's own restatement of the universals programme; the list (cooperation, reciprocity, exchange, gossip, ethnocentrism) but not the 1991 book's "constant ethical patterns" phrasing.

### brown-et-al-2022-stoic-training-medical-students
- status: usable
- medium: text
- cite: Megan E L Brown, Alexander MacLellan, William Laughey, Usmaan Omer, Ghita Himmi, Tim LeBon & Gabrielle M Finn, "Can stoic training develop medical student empathy and resilience? A mixed-methods study," *BMC Medical Education* 22:340 (2022), DOI 10.1186/s12909-022-03391-x (CC BY)
- kb: `Brown-et-al_Can-Stoic-Training-Develop-Medical-Student-Empathy-and-Resilience_BMCMedEduc-2022.md`
- verified: file (journal header, DOI and licence in segs 0–1)
- note: The one trial of modern Stoic training as practice in the corpus: n = 24, twelve online days, "quantitatively, results were mixed."

### bullivant-et-al-2019-understanding-unbelief
- status: usable
- medium: text
- cite: Stephen Bullivant, Miguel Farias, Jonathan Lanman & Lois Lee, *Understanding Unbelief: Atheists and agnostics around the world — Interim findings from 2019 research in Brazil, China, Denmark, Japan, the United Kingdom and the United States* (St Mary's University, Twickenham, 2019)
- kb: `Lee-et-al_Atheists-and-Agnostics-Around-the-World_UnderstandingUnbelief-2019.md`
- verified: file (eight key findings at segs 0–1; methodology and St Mary's attribution at seg 4; the corpus filename leads with Lee, the report's author order is Bullivant, Farias, Lanman, Lee)
- note: Six-country survey of atheists and agnostics — diversity of unbelief, residual religious affiliation, and endorsement of objective moral values at population rates.

### burnet-1920-early-greek-philosophy
- status: usable
- medium: text-ocr
- cite: John Burnet, *Early Greek Philosophy*, 3rd ed. (London: A & C Black, 1920)
- kb: `Burnet_Early-Greek-Philosophy_3rd-ed-1920.md`
- verified: file (running head "HERAKLEITOS OF EPHESOS 133" at :182; fragment numbering matches Burnet's)
- note: Burnet renders *logos* as "Word"; fragments cited by his numbers (fr. 2 at :182). Public domain.

### candraningrum-2019-magic-of-dukun-jani-neo-saminism
- status: usable
- medium: text-ocr
- cite: Dewi Candraningrum, "The Magic of Dukun Jani and the Revival of Neo-Saminism in Sedulur Sikep," *Salasika: Indonesian Journal of Gender, Women, Child, and Social Inclusion's Studies* 2:1 (2019)
- kb: `Candraningrum_The-Magic-of-Dukun-Jani-and-the-Revival-of-Neo-Saminism_Salasika-2019.md`
- verified: file (OCR provenance header: pages 1 and 28 transcribed only; abstract at seg 0; running head with title and author at segs 2, 5)
- note: ▲ Partial OCR. JMPPK under Gunretno; ecology defended "extraterritorially"; "humans are the earth, and the earth is humans."

### choi-bowles-2007-coevolution-of-parochial-altruism-and-war
- status: usable
- medium: text
- cite: Jung-Kyoo Choi & Samuel Bowles, "The Coevolution of Parochial Altruism and War," *Science* 318:5850 (2007), 636–640, DOI 10.1126/science.1144237
- kb: `Choi-Bowles_The-Coevolution-of-Parochial-Altruism-and-War_Science-2007.md`
- verified: file (abstract and opening at seg 3; ▲ segs 0–2 are a page-bleed from an unrelated Science article on thermokarst-lake methane — cite from seg 3 onward)
- note: Game-theoretic and agent-based model: parochialism and altruism coevolve via intergroup conflict; the source of the "dark twin" claim.

### cicero-de-re-publica-de-legibus-barham
- status: usable
- medium: text
- cite: Marcus Tullius Cicero, *De Re Publica* (Book 3 'true law' fragment, via Lactantius) and *De Legibus* (Book 1), trans. Francis Barham, *The Political Works of M. T. Cicero* (London: Edmund Spettigue, 1841–42; Online Library of Liberty edition)
- kb: `Cicero_De-Re-Publica_trans-Barham_OLL.md`, `Cicero_De-Legibus_trans-Barham_OLL.md` (full text, folded into the corpus 2026-08); `cicero-aquinas_natural-law-primary-texts.md` (attributed summary, in corpus under staging.text/DD/sources/oldsources/)
- verified: web (oll.libertyfund.org; public domain)
- note: attributed summary note with verified page anchors, shared with the Aquinas entry. ▲ Barham's rendering differs from the modern textbook wording ('There is a true law, a right reason, conformable to nature…') and interpolates 'our own conscience' absent from the Latin — quote Barham as Barham. Full text in DD local archive (scratch/sources/part1/, gitignored).

### clastres-1989-society-against-the-state
- status: usable
- medium: text
- cite: Pierre Clastres, *Society Against the State: Essays in Political Anthropology*, trans. Robert Hurley with Abe Stein (New York: Zone Books, 1989; French orig. *La Société contre l'État*, Minuit, 1974)
- kb: `Pierre-Clastres_Society-Against-the-State_Essays-in-Political-Anthropology_1989.md`
- verified: file (clean digital text; chieftainship essay at segs 24–40, Aché own-kill taboo at seg 116, closing "Society Against the State" essay at seg 211; edition/translator not re-checked against a title-page segment)
- note: The primary behind Morris's synthesis — chief "has no authority at his disposal, no power of coercion, no means of giving an order"; generosity as "bondage"; the Huxley fewest-possessions line is reported, not Clastres's own.

### cleckley-1988-mask-of-sanity
- status: usable
- medium: text-ocr
- cite: Hervey Cleckley, *The Mask of Sanity: An Attempt to Clarify Some Issues About the So-Called Psychopathic Personality*, 5th ed. (Augusta, GA: privately printed / Emily S Cleckley, 1988; 1st ed. St Louis: Mosby, 1941)
- kb: `Cleckley_The-Mask-of-Sanity_5th-ed-1988.md`
- verified: file (tesseract OCR; title page at seg 0 names the fifth edition; the sixteen-criterion list at segs 407–408 matches the printed §44)
- note: Origin of the clinical construct; the sixteen criteria in the author's own list and the "looks like the real thing" mask description. OCR scan — pointer, verify wording against print before quoting.

### colin-ward-1966-theory-of-organization
- status: usable
- medium: text
- cite: Colin Ward, "Anarchism as a Theory of Organization" (1966), first published in Leonard I. Krimerman & Lewis Perry (eds.), *Patterns of Anarchy* (New York: Anchor Books, 1966)
- kb: `Colin-Ward_Anarchism-as-a-Theory-of-Organization_1966.md`
- verified: web (theanarchistlibrary.org; panarchy.org; c4ss.org — all give the *Patterns of Anarchy* 1966 provenance; no ISBN checked)
- note: the explicit anti-institutionalisation design spec — organisations should be "(1) voluntary, (2) functional, (3) temporary, and (4) small", because "permanence is one of those factors which harden the arteries of an organisation". Also the "theory of spontaneous order" and the Peckham/Little Commonwealth cases. Used in 2.4 for designed impermanence as a transmission strategy.

### colin-ward-1973-anarchy-in-action
- status: usable
- medium: text
- cite: Colin Ward, *Anarchy in Action* (London: Allen & Unwin, 1973; corpus text from the Freedom Press second edition, 1996 printing)
- kb: `Colin-Ward_Anarchy-in-Action_1996.md`
- verified: web (Allen & Unwin 1973 first edition and Freedom Press second-edition history; already externally pinned as [E9] in note 0.2). The 1996 date is the corpus file's own; the file's introduction is the second-edition text.
- note: the "seed beneath the snow" thesis — anarchy as "a description of a mode of human organisation, rooted in the experience of everyday life," discovered and extended rather than designed; also the negative evidence (defeat everywhere, "anarchism finally died when Franco's troops entered Barcelona in 1939"; Quail epigraph on growth/decline with popular self-activity). Ward himself concedes the book is open to the charge of "a selective gathering of anecdotal evidence" — advocacy, flagged as such. Cited by DD note 8.3.

### collier-hidalgo-maciuceanu-2006-essentially-contested-concepts
- status: usable
- medium: text
- cite: David Collier, Fernando Daniel Hidalgo & Andra Olivia Maciuceanu, "Essentially Contested Concepts: Debates and Applications," *Journal of Political Ideologies* 11:3 (2006), 211–246, DOI 10.1080/13569310600923782
- kb: `Collier-Hidalgo-Maciuceanu_Essentially-Contested-Concepts_2006.md`
- verified: file (title, authors, abstract at seg 0; running page numbers 214, 217, 219 in segs 5, 9, 12 match the JPI pagination)
- note: Systematic review of Gallie's seven criteria as a framework, with the over-aggregation/disaggregation test and Freeden's decontestation; applications to democracy and rule of law.

### coronado-montoya-et-al-2016-reporting-of-positive-results-mindfulness-rcts
- status: usable
- medium: text
- cite: Stephanie Coronado-Montoya, Alexander W Levis, Linda Kwakkenbos, Russell J Steele, Erick H Turner & Brett D Thombs, "Reporting of positive results in randomized controlled trials of mindfulness-based mental health interventions," *PLoS ONE* 11:4 (2016), e0153220
- kb: `CoronadoMontoya-et-al_Reporting-of-Positive-Results-in-RCTs-of-Mindfulness_PLoSONE-2016.md`
- verified: file (results at seg 1: 108 of 124 trials positive, 1.6× expected; 13 of 21 registrations unpublished; article number from the published record, not web-checked)
- note: Publication and reporting bias in the mindfulness RCT literature; the 108-of-124 figure.

### corr-et-al-2015-no-connection-individual-altruism-parochialism
- status: usable
- medium: text
- cite: Philip J Corr, Shaun P Hargreaves Heap, Charles R Seger & Kei Tsutsui, "An experiment on individual 'parochial altruism' revealing no connection between individual 'altruism' and individual 'parochialism'," *Frontiers in Psychology* 6 (2015), 1261, DOI 10.3389/fpsyg.2015.01261
- kb: `Corr-et-al_No-Connection-Between-Individual-Altruism-and-Parochialism_FrontPsych-2015.md`
- verified: file (title, authors, affiliations and abstract at seg 0; volume/article number from the published record)
- note: Public-goods and trust games: in-group pro-sociality does not predict in-group bias; Big-5 predictors differ — parochial altruism is a population pattern, not an individual trait.

### crawford-2018-tan-malaka
- status: usable
- medium: text
- cite: Oliver Crawford, *The Political Thought of Tan Malaka* (PhD dissertation, Trinity College, University of Cambridge, 2018)
- kb: `Oliver-Crawford_The-Political-Thought-of-Tan-Malaka_2018.md`
- verified: web (University of Cambridge Apollo repository)
- note: scholarship *about* Tan Malaka, cited by note 7.7 as [S11] — *Madilog* (1943) as a mentality-reconstruction programme, its spread as circulated manuscript rather than by decree, the countermanding of the 1926–27 insurrection and the 1948 Madiun condemnation, plus the honesty items (the racialised *bangsa* theory, "Aslia" expansionism, the prophetic self-image). ▲ Crawford's characterisations are not Tan Malaka's own words. Entry added 2026-07-27 to close a gap left by the 2026-07-24 pass, which cited the file without registering it. Cited by DD note 7.7.

### curry-jones-chesters-van-lissa-2019-mapping-morality-with-a-compass
- status: usable
- medium: text
- cite: Oliver Scott Curry, Matthew Jones Chesters & Caspar J Van Lissa, "Mapping morality with a compass: Testing the theory of morality-as-cooperation with a new questionnaire," *Journal of Research in Personality* 78 (2019), 106–124, DOI 10.1016/j.jrp.2018.10.008
- kb: `Curry-JonesChesters-VanLissa_Mapping-Morality-with-a-Compass_JRP-2019.md`
- verified: file (JRP header at seg 0; Study 2 MFQ test at seg 24; CFA fit at seg 22). ▲ The ingested file begins mid-introduction — the abstract's "MAC emerges as superior" is not in the chunks.
- note: The MAC-Q vs MFQ head-to-head; the direct test between the framework Part 1 runs on and the one Part 5 runs on.

### decety-cowell-2014-is-empathy-necessary-for-moral-behavior
- status: usable
- medium: text
- cite: Jean Decety & Jason M Cowell, "Friends or Foes: Is Empathy Necessary for Moral Behavior?", *Perspectives on Psychological Science* 9:4 (2014), 525–537
- kb: `Decety-Cowell_Friends-or-Foes-Is-Empathy-Necessary-for-Moral-Behavior_PPS-2014.md`
- verified: file (abstract at seg 0; "Published in final edited form as: Perspect Psychol Sci. 2014 September; 9(4): 525–537" at seg 1)
- note: Distinguishes emotional sharing, empathic concern and perspective taking; ties moral conduct to concern, not sharing — the empathy-literature version of Bloom's correction.

### deming-koenigs-2020-functional-neural-correlates-of-psychopathy
- status: usable
- medium: text
- cite: Philip Deming & Michael Koenigs, "Functional neural correlates of psychopathy: a meta-analysis of MRI data," *Translational Psychiatry* 10:133 (2020), DOI 10.1038/s41398-020-0816-8
- kb: `Deming-Koenigs_Functional-Neural-Correlates-of-Psychopathy-Meta-Analysis_TranslPsychiatry-2020.md`
- verified: file (journal header with DOI at seg 0)
- note: 25 fMRI studies / 460 foci; increased default-mode and medial-temporal (incl. amygdala) task activity, decreased dACC — "challenge predominant theories of amygdala hypoactivity."

### dhammika-1993-edicts-of-king-asoka
- status: usable
- medium: text
- cite: Ven. S Dhammika, *The Edicts of King Asoka: An English Rendering*, The Wheel Publication 386/387 (Kandy: Buddhist Publication Society, 1993; web edition © 1994)
- kb: `Dhammika_The-Edicts-of-King-Asoka_BPS-Wheel-386-387_1993.md`
- verified: file (born-digital web page with BPS/Access-to-Insight navigation and "© 1994" in seg 0; preface states dependence on Sen's translation with Sircar and Bhandarkar consulted; Rock Edicts 5, 6, 12, 14 at segs 10, 11, 14, 17)
- note: Popular but complete English rendering of the Major and Minor Rock and Pillar Edicts; a rendering, not a critical edition — pair with Hultzsch for wording disputes.

### ding-et-al-2023-therapy-of-desire-buddhism-stoicism
- status: usable
- medium: text
- cite: Xiaojun Ding, Yueyao Ma, Feng Yu & Lily M Abadal, "The Therapy of Desire in Times of Crisis: Lessons Learned from Buddhism and Stoicism," *Religions* 14:237 (2023), DOI 10.3390/rel14020237 (CC BY)
- kb: `Ding-et-al_The-Therapy-of-Desire-in-Times-of-Crisis-Buddhism-and-Stoicism_Religions-2023.md`
- verified: file (citation block with DOI and dates in seg 0)
- note: Buddhism and Stoicism paired as "philosophical therapy" for desire, via Hadot's spiritual exercises.

### doctorow-2021-how-to-destroy-surveillance-capitalism
- status: usable
- medium: text
- cite: Cory Doctorow, *How to Destroy Surveillance Capitalism* (Medium/OneZero, 2020; Stonesong Digital, 2021)
- kb: `Cory-Doctorow_How-to-Destroy-Surveillance-Capitalism_2021.md`
- verified: file (title and "by Cory Doctorow, 2020" at seg 0; "Domination" section at seg 9)
- note: The anti-monopoly sceptic of Zuboff's mind-control thesis: "little evidence" of bypassed rationality; monopoly as cause. Counterweight inside the critical camp.

### dumont-1972-homo-hierarchicus
- status: usable
- medium: text-ocr
- cite: Louis Dumont, *Homo Hierarchicus: The Caste System and Its Implications*, trans. Mark Sainsbury (London: Paladin, 1972; French orig. Gallimard 1966)
- kb: `Dumont_Homo-Hierarchicus_1972-Paladin.md`
- verified: file (tesseract OCR provenance header, pages 1–438, 5,010 low-confidence words marked; preface and introduction passages on hierarchy vs egalitarian ideology at segs 1, 5, 25, 27, 48)
- note: Hierarchy as a coherent value system and modern egalitarianism as "a declaration of faith" — the corpus's principal anthropological challenge to a universal floor. ▲ Low-quality scan; pointer only, verify any wording against print.

### dunbar-1993-coevolution-neocortex-group-size-language
- status: usable
- medium: text
- cite: RIM Dunbar, "Coevolution of neocortical size, group size and language in humans," *Behavioral and Brain Sciences* 16:4 (1993), 681–735
- kb: `Dunbar_Coevolution-of-Neocortical-Size-Group-Size-and-Language_BBS-1993.md`
- verified: file (header states it is the unedited BBS preprint with the printed reference; ~150 group-size examples at segs 11–12)
- note: Origin of "Dunbar's number"; the human figure is a regression extrapolation illustrated by ~150-sized communities, not a measured ceiling. Preprint, not the final typeset text.

### durkheim-1915-elementary-forms-swain
- status: usable
- medium: text-ocr
- cite: Émile Durkheim, *The Elementary Forms of the Religious Life*, trans. Joseph Ward Swain (London: George Allen & Unwin, 1915; French orig. 1912)
- kb: `Durkheim_The-Elementary-Forms-of-the-Religious-Life_Swain-trans-1915.md`, `Durkheim_The-Elementary-Forms-of-the-Religious-Life_Gutenberg-41360.txt` (born-digital Gutenberg text of the same translation), `Durkheim_The-Elementary-Forms-of-the-Religious-Life_trans-Swain_1915_OCR.md` (second OCR under 3-ritual-habituation/)
- verified: file (Introduction at seg 0; Book II ch. 7 §ii "society… is what a god is to his worshippers" at seg 205; Conclusion at seg 429)
- note: Society as the source of moral authority and the sacred; three copies in the corpus — prefer the Gutenberg text for quotation.

### dyble-2021-evolution-of-altruism-through-war-sensitive
- status: usable
- medium: text
- cite: Mark Dyble, "The evolution of altruism through war is highly sensitive to population structure and to civilian and fighter mortality," *PNAS* 118:23 (2021), e2011142118
- kb: `Dyble_Evolution-of-Altruism-Through-War-Sensitive-to-Population-Structure_PNAS-2021.md`
- verified: file (masthead, editor line and abstract at seg 0; FST result at seg 8)
- note: Re-runs Choi & Bowles under a wide parameter range; altruism does not evolve at empirically observed hunter-gatherer FST. A sensitivity critique, not a refutation of observed parochialism.

### efferson-lalive-fehr-2008-coevolution-cultural-groups-ingroup-favoritism
- status: usable
- medium: text
- cite: Charles Efferson, Rafael Lalive & Ernst Fehr, "The Coevolution of Cultural Groups and Ingroup Favoritism," *Science* 321:5897 (2008), 1844–1849, DOI 10.1126/science.1155805
- kb: `Efferson-Lalive-Fehr_The-Coevolution-of-Cultural-Groups-and-Ingroup-Favoritism_Science-2008.md`
- verified: file (title, authors and abstract at seg 0; volume/pages from the published record)
- note: Experimental: arbitrary symbolic markers become predictors of behaviour by solving coordination problems, generating in-group favouritism without conflict.

### emma-goldman-1897-marriage
- status: usable
- medium: text
- cite: Emma Goldman, "Marriage," *The Firebrand* (Portland, OR), 18 July 1897
- kb: `Emma-Goldman_Marriage_1897.md`
- verified: web (marxists.org Goldman archive; jwa.org — her first published writing on marriage)
- note: "If we want to accomplish Anarchy, we must first have free women" — women's freedom as precondition, not dividend, of the revolution. Cited by DD note 6.4.

### emma-goldman-1910-end-of-the-odyssey
- status: usable
- medium: text
- cite: Emma Goldman, "The End of the Odyssey", *Mother Earth*, 1910
- kb: `Emma-Goldman_The-End-of-the-Odyssey_1910.md`
- verified: unverified
- note: "Too bad Anarchists have no centralized authority, or we would have to excommunicate her" — orthodoxy-policing pressure satirised inside an anti-doctrinal movement.

### emma-goldman-1911-wollstonecraft
- status: usable
- medium: text
- cite: Emma Goldman, "Mary Wollstonecraft, Her Tragic Life and Her Passionate Struggle for Freedom" (1911 lecture manuscript; first published in Alice Wexler, "Emma Goldman on Mary Wollstonecraft," *Feminist Studies* 7:1 (1981), 113–133)
- kb: `Emma-Goldman_Mary-Wollstonecraft-Her-Tragic-Life-and-Her-Passionate-Struggle-for-Freedom_1911.md`
- verified: web (JSTOR 3177674; Feminist Studies 7:1, 1981)
- note: tells the suffrage movement of "the inadequacy of mere external gain as a means of freeing their sex" — her critique of the emancipation movement itself. Cited by DD note 6.4.

### emma-goldman-1914-marriage-and-love
- status: usable
- medium: text
- cite: Emma Goldman, "Marriage and Love," in *Anarchism and Other Essays* (Mother Earth Publishing Association, New York; 1st edn 1910, 2nd rev. edn 1911; corpus text dated 1914)
- kb: `Emma-Goldman_Marriage-and-Love_1914.md`
- verified: web (Wikipedia "Anarchism and Other Essays"; theanarchistlibrary.org full text)
- note: marriage as "an economic arrangement, an insurance pact"; sardonic critique of emancipation-as-wage-labour. Polemic — cite as her position. Cited by DD note 6.4.

### emma-goldman-1916-jealousy
- status: usable
- medium: text
- cite: Emma Goldman, "Jealousy: Causes and a Possible Cure" (lecture text, c. 1915–16; widely reprinted from the Emma Goldman Papers)
- kb: `Emma-Goldman_Jealousy-Causes-and-a-Possible-Cure.md`
- verified: unverified (first-publication venue not pinned down; internal evidence — "as I shall discuss variety and monogamy two weeks from tonight" — confirms a lecture script)
- note: grounds the anti-jealousy ethic in Morgan/Reclus "primitive" sexual-communism anthropology — dated science doing the work of scripture; attribute, never launder. Cited by DD note 6.4.

### emma-goldman-1923-louise-michel-hirschfeld
- status: usable
- medium: text
- cite: Emma Goldman, "Louise Michel" — refutation of Karl von Levetzow addressed to Dr. Magnus Hirschfeld, *Jahrbuch für sexuelle Zwischenstufen* 23 (1923), 70–92 (German title "Offener Brief an den Herausgeber der Jahrbücher über Louise Michel")
- kb: `Emma-Goldman_Louise-Michel_Letter-to-Magnus-Hirschfeld_1923.md`
- verified: web (magnus-hirschfeld.de Gedenken pages for Michel and Goldman; archive.org "emmagoldman1923"; theanarchistlibrary.org)
- note: ▲ read in period terms (Urning/Uranian, sexual "intermediates"). Explicit 1923 defence of homosexual rights AND refutation of the "masculine woman = invert" premise; her counter-case leans on re-certifying Michel's femininity — do not project modern categories, do not sanitise. Cited by DD note 6.4.

### emma-goldman-1923-my-disillusionment
- status: usable
- medium: text
- cite: Emma Goldman, *My Disillusionment in Russia* (Garden City, NY: Doubleday, Page & Co., 1923)
- kb: `Emma-Goldman_My-Disillusionment-in-Russia_1923.md`
- verified: web — Wikipedia and marxists.org Goldman archive confirm publisher, year, and the publisher's unauthorised truncation (last twelve chapters and Afterword cut; title changed from "My Two Years in Russia")
- note: primary supporter-turned-critic witness to the Soviet case; the prefaces carry the arc (defence tours 1917–18, Kronstadt as "the final wrench", departure December 1921) and the publication history in Goldman's own words. Cited in 7.7 as [S13].

### emma-goldman-1924-my-further-disillusionment
- status: usable
- medium: text
- cite: Emma Goldman, *My Further Disillusionment in Russia* (Garden City, NY: Doubleday, Page & Co., 1924)
- kb: `Emma-Goldman_My-Further-Disillusionment-in-Russia_1924.md`
- verified: web — Wikipedia, Project Gutenberg (#74192) and Wikisource confirm the 1924 Doubleday volume restoring the twelve cut chapters and the Afterword
- note: contains the Afterword — Goldman's means-determine-ends argument ("presently the aims and means become identical") — the mechanism cited in 7.7 for why Scott's third element (the coercive state) is decisive. Cited in 7.7 as [S14].

### emma-goldman-1925-heroic-women
- status: usable
- medium: text
- cite: Emma Goldman, "Heroic Women of the Russian Revolution" (lecture, Folk House, Bristol, 4 May 1925)
- kb: `Emma-Goldman_Heroic-Women-of-the-Russian-Revolution_1925.md`
- verified: web (theanarchistlibrary.org; olebirklaursen.wordpress.com scan of the 1925 text)
- note: deliberate counter-archive of women revolutionaries (Taratuta, Fanya Baron, Ratner, Kakhovskaia, Izmailovitch, Spiridonova); secular twin of the Therīgāthā's archival function. Also an anti-Bolshevik polemic — her framing throughout. Cited by DD note 6.4.

### emma-goldman-1931-living-my-life
- status: usable
- medium: text
- cite: Emma Goldman, *Living My Life* (Alfred A. Knopf, New York, 1931)
- kb: `Emma-Goldman_Living-My-Life_1931.md`
- verified: web (standard bibliography; theanarchistlibrary.org full text)
- note: autobiography, 1303 KB segments. Self-documented internal contradiction: the movement policing her dancing and her sex-question lectures (dance rebuke; Los Angeles comrades; Kropotkin exchange). Memoir written four decades after some events — treat dialogue as her reconstruction. Cited by DD note 6.4.

### emma-goldman-1933-has-my-life-been-worth-while
- status: usable
- medium: text
- cite: Emma Goldman, "Has My Life Been Worth While?", 30 January 1933
- kb: `Emma-Goldman_Has-My-Life-Been-Worth-While_1933.md`
- verified: unverified
- note: end-of-life retrospective in a frankly religious register — anarchism as "my inspiration and my highest goal", its "light... diminished".

### epictetus-discourses-enchiridion-long-pg10661
- status: usable
- medium: text
- cite: Epictetus, *The Discourses of Epictetus, with the Encheiridion and Fragments*, trans. George Long (1877; Project Gutenberg 10661 selections)
- kb: `Epictetus_Discourses-and-Enchiridion-selections_PG10661.txt`
- verified: file (Long's wording confirmed at seg 75, Discourses 2.18; the complete Discourses in Long's translation is a separate file, `Epictetus_The-Discourses-complete_trans-Long_1890.md`)
- note: Public-domain primary; Discourses 2.18 "Appearances, wait for me a little" is the Stoic metacognitive exercise.

### epictetus-enchiridion-carter-pg45109
- status: usable
- medium: text
- cite: Epictetus, *The Enchiridion*, trans. Elizabeth Carter (1758); Project Gutenberg #45109
- kb: `Epictetus_Enchiridion_trans-Carter_PG45109.txt`
- verified: file (Gutenberg text; §5 at seg 12; 51 segments)
- note: Public-domain translation; source of "Men are disturbed not by things, but by the views which they take of things."

### ernanda-2023-challenging-the-patriarchal-culture
- status: usable
- medium: text
- cite: Ernanda, "Challenging the patriarchal culture: Feminist critical discourse analysis of the Indonesian environmental heroines," *Wacana: Journal of the Humanities of Indonesia* 24:1 (2023), 58–83
- kb: `Ernanda_Challenging-the-Patriarchal-Culture-Indonesian-Environmental-Heroines_Wacana-2023.md`
- verified: file (title, abstract and running head "Wacana Vol. 24 No. 1 (2023)" at seg 0; interview dates at seg 12; page range from the running heads, not web-checked)
- note: Feminist CDA of the documentary *Tanah Ibu Kami*; Sukinah's "we were just housewives" and the Kendeng women as "the equivalent of Kartini"; State Ibuism and *kodrat* as the patriarchal frame.

### errico-malatesta-1884-the-economic-question
- status: usable
- medium: text
- cite: Errico Malatesta, "The Economic Question" (29 June 1884; trans. in *The Complete Works of Errico Malatesta*, AK Press)
- kb: `Errico-Malatesta_The-Economic-Question_1884.md`
- verified: unverified (date from the KB file header only; original Italian venue not confirmed, so no venue is asserted in the note)
- note: the materialist inversion — politics and religion "merely its reflections, perhaps even the shadows it casts"; "Economic inequality is the source of all moral, intellectual, political, etc. inequalities"; clergy as "the class of those who have ducked out of their labor obligations." Used in 6.3 as the limit case against the Polanyi embedding frame, reported not endorsed. Quotations verified verbatim against the staging.text file (segs 0, 1, 6).

### errico-malatesta-1889-about-a-strike
- status: usable
- medium: text
- cite: Errico Malatesta, "About a Strike" (1889, on the London dock strike)
- kb: `Errico-Malatesta_About-a-Strike_1889.md`
- verified: unverified (date from KB file header; the great London dock strike it describes is August–September 1889, consistent)
- note: strikers unloading hospital ice unpaid mid-strike; anarchists faulted for weighing the strike only as an "economic weapon" and failing to see it as "an index of moral rebellion" — cited in 6.3 as Malatesta's own evidence of a moral surplus his 1884 reduction cannot account for. Quotations verified verbatim against the staging.text file (segs 4, 7).

### errico-malatesta-1897-anarchisms-evolution
- status: usable
- medium: text
- cite: Errico Malatesta, "Anarchism's Evolution (Apropos of an Interview)", 14 October 1897
- kb: `Errico-Malatesta_Anarchisms-Evolution_Apropos-of-an-Interview_1897.md`
- verified: unverified (period essay; standard Malatesta bibliography)
- note: a founder narrating his movement's change over time; names the inherited "residue of Jacobinism" and Mazzinian illusions — participant testimony for grain and drift.

### errico-malatesta-1909-anarchists-and-the-situation
- status: usable
- medium: text
- cite: Errico Malatesta, "Anarchists and the Situation" (June 1909; written for an English readership, per the text's own coda)
- kb: `Errico-Malatesta_Anarchists-and-the-Situation_1909.md`
- verified: file (quotations checked against staging.text; not separately web-verified)
- note: pre-Michels prediction of movement bureaucratisation: syndicalism "cannot remain stationary" — either towards its ideal or into "a bureaucratic character… a factor in social conservation"; the "self-satisfied bureaucracy which will absorb the most intelligent and active elements among the proletariat." Cited in 7.1 [S14]. Cited by DD note 7.1.

### errico-malatesta-1912-capitalists-and-thieves
- status: usable
- medium: text
- cite: Errico Malatesta, "Capitalists and Thieves: Regarding the Tragedies in Houndsditch and Sidney Street" (June 1912)
- kb: `Errico-Malatesta_Capitalists-and-Thieves_Regarding-the-Tragedies-in-Houndsditch-and-Sidney-Street_1912.md`
- verified: unverified (date from KB file header; the Houndsditch robbery/Sidney Street siege context is December 1910/January 1911, consistent with a 1912 retrospective)
- note: collapses the property/theft moral distinction — "The capitalist is a thief who has succeeded… the thief is an aspiring capitalist"; survival-theft as "the most sacred of rights and the most imperious of duties." Quotations verified verbatim against the staging.text file (seg 1).

### errico-malatesta-1914-anarchists-have-forgotten
- status: usable
- medium: text
- cite: Errico Malatesta, "Anarchists Have Forgotten Their Principles," *Freedom* (London) 28:307, November 1914
- kb: `Errico-Malatesta_Anarchists-Have-Forgotten-Their-Principles_1914.md`
- verified: web (https://theanarchistlibrary.org/library/errico-malatesta-anarchists-have-forgotten-their-principles — venue *Freedom* vol. 28 no. 307 and the "bankruptcy… forgotten and betrayed" quotation confirmed)
- note: the clean principles-under-war-pressure case: rejects "revise our formulas" in favour of "forgotten and betrayed"; deeper national feeling is "one more reason for intensifying, not abandoning" the principle. Pairs with kropotkin-1916-manifesto-of-the-sixteen as the two sides of the split. Cited in 7.1 [S15]. Cited by DD note 7.1.

### errico-malatesta-1919-fabbri-letter
- status: usable
- medium: text
- cite: Errico Malatesta, "On the Dictatorship of the Proletariat: A Prophetic Letter to Luigi Fabbri" (letter, London, 30 July 1919; English trans. pub. 2005)
- kb: `Errico-Malatesta_On-the-Dictatorship-of-the-Proletariat_A-Prophetic-Letter-to-Luigi-Fabbri_2005.md`
- verified: web — full text at The Anarchist Library and marxists.org (Malatesta archive), both dating the letter London, 30 July 1919
- note: contemporaneous anarchist *prediction* of the Bolshevik dictatorship's outcome, made while explicitly declining to judge the news from Russia — evidence of foreseeability from design, not hindsight. ▲ The corpus also holds the same letter in an earlier English translation (`Errico-Malatesta_The-Dictatorship-of-the-Proletariat-and-Anarchy_1919.md`): one witness, two translations — do not register or count as an independent source. Cited in 7.7 as [S12]. Cited by DD note 7.7.

### errico-malatesta-1920-an-anarchist-programme
- status: usable
- medium: text
- cite: Errico Malatesta (draft), "An Anarchist Programme", adopted by the Unione Anarchica Italiana, Bologna congress, 1920
- kb: `Errico-Malatesta_An-Anarchist-Programme_1920.md`
- verified: web (The Anarchist Library / marxists.org confirm the 1920 UAI Bologna congress adoption)
- note: "equal liberty of everybody" as the sole limit on freedom; ideal achievable only "with the free consent of all". Used in 3.1 as [S12].

### errico-malatesta-1922-at-the-cafe
- status: usable
- medium: text
- cite: Errico Malatesta, *At the Café: Conversations on Anarchism* [1922], trans. Paul Nursey-Bray (Freedom Press, 2005), ISBN 9781904491064
- kb: `Errico-Malatesta_At-the-Café_Conversations-on-Anarchism_1922.md`
- verified: web (Freedom Press product page and Waterstones/AbeBooks listings confirm translator, publisher, year, ISBN)
- note: constructed dialogue — both voices are Malatesta's; the interlocutor's "submission of the individual to the collective" objection and its answer. Used in 3.1 as [S11].

### errico-malatesta-1926-communism-and-individualism
- status: usable
- medium: text
- cite: Errico Malatesta, "Communism and Individualism", *Pensiero e Volontà*, April 1926; repr. in *The Anarchist Revolution: Polemical Articles 1924–1931*, ed. Vernon Richards (Freedom Press, 1995)
- kb: `Errico-Malatesta_Communism-and-Individualism_1926.md`
- verified: web (The Anarchist Library entry confirms April 1926 origin as a reply to Max Nettlau and the Richards/Freedom Press 1995 reprint; <https://theanarchistlibrary.org/library/errico-malatesta-communism-and-individualism>)
- note: primary text arguing the individual–collective tension directly; source of the "greatest solidarity to enjoy the greatest liberty" formula and the "we are all individualists" premise. Used in 3.1 as [S10].

### errico-malatesta-1930-anarchists-present-time
- status: usable
- medium: text
- cite: Errico Malatesta, "The Anarchists in the Present Time", June 1930
- kb: `Errico-Malatesta_The-Anarchists-in-the-Present-Time_1930.md`
- verified: unverified (period essay; standard Malatesta bibliography)
- note: late-life revision — "the days are gone" when insurrection seemed sufficient; anarchy's triumph "by evolution, gradually".

### errico-malatesta-1931-apropos-of-revisionism
- status: usable
- medium: text
- cite: Errico Malatesta, "Apropos of 'Revisionism'", 1931
- kb: `Errico-Malatesta_Apropos-of-Revisionism_1931.md`
- verified: unverified (period essay; standard Malatesta bibliography)
- note: "no pontiffs in our ranks... the anarchist church"; sixty-year retrospective on founding illusions exposed by "harsh experience".

### errico-malatesta-anarchist-propaganda
- status: usable
- medium: text
- cite: Errico Malatesta, "Anarchist Propaganda" (kb file dated 1925; venue not established — the text discusses the daily *Umanità Nova*, and the piece circulates via Vernon Richards's *Malatesta: Life and Ideas*)
- kb: `Errico-Malatesta_Anarchist-Propaganda.md`
- verified: unverified (searched: no reliable web locus for original venue/date; *Umanità Nova* founded 1919, *Pensiero e Volontà* ran 1924–26 — either is possible. Cite the year with the file's caveat, not as established.)
- note: the movement's positive transmission doctrine — "a question of education for freedom"; the propagandist as the schoolteacher who helps "in such a way that the pupil imagines that he has found the solution unaided"; the party paper disowned as a central organ; and the failure condition, that "isolated, sporadic propaganda… is forgotten and lost before its effect can grow and bear fruit".

### fischer-xygalatas-et-al-2014-fire-walkers-high
- status: usable
- medium: text
- cite: Ronald Fischer, Dimitris Xygalatas, Panagiotis Mitkidis, Paul Reddish, Penny Tok, Ivana Konvalinka & Joseph Bulbulia, "The Fire-Walker's High: Affect and Physiological Responses in an Extreme Collective Ritual," *PLoS ONE* 9:2 (2014), e88355, DOI 10.1371/journal.pone.0088355
- kb: `Fischer-Xygalatas-et-al_The-Fire-Walkers-High_PLoSONE-2014.md`, `Fischer-Xygalatas-et-al_The-Fire-Walkers-High_PLOSONE-2014.md` (duplicate copy under 6-costly-signalling)
- verified: file (title and author list at seg 0; the two copies are the same paper)
- note: Affect and physiology in the firewalk; companion to Konvalinka 2011. Duplicate ingestion — cite the 3-ritual-habituation copy.

### fitouchi-andre-baumard-2023-moral-disciplining-puritanical-morality
- status: usable
- medium: text
- cite: Léo Fitouchi, Jean-Baptiste André & Nicolas Baumard, "Moral disciplining: The cognitive and evolutionary foundations of puritanical morality," *Behavioral and Brain Sciences* 46 (2023), e293 (HAL preprint hal-03899979, December 2022)
- kb: `Fitouchi-Andre-Baumard_Moral-Disciplining-Puritanical-Morality_BBS-2023.md`
- verified: file (HAL deposit header at seg 0; short and long abstracts at segs 1–2; BBS article number from the published record)
- note: Puritanical purity norms as pre-emptive moralisation of self-control risks to cooperation — morality-as-cooperation's answer to the "harmless wrongs" problem. Sibling files (RBB 2021, the 2022 clarification, the BBS response) sit under `6-costly-signalling/`.

### fitouchi-singh-andre-baumard-2023-mutual-policing
- status: usable
- medium: text
- cite: Léo Fitouchi, Manvir Singh, Jean-Baptiste André & Nicolas Baumard, "Prosocial religions as folk-technologies of mutual policing," *Psychological Review* (accepted manuscript, 2023; published 2024)
- kb: `Fitouchi-Singh-Andre-Baumard_Prosocial-Religions-as-Folk-Technologies-of-Mutual-Policing_2023.md`
- verified: file (accepted-manuscript header with citation instruction at seg 0; abstract at seg 1; journal volume/pages not checked)
- note: Supernatural punishment beliefs as a folk technology of mutual policing, endorsed while believed necessary for others' cooperation; nine predictions reviewed.

### frankfort-et-al-1946-intellectual-adventure
- status: usable
- medium: text-ocr
- cite: H Frankfort, HA Frankfort, JA Wilson, T Jacobsen & WA Irwin, *The Intellectual Adventure of Ancient Man: An Essay on Speculative Thought in the Ancient Near East* (Chicago: University of Chicago Press, 1946); OI open-access scan
- kb: `Frankfort-et-al_The-Intellectual-Adventure-of-Ancient-Man_1946.md`
- verified: file (preface and chapter list at :1; "oi.uchicago.edu" running footer; Jacobsen "The Cosmos as a State" header at :131)
- note: The classic cross-civilisation treatment of cosmic order; Jacobsen's Egypt/Mesopotamia mood contrast and "cosmos as a state." OCR: Wilson's *ma'at* is not recoverable by string search — locate via "justice"/"order" context.

### frey-osborne-2013-the-future-of-employment
- status: usable
- medium: text
- cite: Carl Benedikt Frey & Michael A Osborne, *The Future of Employment: How Susceptible Are Jobs to Computerisation?* (Oxford Martin School working paper, 17 September 2013); published in *Technological Forecasting and Social Change* 114 (2017), 254–280, DOI 10.1016/j.techfore.2016.08.019
- kb: `Frey-Osborne_The-Future-of-Employment_OxfordMartin-2013.md`
- verified: file (title page and date at seg 0; 702-occupation appendix table with SOC codes and probabilities at segs 55–70; Computer Programmers 0.48 at seg 62)
- note: The 47-percent-at-risk study; its appendix gives the per-occupation computerisation probabilities used to show the technical niche's own precarity. Journal volume/pages from the published record, not web-checked.

### friedrich-nietzsche-1882-the-gay-science
- status: usable
- medium: text
- cite: Friedrich Nietzsche, *The Gay Science* (1882; Book V added 1887). Unattributed English translation; internal evidence (editorial note naming Petre/Cohn for the verse only, "Joyful Wisdom" framing) suggests the Oscar Levy *Complete Works* edition (Thomas Common, 1910), unverified.
- kb: `Friedrich-Nietzsche_The-Gay-Science_1882.md`
- verified: unverified
- note: translator unnamed in file — cite by § only, paraphrase only, no translation-sensitive word choices. Used in 3.4 for §116 (herd-instinct, community-relative moralities), §143 (polytheism as prototype of plural norms), §345 (both consensus→universalism and disagreement→relativism inferences dismissed). ▲ §345 also used by note 3.3 for the grounding question — same section, different claims. Cited by DD note 3.4.

### friedrich-nietzsche-1883-thus-spoke-zarathustra
- status: usable
- medium: text
- cite: Friedrich Nietzsche, *Thus Spoke Zarathustra: A Book for All and None* (1883–1891). Unattributed English translation; archaising register ("hangeth", "valueth") matches the Levy-series Thomas Common rendering, unverified.
- kb: `Friedrich-Nietzsche_Thus-Spoke-Zarathustra_A-Book-for-All-and-None_1883.md`
- verified: unverified
- note: translator unnamed in file — cite by part and chapter title, paraphrase only. Used in 3.4 for Part I, "The Thousand and One Goals" (plural created tables of value; humanity's one goal still lacking). File contains the chapter twice (lines ~1212 and ~7824 — apparent duplicate text block within the file). Cited by DD note 3.4.

### friedrich-nietzsche-1886-beyond-good-and-evil
- status: usable
- medium: text
- cite: Friedrich Nietzsche, *Beyond Good and Evil: Prelude to a Philosophy of the Future* [*Jenseits von Gut und Böse*] (1886)
- kb: `Friedrich-Nietzsche_Beyond-Good-and-Evil_Prelude-to-a-Philosophy-of-the-Future_1886.md`
- verified: unverified
- note: translator unnamed; full-capital emphasis matches Helen Zimmern (Levy edition, Project Gutenberg circulation) — indication, not verification. Cited by § only (§186: the foundation-hunt takes morality as "given"; "the problem of morality itself has been omitted"). Cited by DD note 3.4.

### friedrich-nietzsche-1887-genealogy-of-morals
- status: usable
- medium: text
- cite: Friedrich Nietzsche, *The Genealogy of Morals: A Polemic* (1887). Unattributed English translation; register consistent with the Levy-series Horace B. Samuel rendering (1913), unverified.
- kb: `Friedrich-Nietzsche_The-Genealogy-of-Morals_A-Polemic_1887.md`
- verified: unverified
- note: translator unnamed in file — cite by essay and § only, paraphrase only. Used in 3.4 for Preface §6 (critique of the value of moral values; power-and-splendour-of-the-type standard) and the First Essay's concluding note (rank-order of values as the philosopher's task; majority-good denied intrinsic superiority). ▲ Preface §6 also used by note 3.3 — same section, different claims. Cited by DD note 3.4.

### friedrich-nietzsche-1888-twilight-of-the-idols
- status: usable
- medium: text
- cite: Friedrich Nietzsche, *Twilight of the Idols* [*Götzen-Dämmerung*] (written 1888, pub. 1889)
- kb: `Friedrich-Nietzsche_Twilight-of-the-Idols_1895.md`
- verified: unverified
- note: KB filename misdates the work (1895); frontmatter `year: 1888` is correct — do not reproduce 1895 in citations. Translator unnamed; section titles and phrasing ("Skirmishes of an Untimely Man", "prankishness", the "History of an Error" subtitle) match Walter Kaufmann's 1954 *Portable Nietzsche* rendering rather than the Levy edition (Ludovici's chapter is titled "Skirmishes in a War with the Age") — unverified, and a possible rights question worth the coordinator's attention. Cited by section number only ("Skirmishes" §5, §37; "How the 'True World' Finally Became a Fable"). Cited by DD note 3.4.

### galante-et-al-2021-mindfulness-based-programmes-nonclinical
- status: usable
- medium: text
- cite: Julieta Galante, Claire Friedrich, Anna F Dawson, Marta Modrego-Alarcón, Pia Gebbing, Irene Delgado-Suárez, Radhika Gupta, Lydia Dean, Tim Dalgleish, Ian R White & Peter B Jones, "Mindfulness-based programmes for mental health promotion in adults in nonclinical settings: A systematic review and meta-analysis of randomised controlled trials," *PLoS Medicine* 18:1 (2021), e1003481
- kb: `Galante-et-al_Mindfulness-Based-Programmes-in-Nonclinical-Settings_PLoSMedicine-2021.md`
- verified: file (results and prediction intervals at seg 2; data-availability statement names Cambridge; author list from the published record, not web-checked)
- note: Benefits against passive controls (distress SMD −0.45, well-being 0.33) but no evidence of superiority over specific active controls; USA trials report smaller effects.

### gallie-1956-essentially-contested-concepts
- status: usable
- medium: text-ocr
- cite: W. B. Gallie, "Essentially Contested Concepts," *Proceedings of the Aristotelian Society* 56 (1956): 167–198
- kb: `Gallie_Essentially-Contested-Concepts_PAS-1956.md` (full text, folded into the corpus 2026-08); `wb-gallie_essentially-contested-concepts_1956.md` (attributed summary, in corpus under staging.text/DD/sources/oldsources/)
- verified: web (JSTOR 4544562; read in full from Columbia Law-hosted scan)
- note: attributed summary note with verified page anchors. Replaces the abstract-page citation in notes 1.3 (S16) and 3.4 (S8). ▲ Conditions VI–VII (common exemplar; competition develops its achievement) are what separate essential contestedness from radical confusion — DD currently invokes only I–V, and plural dharmas may fail VI. Full text in DD local archive (scratch/sources/part1/, gitignored).

### geertz-1973-religion-as-a-cultural-system
- status: usable
- medium: text-ocr
- cite: Clifford Geertz, "Religion as a Cultural System," in *The Interpretation of Cultures* (New York: Basic Books, 1973), 87–125
- kb: `clifford-geertz_religion-as-a-cultural-system_1973.md` (attributed summary, staged at workshops/DD/sources/ — not yet folded into corpus)
- verified: web (ISBN 978-0-465-09719-7); quotations verified against the full book scan
- note: attributed summary note with verified page anchors. The definition Asad attacks, and the position DD's four-feature test structurally occupies. Geertz himself disclaims essence-hunting ('it is notorious that definitions establish nothing,' p. 90). Distinct work from the KB's *Religion of Java*. Full text in DD local archive (scratch/sources/part1/, gitignored); community upload, reading copy only.

### geertz-1973-impact-of-the-concept-of-culture
- status: usable
- medium: text
- cite: Clifford Geertz, "The Impact of the Concept of Culture on the Concept of Man," in *The Interpretation of Cultures: Selected Essays* (New York: Basic Books, 1973), ch. 2, pp. 33–54
- kb: `Geertz_Impact-of-the-Concept-of-Culture-on-the-Concept-of-Man_1973.md`
- verified: file (book title, publisher, ©1973 and "Chapter 2" at seg 0; consensus gentium critique segs 6–8; "unfinished animals" seg 19)
- note: The classic anthropological case against consensus-gentium universals ("fake universals") and for culture as constitutive of the human.

### geertz-1973-interpretation-of-cultures
- status: usable
- medium: text-ocr
- cite: Clifford Geertz, *The Interpretation of Cultures: Selected Essays* (New York: Basic Books, 1973)
- kb: `Geertz_The-Interpretation-of-Cultures_1973.md`
- verified: file (essay text of "Ethos, World View, and the Analysis of Sacred Symbols" at segs 175–180 and "Religion as a Cultural System" earlier; hyphenation artefacts "artic­ ulate" indicate a scanned PDF)
- note: Whole collection in the corpus under this filename; DD cites the rasa passage of "Ethos, World View" (1957). Cited by DD note 3.5.3.

### gellner-curry-cook-alfano-venkatesan-2020-gdat-debate
- status: usable
- medium: text
- cite: David N. Gellner (ed.), Oliver Scott Curry, Joanna Cook, Mark Alfano & Soumhya Venkatesan, "Debate: Morality is fundamentally an evolved solution to problems of social co-operation," *Journal of the Royal Anthropological Institute* 26:2 (2020): 415–427
- kb: `gellner-curry-cook-alfano-venkatesan_gdat-debate-morality-as-cooperation_2020.md` (attributed summary, staged at workshops/DD/sources/ — not yet folded into corpus)
- verified: web (Oxford ORA deposit, CC BY-NC)
- note: attributed summary note with verified page anchors. The formal GDAT motion: Curry proposes, Alfano seconds (needs/capabilities grounding), Cook and Venkatesan oppose. Attribute by speaker — the methodological objections DD needs are Venkatesan's (p. 422). Vote swing 13–6 → 4–24, unreliable per the chair (p. 415). Curry Templeton-funded (TWCF0164, p. 426). Cited by DD note 1.2.

### gethin-2004-he-who-sees-dhamma
- status: usable
- medium: text-ocr
- cite: Rupert Gethin, "He Who Sees Dhamma Sees Dhammas: Dhamma in Early Buddhism," *Journal of Indian Philosophy* 32 (2004): 513–542; repr. in Olivelle (ed.), *Dharma* (Delhi: MLBD, 2009), 91–120
- kb: `Olivelle-ed_Dharma-Semantic-Cultural-Religious-History_2009_INCOMPLETE-SCAN.md` (full text, folded into the corpus 2026-08); `rupert-gethin_he-who-sees-dhamma-sees-dhammas_2004.md` (attributed summary, in corpus under staging.text/DD/sources/oldsources/)
- verified: web (DOI 10.1007/s10781-004-8633-6 for the JIP original; read from the MLBD reprint scan)
- note: ▲ Full text is an incomplete tesseract scan of the 2009 MLBD volume (preface letter-spaced; Brereton/Horsch articles absent). attributed summary note with verified page anchors (MLBD pagination; +422 for JIP). Argues the senses of dhamma cohere genealogically around 'support/maintain' — against homonymy, cutting against Part 1's rope-not-thread rhetoric for the Buddhist case while vindicating 'that which holds'. ▲ Same incomplete, poor-OCR volume scan as the Olivelle entry; unreliable for verbatim transliterated Pali. Cited by DD note 1.4.

### glenn-roberts-2020-the-dharma-of-dog
- status: usable
- medium: text
- cite: Glenn Roberts, "Dog Dharma: The Dharma of Dog," talk for the final study retreat of the Secular Dharma Course 2018–19, Bodhi College (delivered Nov 2019; finalised Feb 2020)
- kb: `Glenn-Roberts_The-Dharma-of-Dog.md` (duplicate content: `Glenn-Roberts_Bodhi-Talk-2020-02-08.md`)
- verified: file (unpublished; no external record to check)
- note: practitioner itinerary (post-Christian → Triratna → MBSR → Bodhi College); the "3 jewels" of dog training (trainer, instruction, "comradely community of other dog owners") as spontaneous secular restatement of the practice–ethics–community bundle; "intriguing parallels with what I've previously known as the Path to Recovery". Same course/community milieu as the item above — weaker form of the same circularity caveat; specimen evidence only. The two KB files are the same talk; cite once. Cited by DD note 6.1.

### glenn-roberts-2023-on-the-dharma-of-dharmas
- status: usable
- medium: text
- cite: Glenn Roberts, "On the Dharma of Dharmas," talk for John's group, 20 November 2023
- kb: `Glenn-Roberts_On-the-dharma-of-dharmas.md`
- verified: file (unpublished; no external record to check)
- note: the presentist strategy in practice — dharmas (plural) as the mind's maps/models; "dark dharmas"; "the Dharmic value of a dharma teaching" defined as "it's helpfulness in living our lives" (the testimony success-criterion note 6.1 flags as insufficient). Same milieu caveat; specimen evidence only. Cited by DD note 6.1.

### glenn-roberts-archie-roberts
- status: barred
- barred: ephemera
- medium: text
- kb: `Glenn-Roberts_A-day-in-the-life-of-Archie-Roberts.md`
- verified: unverified
- note: personal domestic notes about a dog. No evidential weight.

### glenn-roberts-ch19-listening-to-stories-draft
- status: barred
- barred: ephemera
- medium: text
- kb: `Glenn-Roberts_CH-19-FINAL-draft.md`
- verified: unverified
- note: book chapter draft marked "DRAFT IN DEVELOPMENT – NOT FOR CIRCULATION" on every page. Unpublished and explicitly not for circulation; barred on that ground alone.

### glenn-roberts-dharma-is-true-further-thoughts
- status: usable
- medium: text
- cite: Glenn Roberts, "Dharma is true and Buddhism is Not: Some further thoughts from Glenn" (unpublished community paper, undated, c. 2019–20; internal evidence: written "following Gary's presentation on 'why dharma is true and Buddhism not'" at the final retreat of the Bodhi College Secular Dharma Course 2018–19, and mentions a Bodhi College open day in London, 1 Dec)
- kb: `Glenn-Roberts_Dharma.md`
- verified: file (unpublished; no external record to check)
- note: ▲ CIRCULAR with respect to this project — it is a direct response to the project author's own presentation. May be cited ONLY as a primary specimen of how the secular-dharma community uses and disputes the word (vocabulary dispute, -ism cost analysis, "healthful wisdom" naturalisation proposal), NEVER as independent support for the author's thesis. Note 6.1 states the circularity in Findings and Tensions wherever it is used. Cited by DD note 6.1.

### glenn-roberts-dog-dharma-notes
- status: barred
- barred: ephemera
- medium: text
- kb: `Glenn-Roberts_Dog-Dharma-Notes.md`
- verified: unverified
- note: private working notes in letter form ("Dear Stephen"); superseded by the finished talk in `Glenn-Roberts_The-Dharma-of-Dog.md` and `Glenn-Roberts_Bodhi-Talk-2020-02-08.md`. Cite the finished piece, not the notes. Cited by DD note 6.1.

### goldberg-et-al-2017-is-mindfulness-research-methodology-improving
- status: usable
- medium: text
- cite: Simon B Goldberg, Raymond P Tucker, Preston A Greene, Tracy L Simpson, David J Kearney & Richard J Davidson, "Is mindfulness research methodology improving over time? A systematic review," *PLoS ONE* 12:10 (2017), e0187298, DOI 10.1371/journal.pone.0187298
- kb: `Goldberg-et-al_Is-Mindfulness-Research-Methodology-Improving-Over-Time_PLoSONE-2017.md`
- verified: file (title and authors at seg 0; DOI and results at seg 1; 142 samples / 12,005 participants at seg 8)
- note: No evidence that any study-quality indicator improved across 142 mindfulness-intervention samples, 2000–2016; a Davidson-lab audit of its own field.

### goldman-1913-failure-of-christianity
- status: usable
- medium: text
- cite: Emma Goldman, "The Failure of Christianity", *Mother Earth* 8:2 (April 1913), pp. 41–48
- kb: `Emma-Goldman_The-Failure-of-Christianity_1913.md`
- verified: web (Mother Earth 8:2, April 1913 — Wikisource, The Anarchist Library, dwardmac.pitzer.edu)
- note: POLEMIC, cited as such in 7.3 — Christianity "most admirably adapted to the training of slaves"; teachings "a more powerful protection against rebellion and discontent than the club or the gun"; abuses "conditioned in the thing itself". Earns its place solely as the anti-Tolstoy reading of the same gospel (underdetermination-of-text argument); carries no scholarly weight. Cited by DD notes 7.1, 7.3.

### goldman-berkman-1922-bolsheviks-shooting-anarchists
- status: usable
- medium: text
- cite: Emma Goldman and Alexander Berkman, "Bolsheviks Shooting Anarchists" (open letter, Stockholm, 7 January 1922; published in the anarchist press, 1922)
- kb: `Emma-Goldman+Alexander-Berkman_Bolsheviks-Shooting-Anarchists_1922.md`
- verified: unverified — text is internally dated (Stockholm, 7 January 1922) with an editorial preface indicating publication in an anarchist/syndicalist paper (likely *Freedom*, London); publication venue not independently confirmed
- note: documents the manufacture of Scott's fourth element (prostrate civil society): April 1918 machine-gunning of the Moscow Anarchist Club, Lenin's "open and merciless war" declaration at the Tenth Party Congress (April 1921), September 1921 shootings of Fanny Baron and Lev Tchorny. Partisan testimony of the persecuted party — flagged as such in the note's Tensions. Cited in 7.7 as [S15].

### goldman-vazquez-1939-fall-of-barcelona-letters
- status: usable
- medium: text
- cite: Emma Goldman & Mariano R. Vázquez, letters exchanged after the fall of Barcelona, February–March 1939
- kb: `Emma-Goldman+Mariano-R-Vázquez_The-Fall-of-Barcelona_Letters-Exchanged-by-Emma-Goldman-and-Mariano-R-Vázquez-After-the-Spanish-Civil-War_1939.md`
- verified: unverified
- note: a mass movement's death discussed by its participants as it happened; two incompatible post-mortems inside one exchange — contested memory, not causal history.

### goodyear-et-al-2025-school-phone-policies-smart-schools
- status: usable
- medium: text
- cite: Victoria A Goodyear, Amie Randhawa, Péymane Adab, Hareth Al-Janabi, Sally Fenton, Kirsty Jones, Maria Michail, Breanna Morrison, Paul Patterson, Jonathan Quinlan et al, "School phone policies and their association with mental wellbeing, phone use, and social media use (SMART Schools): a cross-sectional observational study," *The Lancet Regional Health – Europe* (2025), ISRCTN77948572
- kb: `Goodyear-et-al_School-Phone-Policies-SMART-Schools_LancetRegHealthEurope-2025.md`
- verified: file (title, authors, registration and Findings at segs 0–1; volume/article number not in the file)
- note: 30 English schools, 1,227 pupils; restrictive policies cut in-school use, no wellbeing difference. The one policy experiment on the shelf.

### goyal-et-al-2014-meditation-programs-meta-analysis
- status: usable
- medium: text
- cite: Madhav Goyal et al., "Meditation Programs for Psychological Stress and Well-being: A Systematic Review and Meta-analysis," *JAMA Internal Medicine* 174:3 (2014), 357–368, DOI 10.1001/jamainternmed.2013.13018
- kb: `Goyal-et-al_Meditation-Programs-for-Psychological-Stress-and-Well-being_JAMAIM-2014.md`
- verified: file (NIH author-manuscript header "JAMA Intern Med. Author manuscript; available in PMC 2015 March 01" at seg 10; findings at segs 1, 8)
- note: AHRQ-commissioned review, 47 trials; small effects with moderate evidence, insufficient evidence on attention.

### graeber-2011-debt-the-first-5000-years
- status: usable
- medium: text-ocr
- cite: David Graeber, *Debt: The First 5,000 Years* (Brooklyn: Melville House, 2011)
- kb: `Graeber_Debt-The-First-5000-Years_2011.md`
- verified: file (letter-spaced running heads "T H E A X I AL A G E 2 2 9" at seg 280, "C R E D I T V E R S US B ULL I O N 2 1 3" at seg 262 match the Melville House pagination; ch. 9 spans segs ~274–308)
- note: The book itself, distinct from the 2009 Mute essay carried as `graeber-2009-debt-first-five-thousand-years`; ch. 9 "The Axial Age" is the source of the military-coinage-slavery complex and the markets/world-religions complementarity.

### graeber-wengrow-2021-dawn
- status: usable
- medium: text
- cite: David Graeber & David Wengrow, *The Dawn of Everything: A New History of Humanity* (Farrar, Straus and Giroux, 2021)
- kb: `Dawn_of_Everything-David_Graeber.md`, `Dawn-of-Everything.md`
- verified: web (ISBN 978-0-374-15735-7)
- note: disputes a single "original condition"; egalitarian-forager baseline not uniform.

### graham-haidt-et-al-2013-mft-pragmatic-validity
- status: usable
- medium: text
- cite: Jesse Graham, Jonathan Haidt, Sena Koleva, Matt Motyl, Ravi Iyer, Sean P Wojcik & Peter H Ditto, "Moral Foundations Theory: The Pragmatic Validity of Moral Pluralism," *Advances in Experimental Social Psychology* 47 (2013), 55–130
- kb: `Graham-Haidt-et-al_Moral-Foundations-Theory-Pragmatic-Validity_AESP-2013.md`
- verified: file (Elsevier author's-copy header with volume, pages and ISBN at seg 0; contents at seg 1)
- note: MFT's canonical restatement — nativism as "organized in advance of experience," the four claims, foundationhood criteria, Liberty as candidate sixth foundation.

### gray-dimaggio-schein-kachanoff-2022-problem-of-purity
- status: usable
- medium: text
- cite: Kurt Gray, Nicholas DiMaggio, Chelsea Schein & Frank Kachanoff, "The Problem of Purity in Moral Psychology," *Personality and Social Psychology Review* 27:3 (2023), 272–308, DOI 10.1177/10888683221124741 (online 2022)
- kb: `Gray-DiMaggio-Schein-Kachanoff_The-Problem-of-Purity-in-Moral-Psychology_PSPR-2022.md`
- verified: file (journal header with DOI, volume and pages at seg 0; abstract at seg 1)
- note: Systematic review dissolving purity as a distinct moral construct; the dyadic-morality programme's case against the sanctity foundation.

### gulenc-2016-physis-nomos-sophists
- status: usable
- medium: text
- cite: N Petek Boyacı Gülenç, "An Enquiry on Physis–Nomos Debate: Sophists," *Synthesis Philosophica* 61 (1/2016), 39–53, DOI 10.21464/sp31103
- kb: `Gulenc_Physis-Nomos-Debate-Sophists_2016.md`
- verified: file (journal header, DOI and page range in chunks :0 and :11)
- note: Review article; supplies the Antiphon F44 quotation and the Antiphon/Callicles split on what physis grounds.

### gurlesin-2024-implicit-religion-xr
- status: usable
- medium: text
- cite: Ömer F. Gürlesin, "Social Media, Environmental Activism and Implicit Religion: A Case Study of Extinction Rebellion," *Religions* 15 (2024): 1458
- kb: `omer-gurlesin_social-media-environmental-activism-implicit-religion-xr_2024.md` (attributed summary, staged at workshops/DD/sources/ — not yet folded into corpus)
- verified: web (DOI 10.3390/rel15121458; CC BY 4.0)
- note: attributed summary note with verified page anchors. Evidence base for Part 1's environmentalism borderline case. ▲ Method limits: one movement, X/Twitter only, NL 2020–2023, organisational account — public rhetoric, not member self-understanding; Bailey's canonical three markers never appear verbatim in the paper, so do not cite 'Bailey via Gürlesin'.

### guy-debord-1956-theory-of-the-derive
- status: usable
- medium: text
- cite: Guy Debord, "Theory of the Dérive" (November 1956; pub. *Les Lèvres Nues* #9, 1956, rev. *Internationale Situationniste* #2, 1958); English trans. Ken Knabb, *Situationist International Anthology*
- kb: `Guy-Debord_Theory-of-the-Dérive_1956.md`
- verified: unverified (Knabb attribution inferred, not web-checked)
- note: the dérive as attention-environment practice: "drop their relations, their work and leisure activities, and all their other usual motives for movement and action." Cited in 6.2 as a structural ancestor of digital-declutter / re-grounded-attention practices — comparison marked [A], no influence claim. Cited by DD note 6.2.

### guy-debord-1957-report-on-the-construction-of-situations
- status: usable
- medium: text
- cite: Guy Debord, "Report on the Construction of Situations and on the International Situationist Tendency's Conditions of Organization and Action" (July 1957); English trans. in Ken Knabb (ed.), *Situationist International Anthology* (Bureau of Public Secrets)
- kb: `Guy-Debord_Report-on-the-Construction-of-Situations_And-on-the-International-Situationist-Tendencys-Conditions-of-Organization-and-Action_1957.md`
- verified: unverified (translation provenance inferred from house style and the Knabb footnote apparatus in the companion 1956 files; not web-checked)
- note: founding SI manifesto. Source for the recuperation mechanism ("trivialized and sterilized... safely spectacularized"), the "battle of leisure" / "televised imbecilities" passage, and constructed situations (spectators → "livers"). Cited by DD note 6.2.

### guy-debord-1967-society-of-the-spectacle
- status: usable
- medium: text
- cite: Guy Debord, *The Society of the Spectacle* (Paris: Buchet-Chastel, 1967); English trans. Ken Knabb (2002; book edn London: Rebel Press, 2005)
- kb: `guy-debord_the-society-of-the-spectacle.md`
- verified: file (translator identified from the file's own translator's note (Ken Knabb, dated Feb 2002, noting the Rebel Press 2005 edition and the prior Nicholson-Smith/Zone 1994 and Perlman-Supak/Black & Red 1977 translations); Knabb's translation is hosted at bopsecrets.org (Bureau of Public Secrets). ISBN not web-checked.)
- note: primary polemical text, 221 numbered theses. Cite by thesis number. Theses used in 6.2: 1, 4, 6, 12, 59. Establishes that the "external industrial adversary" of the attention economy was diagnosed in 1967 — pre-web, pre-smartphone. Cited by DD note 6.2.

### guy-debord-1988-comments-on-the-society-of-the-spectacle
- status: usable
- medium: text
- cite: Guy Debord, *Commentaires sur la société du spectacle* (Paris: Éditions Gérard Lebovici, 1988); standard English trans. Malcolm Imrie (London: Verso, 1990, ISBN 9780860915201) — but the KB file carries a DIFFERENT, unattributed translation
- kb: `Guy-Debord_Comments-on-the-Society-of-the-Spectacle_1988.md`
- verified: web (Verso publisher page and AbeBooks confirm Imrie/Verso 1990, ISBN 9780860915201). The KB file names no translator; its phrasing ("the integrated spectacular", "forgeries without reply") does not match Imrie, so quotations from the file cannot be attributed to any published translation.
- note: Debord's twenty-year self-audit — the "integrated spectacle", the five features, the three-days rule, the death of the agora, the image-flow that leaves no time for reflection. Cite by section number (§I–§XXXIII), prefer paraphrase over quotation because the translation is unattributed; flagged in the note's Tensions. Cited by DD note 6.2.

### guy-debord-gil-wolman-1956-users-guide-to-detournement
- status: usable
- medium: text
- cite: Guy Debord and Gil J. Wolman, "A User's Guide to Détournement" (*Les Lèvres Nues* #8, May 1956); English trans. Ken Knabb, *Situationist International Anthology*
- kb: `Guy-Debord+Gil-J-Wolman_A-Users-Guide-to-Détournement_1956.md`
- verified: file (footnote 1 is Knabb's translator note on anglicising "détournement"); edition not web-checked
- note: manifesto for the partisan re-use of the dominant culture's material against it; ancestor of culture jamming. Also contains the laws of détournement. Cited by DD note 6.2.

### gyekye-2010-african-ethics-sep
- status: usable
- medium: text
- cite: Kwame Gyekye, "African Ethics," *The Stanford Encyclopedia of Philosophy* (first published 9 September 2010), https://plato.stanford.edu/entries/african-ethics/
- kb: `SEP_African-Ethics.md`
- verified: file (SEP masthead and "First published Thu Sep 9, 2010" at seg 0; section headings §8 "Social, Not Individualistic, Ethics" and §9 "The Ethics of Duty, Not of Rights" at segs 0, 30–31; the Menkiti block quotation at seg 10)
- note: Gyekye's own survey entry — character, moral personhood (Akan *onnye onipa*), humanistic foundations, the common good, social-not-individualistic ethics; the primary for the "duty, not rights" framing.

### hadot-1995-philosophy-as-a-way-of-life
- status: usable
- medium: text-ocr
- cite: Pierre Hadot, *Philosophy as a Way of Life: Spiritual Exercises from Socrates to Foucault*, ed. Arnold I Davidson, trans. Michael Chase (Oxford: Blackwell, 1995), ISBN 0-631-18033-8
- kb: `Hadot_Philosophy-as-a-Way-of-Life_1995.md`
- verified: file (running head "Spiritual Exercises 85" at seg 102; OCR with hyphenation artefacts)
- note: *Prosochē* as the fundamental Stoic spiritual exercise ("Spiritual Exercises" chapter, segs 101–102).

### haidt-2001-emotional-dog-rational-tail
- status: usable
- medium: text
- cite: Jonathan Haidt, "The Emotional Dog and Its Rational Tail: A Social Intuitionist Approach to Moral Judgment," *Psychological Review* 108:4 (2001), 814–834
- kb: `Haidt_The-Emotional-Dog-and-Its-Rational-Tail_PsychReview-2001.md`
- verified: file (abstract, four reasons and the Julie-and-Mark vignette at segs 0–3; Haidt–Hersh dumbfounding report at seg 9; journal/pages from the published record)
- note: The social intuitionist model in its original statement, including Haidt's own "plausible alternative… not an established fact" hedge.

### halbfass-1988-india-and-europe-ch17
- status: usable
- medium: text-ocr
- cite: Wilhelm Halbfass, "Dharma in the Self-Understanding of Traditional Hinduism," ch. 17 of *India and Europe: An Essay in Understanding* (Albany: SUNY Press, 1988), 310–333
- kb: `Halbfass_India-and-Europe_1988.md` (full text, folded into the corpus 2026-08); `wilhelm-halbfass_dharma-in-the-self-understanding-of-traditional-hinduism_1988.md` (attributed summary, in corpus under staging.text/DD/sources/oldsources/)
- verified: web (SUNY ISBN 978-0-88706-795-8; scan is the MLBD Indian ed., Delhi 1990, ISBN 81-208-0736-7, preserving SUNY pagination)
- note: attributed summary note with verified page anchors. ▲ Two load-bearing findings: ṛta→dharma linkages 'casual and rare' (pp. 314–15; close-connection claims a Neo-Hindu postulate), and classical dharma emphatically particularist — Indocentric, Veda-indexed, birth-restricted; universalist dharma is the modern reinterpretation (ch. 18). Presses directly on Part 1's two-storey design. Full text in DD local archive (scratch/sources/part1/, gitignored); community upload, reading copy only.

### hallaq-2009-an-introduction-to-islamic-law
- status: usable
- medium: text-ocr
- cite: Wael B Hallaq, *An Introduction to Islamic Law* (Cambridge: Cambridge University Press, 2009)
- kb: `Hallaq_An-Introduction-to-Islamic-Law_2009.md`
- verified: file (OCR provenance header at seg 0 lists only six scanned pages, the rest reads as born-digital; chapter plan at segs 1–3; jurists' law at seg 6; Jones/Hastings codification at seg 100)
- note: Hallaq's abridgement of *Sharīʿa: Theory, Practice, Transformations*; sharia as jurists' law independent of the ruler, dismantled by colonial codification and the modern state.

### halton-2014-from-the-axial-age-to-the-moral-revolution
- status: usable
- medium: text-ocr
- cite: Eugene Halton, *From the Axial Age to the Moral Revolution: John Stuart-Glennie, Karl Jaspers, and a New Understanding of the Idea* (New York: Palgrave Macmillan, 2014)
- kb: `Halton_From-the-Axial-Age-to-the-Moral-Revolution_2014.md`
- verified: file (tesseract OCR header at seg 0; title and preface; Stuart-Glennie's 1873 dating at seg 2)
- note: Recovers Stuart-Glennie's 1873 "Moral Revolution" as a precursor to Jaspers; frames the shift as conscience over custom.

### hammurabi-code-trans-king-1910-avalon
- status: usable
- medium: text
- cite: *The Code of Hammurabi*, trans. LW King (1910), Avalon Project, Yale Law School, https://avalon.law.yale.edu/ancient/hamframe.asp
- kb: `Avalon_The-Code-of-Hammurabi_trans-King.md` (Harper's 1904 edition is `Harper_The-Code-of-Hammurabi-King-of-Babylon_1904.md`)
- verified: file (prologue at seg 0; §§176–177 at seg 19; King's 1910 rendering, section numbering standard)
- note: Primary code text; prologue self-describes the law's purpose ("so that the strong should not harm the weak"). Old translation — check wording against Roth 1997 before quoting for philological weight.

### hare-1999-without-conscience
- status: usable
- medium: text-ocr
- cite: Robert D Hare, *Without Conscience: The Disturbing World of the Psychopaths Among Us* (New York: Guilford Press, 1999; orig. Pocket Books, 1993)
- kb: `Hare_Without-Conscience_1999_community-upload.md`
- verified: file (tesseract OCR of a community-uploaded scan; author's note at seg 0, "2 million psychopaths in North America" at seg 4, serial-killer ratio at seg 78; edition not confirmed beyond the filename)
- note: Hare's popular statement of the PCL-R construct: prevalence estimates, the intraspecies-predator framing, the separation of psychopathy from serial murder. OCR scan; community upload, provenance unverified.

### harris-raskin-2023-the-ai-dilemma
- status: usable
- medium: transcript
- cite: Tristan Harris & Aza Raskin, "The A.I. Dilemma" (Center for Humane Technology, public talk, 9 March 2023; YouTube transcript)
- kb: `The-A-I-Dilemma-March-9-2023.transcript.txt`
- verified: file (title and date in the transcript header; "first contact with social media" at seg 3; engagement business model and LLM companions at seg 16)
- note: Harris's own statement of the attention-economy thesis; "In this first contact with social media, humanity lost."

### henrich-heine-norenzayan-2010-weirdest-people
- status: usable
- medium: text
- cite: Joseph Henrich, Steven J Heine & Ara Norenzayan, "The weirdest people in the world?", *Behavioral and Brain Sciences* 33:2–3 (2010): 61–83 (with commentary to 135)
- kb: `Henrich-Heine-Norenzayan_The-Weirdest-People-in-the-World_2010.md`
- verified: file (authors, affiliations and abstract in seg 0)
- note: primary for the WEIRD sampling caveat — WEIRD subjects "frequent outliers" on fairness, cooperation, moral reasoning. Cited by DD note 1.2.

Also: existing entry `curry-mullins-whitehouse-2019-seven-moral-rules` should add to its `kb:` line `Curry-Mullins-Whitehouse_Is-It-Good-to-Cooperate_CurrentAnthropology-2019_with-commentaries.md` and `Curry-Mullins-Whitehouse_2019_SUPPLEMENT-coding-tables.md` (now in the corpus under `3-cooperation/`), with a note that the first is the published abstract plus the attributed summary, not the full typeset article.

### henry-david-thoreau-1854-walden
- status: usable
- medium: text
- cite: Henry David Thoreau, *Walden; or, Life in the Woods* (Boston: Ticknor and Fields, 1854), "Economy"
- kb: `Henry-David-Thoreau_Walden_Life-in-the-Woods_1854.md`
- verified: web (Wikipedia "Walden" — 1854; residence 4 July 1845 – 6 September 1847 on Emerson's woodland)
- note: sufficiency argued by ledger, not sermon — house $28.12½, food eight months $8.74, "by working about six weeks in a year, I could meet all the expenses of living"; cost redefined as life exchanged. ▲ Always pair with the Lowell/subsidy critique (see lowell entry below): Emerson's land, 26 months, no dependants. Thoreau discloses the borrowing himself ("I borrowed an axe"; "merely a squatter"). Quotations verified verbatim against the staging.text file (segs 5, 31, 43, 53, 60, 66, 76, 101, 102).

### henry-david-thoreau-1863-life-without-principle
- status: usable
- medium: text
- cite: Henry David Thoreau, "Life Without Principle," *The Atlantic Monthly* 12:71 (October 1863), posthumous
- kb: `Henry-David-Thoreau_Life-Without-Principle_1863.md`
- verified: web (Wikisource: *The Atlantic Monthly*, Volume 12, Number 71; Wikipedia "Life Without Principle" — first published posthumously October 1863, edited by Thoreau for publication before his death in 1862)
- note: the moral-livelihood essay — "The ways by which you may get money almost without exception lead downward"; "You are paid for being something less than a man." The canonical secular statement that *how* one earns a living is itself a moral question. All quotations verified verbatim against the staging.text file (segs 3, 6, 7, 12, 19).

### higgins-2017-flexible-appropriation
- status: usable
- medium: text
- cite: Winton Higgins, "The Flexible Appropriation of Tradition: Stephen Batchelor’s Secular Buddhism," *Journal of Global Buddhism* 18 (2017): 51–67
- kb: `batchelor-higgins_a-secular-buddhism-and-its-analysis_2012-2017.md` (attributed summary, staged at workshops/DD/sources/ — not yet folded into corpus)
- verified: web (globalbuddhism.org, diamond OA)
- note: attributed summary note with verified page anchors, shared with the Batchelor entry. Review essay legitimating Batchelor's method via the Chan-acculturation precedent and MacIntyre's 'living tradition'. ▲ Never cites McMahan — source Buddhist modernism separately. Sympathetic analyst, not neutral. Distinct work from the KB's After Buddhism workbook.

### higgins-2017-flexible-appropriation-of-tradition
- status: usable
- medium: text
- cite: Winton Higgins, "The Flexible Appropriation of Tradition: Stephen Batchelor's *After Buddhism*," *Journal of Global Buddhism* 18 (2017), 56–63 (review essay)
- kb: `Higgins_The-Flexible-Appropriation-of-Tradition-Batchelor_JGB-2017.md`
- verified: file (running head "JOURNAL OF GLOBAL BUDDHISM | Vol.18 (2017)" and page 57 in seg 9; page range from the running heads, not web-checked)
- note: Sympathetic insider review; records the First Council recovery narrative and the misplaced Hitchens endorsement.

### hipp-siegel-2013-dissociating-gamma-from-muscle-activity
- status: usable
- medium: text
- cite: Joerg F Hipp & Markus Siegel, "Dissociating neuronal gamma-band activity from cranial and ocular muscle activity in EEG," *Frontiers in Human Neuroscience* 7 (2013), art. 338
- kb: `Hipp-Siegel_Dissociating-Neuronal-Gamma-from-Muscle-Activity-in-EEG_FrontHumNeurosci-2013.md`
- verified: file (title, authors, editors and reviewers at seg 0; discussion at segs 22–23; article number from the published record, not web-checked)
- note: Cranial-muscle artefacts occupy the gamma band and can produce false conclusions unless cleaned; the technical caveat on scalp-gamma meditation findings.

### hultzsch-1925-inscriptions-of-asoka
- status: usable
- medium: text-ocr
- cite: E Hultzsch (ed.), *Inscriptions of Asoka*, Corpus Inscriptionum Indicarum vol. I, new edition (Oxford: Clarendon Press for the Government of India, 1925)
- kb: `Hultzsch_Corpus-Inscriptionum-Indicarum-I-Inscriptions-of-Asoka_1925.md`, `Hultzsch_Inscriptions-of-Asoka_1925_IGNCA-compact.md`
- verified: file (tesseract OCR provenance headers in seg 0 of both files; the compact IGNCA file carries the translations only, Rock Edicts 5 and 12 at segs 35 and 40)
- note: The scholarly edition of the edicts with texts, translations and apparatus; OCR quality uneven — pointer only, verify wording against print. Cited by DD note 2.4.

### hume-1739-treatise-of-human-nature
- status: usable
- medium: text
- cite: David Hume, *A Treatise of Human Nature* (1739–40), Project Gutenberg eBook #4705
- kb: `Hume_A-Treatise-of-Human-Nature_Gutenberg-4705.txt`
- verified: file (table of contents segs 3–4; the is/ought passage T3.1.1.27 at seg 501)
- note: Primary text for the is/ought passage and Book III's sentimentalism.

### iep-stoicism
- status: usable
- medium: text
- cite: Massimo Pigliucci, "Stoicism," *Internet Encyclopedia of Philosophy*, https://iep.utm.edu/stoicism/
- kb: `IEP_Stoicism.md`
- verified: file (entry text and glossary at segs 0, 24, 42; authorship from the live IEP entry, not re-checked)
- note: Accessible summary of oikeiôsis and Hierocles' expanding circles; used alongside SEP_Stoicism.

### james-russell-lowell-1865-thoreau
- status: usable
- medium: text
- cite: James Russell Lowell, "Thoreau," *North American Review* (October 1865); repr. in *My Study Windows* (Boston: James R. Osgood, 1871)
- kb: — (external; no KB file)
- verified: web (Walden Woods Project Lowell page carries the "state's evidence" passage, sourcing it to the 1871 *My Study Windows* reprint; the October 1865 *North American Review* first publication is attested by secondary accounts of the Lowell–Thoreau feud — the American Periodicals literature dates the "vitriolic analysis" to 1865)
- note: the founding scholarly critique of Walden's dependence — "He squatted on another man's land; he borrows an axe; his boards… all turn state's evidence against him as an accomplice in the sin of that artificial civilization." The scholarly ancestor of the popular "he took his laundry home" jibe; use this, not the jibe.

### jaspers-1953-origin-and-goal-of-history
- status: usable
- medium: text-ocr
- cite: Karl Jaspers, *The Origin and Goal of History*, trans. Michael Bullock (London: Routledge & Kegan Paul, 1953; German *Vom Ursprung und Ziel der Geschichte*, 1949); Routledge Revivals reprint
- kb: `Jaspers_The-Origin-and-Goal-of-History_1953.md`
- verified: file (tesseract OCR header at seg 0; Routledge Revivals blurb; "Axial Period" definition at seg 7, characterisation at seg 8; contents pages garbled — "rif" for "of")
- note: The primary text for *Achsenzeit*; Part I ch. 1 gives the 800–200 BCE bracket, "depths of selfhood," "thinking became its own object," "the step into universality." Pointer, not quotable without checking the printed translation.

### karunadasa-1996-dhamma-theory
- status: usable
- medium: text
- cite: Y. Karunadasa, *The Dhamma Theory: Philosophical Cornerstone of the Abhidhamma*, Wheel Publication 412/413 (Kandy: Buddhist Publication Society, 1996)
- kb: `y-karunadasa_the-dhamma-theory_1996.md` (attributed summary, staged at workshops/DD/sources/ — not yet folded into corpus)
- verified: web (bps.lk; explicit free-distribution licence)
- note: attributed summary note with verified page anchors. ▲ Part 1's 'atoms of mind and matter' does not survive: the discrete-entity reading is 'certainly not admissible' (p. 14); dhammas 'cannot be separated from one another like particles of sand' (p. 32) — events, not substances; the tradition legislated against reification. 'Momentary flickers' survives. PDF safe to archive.

### karunadasa-1996-the-dhamma-theory
- status: usable
- medium: text-ocr
- cite: Y Karunadasa, *The Dhamma Theory: Philosophical Cornerstone of the Abhidhamma*, The Wheel Publication 412/413 (Kandy: Buddhist Publication Society, 1996)
- kb: `Karunadasa_The-Dhamma-Theory_BPS-Wheel-412-413_1996.md`, `y-karunadasa_the-dhamma-theory_1996.md` (attributed summary, oldsources/)
- verified: file (tesseract OCR of the BPS Wheel; title page in sid 0; the summary file records full-text reading against the BPS Online Edition 2011)
- note: Standard concise account of the Theravāda dhamma theory; *attano sabhāvaṃ dhārentī ti dhammā* and its provisional (*kattu-sādhana*) status, sids 11–12.

### kavanagh-et-al-2018-high-arousal-martial-arts-rituals
- status: usable
- medium: text
- cite: Christopher M Kavanagh, Jonathan Jong, Ryan McKay & Harvey Whitehouse, "Positive experiences of high arousal martial arts rituals are linked to identity fusion and costly pro-group actions," *European Journal of Social Psychology* 48:4 (2018), 461–481, DOI 10.1002/ejsp.2514
- kb: `Kavanagh-et-al_High-Arousal-Martial-Arts-Rituals-Identity-Fusion_EJSP-2018.md`
- verified: file (title and author list with affiliations at seg 0; 59 segments)
- note: 605 Brazilian Jiu Jitsu practitioners; no pain–cohesion correlation; positive affect predicts fusion. The imagistic-mode literature correcting itself.

### keeler-1987-javanese-shadow-plays-javanese-selves
- status: usable
- medium: text-ocr
- cite: Ward Keeler, *Javanese Shadow Plays, Javanese Selves* (Princeton: Princeton University Press, 1987; Princeton Legacy Library reprint)
- kb: `Ward-Keeler_Javanese-Shadow-Plays-Javanese-Selves_2017.md`
- verified: file (iTextSharp 2017 PDF metadata at seg 0; chapter running heads "CHAPTER 4", "CHAPTER 9" with 1987 pagination at segs 237, 484; letter-spaced OCR in headings)
- note: The deconstruction-era ethnography Stange 1991 indicts; ch. 9 on ngelmu, pusaka and potency; the "theosophical prejudices" sentence Stange quotes was not string-locatable in the scan. Filename year is the PDF creation date, not the edition. Cited by DD note 3.5.3.

### kiehl-hoffman-2011-the-criminal-psychopath
- status: usable
- medium: text-ocr
- cite: Kent A Kiehl & Morris B Hoffman, "The Criminal Psychopath: History, Neuroscience, Treatment, and Economics," *Jurimetrics* 51:4 (2011), 355–397
- kb: `Kiehl-Hoffman_The-Criminal-Psychopath-History-Neuroscience-Treatment_Jurimetrics-2011.md`
- verified: file (abstract at seg 0; prevalence, recidivism and $460bn cost figures at segs 1, 23, 25, 27; volume/pages from the published record, not web-checked)
- note: Forensic review by a neuroscientist and a judge: <1% of adult males, 15–25% of prisoners, ~80% three-year recidivism for high scorers, Caldwell decompression treatment. Carceral-paradigm source; read with the Skeem–Cooke critique.

### kimmerer-2013-braiding-sweetgrass
- status: usable
- medium: text
- cite: Robin Wall Kimmerer, *Braiding Sweetgrass: Indigenous Wisdom, Scientific Knowledge, and the Teachings of Plants* (Minneapolis: Milkweed Editions, 2013), ISBN 978-1-57131-335-5
- kb: `Kimmerer_Braiding-Sweetgrass_2013.md`
- verified: file (section headings "Planting Sweetgrass," "Tending Sweetgrass," "Picking Sweetgrass" with original page numbers in-text, e.g. "10 Planting Sweetgrass" at seg 8; born-digital)
- note: Potawatomi botanist's essays; "the younger brothers of Creation," Skywoman vs Eve, the Honorable Harvest. Indigenous-authored; advocacy register — quote as position.

### king-1973-some-observations-on-the-samin-movement
- status: usable
- medium: text
- cite: Victor T King, "Some Observations on the Samin Movement of North-Central Java: Suggestions for the Theoretical Analysis of the Dynamics of Rural Unrest," *Bijdragen tot de Taal-, Land- en Volkenkunde* 129:4 (1973): 457–481
- kb: `King_Some-Observations-on-the-Samin-Movement_BKI-1973.md`, `king_observations_samin-movement_1973.md` (earlier copy under staging.text/samin/)
- verified: file (title at seg 0; running heads "VICTOR T. KING" / "THE SAMIN MOVEMENT OF NORTH-CENTRAL JAVA" with pages 478, 481 at segs 30, 34)
- note: Relative-deprivation reading (Aberle) against economic monocausality; the poorer peasantry who did not join; caution on Geertz's limited fieldwork area.

### king-1999-orientalism-and-religion
- status: usable
- medium: text-ocr
- cite: Richard King, *Orientalism and Religion: Postcolonial Theory, India and "The Mystic East"* (London: Routledge, 1999), ch. 8 "The politics of privatization: Indian religion and the study of mysticism"
- kb: `King_Orientalism-and-Religion_1999.md`
- verified: file (tesseract OCR provenance header at seg 0; running head "The politics of privatization" with pages 167–173 at segs 213–221)
- note: Reports and criticises Katz's constructivism; the modern experiential definition of "the mystical" as itself a Western construction. Cited by DD note 3.5.3.

### klimecki-et-al-2013-compassion-training-positive-affect
- status: usable
- medium: text
- cite: Olga M Klimecki, Susanne Leiberg, Claus Lamm & Tania Singer, "Functional neural plasticity and associated changes in positive affect after compassion training," *Cerebral Cortex* 23:7 (2013), 1552–1561
- kb: `Klimecki-Leiberg-Lamm-Singer_Functional-Neural-Plasticity-After-Compassion-Training_CerebCortex-2013.md`
- verified: file (title, authors and affiliations at seg 0; volume/pages from the published record, not web-checked)
- note: Sibling study to the 2014 paper; compassion training increases positive affect and recruits the reward/affiliation network. Named in 5.1's S16 line as a sibling, not separately cited. Cited by DD note 5.1.

### klimecki-et-al-2014-compassion-vs-empathy-training
- status: usable
- medium: text
- cite: Olga M Klimecki, Susanne Leiberg, Matthieu Ricard & Tania Singer, "Differential pattern of functional brain plasticity after compassion and empathy training," *Social Cognitive and Affective Neuroscience* 9:6 (2014), 873–879
- kb: `Klimecki-Leiberg-Ricard-Singer_Differential-Brain-Plasticity-Compassion-vs-Empathy_SCAN-2014.md`
- verified: file (title, authors, affiliations and abstract at seg 0; volume/pages from the published record, not web-checked)
- note: The primary behind Sapolsky's Ricard empathy-vs-compassion story: empathy training raises negative affect and insula/aMCC activation, compassion training reverses it via ventral striatum / pgACC / mOFC.

### konvalinka-xygalatas-et-al-2011-synchronized-arousal-fire-walking
- status: usable
- medium: text
- cite: Ivana Konvalinka, Dimitris Xygalatas, Joseph Bulbulia, Uffe Schjødt, Else-Marie Jegindø, Sebastian Wallot, Guy Van Orden & Andreas Roepstorff, "Synchronized arousal between performers and related spectators in a fire-walking ritual," *PNAS* 108:20 (2011), 8514–8519, DOI 10.1073/pnas.1016955108
- kb: `Konvalinka-Xygalatas-et-al_Synchronized-Arousal-in-a-Fire-Walking-Ritual_PNAS-2011.md`
- verified: file (masthead, author list and abstract at seg 0; "received for review December 14, 2010")
- note: The primary San Pedro Manrique firewalk report: 38 participants, heart-rate synchrony between walkers and related spectators only.

### koons-2012-can-gods-goodness-save-divine-command-theory
- status: usable
- medium: text
- cite: Jeremy Koons, "Can God's Goodness Save the Divine Command Theory from Euthyphro?," *European Journal for Philosophy of Religion* 4:1 (Spring 2012), 177–195
- kb: `Koons_Can-Gods-Goodness-Save-Divine-Command-Theory.md`
- verified: file (journal masthead, volume, pages in seg 0; running page numbers 192 at seg 18)
- note: Against Adams/Alston — grounding goodness in God's nature leaves it "a featureless property… completely unintelligible"; an adequate solution may need a standard external to God.

### korver-1976-the-samin-movement-and-millenarism
- status: usable
- medium: text
- cite: A Pieter E Korver, "The Samin Movement and Millenarism," *Bijdragen tot de Taal-, Land- en Volkenkunde* 132:2/3 (1976): 249–266
- kb: `Korver_The-Samin-Movement-and-Millenarism_BKI-1976.md`, `pieter-e-korver_the-samin-movement-and-millenarism.md` (earlier copy under staging.text/samin/)
- verified: file (title and introduction at seg 0; running head "THE SAMIN MOVEMENT AND MILLENARISM 251" at seg 2; volume/pages from the published record, not web-checked)
- note: The millenarian reading (Cohn, Talmon, Hobsbawm); records post-1914 followers "not averse from using violence"; rejects Benda/Castles/King's pacifism argument; warns against King discounting poverty.

### kral-davidson-et-al-2022-absence-of-structural-brain-changes
- status: usable
- medium: text
- cite: Tammi RA Kral, Kaley Davis, Cole Korponay, Matthew J Hirshberg, Rachel Hoel, Lawrence Y Tello, Robin I Goldman, Melissa A Rosenkranz, Antoine Lutz & Richard J Davidson, "Absence of structural brain changes from mindfulness-based stress reduction: Two combined randomized controlled trials," *Science Advances* 8:20 (2022), eabk3316, DOI 10.1126/sciadv.abk3316
- kb: `Kral-Davidson-et-al_Absence-of-Structural-Brain-Changes-from-MBSR_ScienceAdvances-2022.md`
- verified: file (journal masthead "Sci. Adv. 8, eabk3316 (2022) 20 May 2022" and full author list at seg 0)
- note: The largest controlled test of MBSR neuroplasticity — null on grey matter, density and thickness; from Davidson's own lab.

### kral-et-al-2018-mindfulness-training-amygdala-reactivity
- status: usable
- medium: text
- cite: Tammi RA Kral, Brianna S Schuyler, Jeanette A Mumford, Melissa A Rosenkranz, Antoine Lutz & Richard J Davidson, "Impact of short- and long-term mindfulness meditation training on amygdala reactivity to emotional stimuli," *NeuroImage* 181 (2018), 301–313
- kb: `Kral-Davidson-et-al_Mindfulness-Training-and-Amygdala-Reactivity_NeuroImage-2018.md`
- verified: file (abstract with group sizes at seg 0; Davidson conflict-of-interest statement at seg 1; author list and pagination from the published record, not web-checked)
- note: RCT (MBSR N = 32 vs active control N = 35) plus long-term meditators (N = 30, mean 9,081 h): less amygdala reactivity to positive pictures; the modest functional result beside the 2022 structural null.

### kreplin-farias-brazil-2018-limited-prosocial-effects-of-meditation
- status: usable
- medium: text
- cite: Ute Kreplin, Miguel Farias & Inti A Brazil, "The limited prosocial effects of meditation: A systematic review and meta-analysis," *Scientific Reports* 8 (2018), 2403, DOI 10.1038/s41598-018-20299-z
- kb: `Kreplin-Farias-Brazil_The-Limited-Prosocial-Effects-of-Meditation_SciRep-2018.md`
- verified: file (journal masthead with DOI on every page, seg 0)
- note: Prosocial effects qualified by type and quality; compassion gains only with author-teachers and passive controls.

### kropotkin-1916-manifesto-of-the-sixteen
- status: usable
- medium: text
- cite: "The Manifesto of the Sixteen" (28 February 1916), signed Jean Grave, Pierre Kropotkine et al. (fifteen initial signatories despite the name)
- kb: `Pëtr-Kropotkin_The-Manifesto-of-the-Sixteen_1916.md`
- verified: web (https://www.marxists.org/reference/archive/kropotkin-peter/1916/sixteen.htm — date, "ranged on the side of the resistance" and signatory list incl. Grave and Kropotkine confirmed)
- note: the pro-war minority's own declaration — the other side of the Malatesta 1914 dispute, in its own words. Cited in 7.1 [S16]. Cited by DD note 7.1.

### landy-goodwin-2015-does-incidental-disgust-amplify-moral-judgment
- status: usable
- medium: text
- cite: Justin F Landy & Geoffrey P Goodwin, "Does Incidental Disgust Amplify Moral Judgment? A Meta-Analytic Review of Experimental Evidence," *Perspectives on Psychological Science* 10:4 (2015), 518–536
- kb: `Landy-Goodwin_Does-Incidental-Disgust-Amplify-Moral-Judgment_PPS-2015.md`
- verified: file ("in press at Perspectives on Psychological Science" preprint header and abstract at seg 0; volume/pages from the published record)
- note: k = 50; d = .11 shrinking to −.01 after publication-bias correction — the disgust mechanism behind the sanctity foundation loses its support.

### lang-purzycki-et-al-2019-moralizing-gods-impartiality-parochialism
- status: usable
- medium: text
- cite: Martin Lang, Benjamin G Purzycki et al., "Moralizing gods, impartiality and religious parochialism across 15 societies," *Proceedings of the Royal Society B* 286 (2019), 20190202, DOI 10.1098/rspb.2019.0202
- kb: `Lang-Purzycki-et-al_Moralizing-Gods-Impartiality-and-Religious-Parochialism_PRSB-2019.md`
- verified: file (author manuscript headed "Published in Proceedings of the Royal Society B"; abstract with n = 2,228 / 15 populations at segs 1–2)
- note: Cross-cultural experimental support for punishing/monitoring gods reducing local favouritism and extending sharing to distant co-religionists; outgroup effects vary by site.

### legge-1891-texts-of-taoism-sbe39
- status: usable
- medium: text-ocr
- cite: James Legge (trans.), *The Texts of Taoism, Part I: The Tâo Teh King; The Writings of Kwang-dze (Books I–XVII)*, Sacred Books of the East 39 (Oxford: Clarendon, 1891)
- kb: `Legge_The-Texts-of-Taoism_SBE-39_1891.md` (Part II is `Legge_The-Texts-of-Taoism_SBE-40_1891.md`)
- verified: file (running head "THE TEXTS OF TAOISM. pt. I" with pagination at :92; chapter numerals 25 and 37 located)
- note: Public-domain primary text; OCR has broken headings (`###

### Tao`) inside sentences, so quote only after reassembly.

### leng-ludwig-2016-intranasal-oxytocin-myths-and-delusions
- status: usable
- medium: text
- cite: Gareth Leng & Mike Ludwig, "Intranasal Oxytocin: Myths and Delusions," *Biological Psychiatry* 79:3 (2016), 243–250, DOI 10.1016/j.biopsych.2015.05.003
- kb: `Leng-Ludwig_Intranasal-Oxytocin-Myths-and-Delusions_BiolPsychiatry-2016.md`
- verified: file (Edinburgh author manuscript, title and authors at seg 1; blood–brain-barrier argument at seg 9; pagination from the published record, not web-checked)
- note: The pharmacokinetic objection to the intranasal-oxytocin literature; supraphysiological peripheral levels, little central delivery.

### lestari-et-al-2026-resistance-identity-colonial-perspectives-saminism
- status: usable
- medium: text
- cite: Lestari et al, "Resistance, Identity and Colonial Perspectives on Saminism," *Local History & Heritage* 6:1 (2026), DOI 10.57251/lhh.v6i1.2062 (CC BY 4.0)
- kb: `Lestari-et-al_Resistance-Identity-and-Colonial-Perspectives-Saminism_LHH-2026.md`
- verified: file (journal header with DOI, ISSN and CC BY licence at seg 0; abstract at seg 1; full author list not recoverable from the ingested text)
- note: Archival re-reading of colonial discourse on Saminism: authorities "systematically portrayed the Samin community as backward, irrational, and resistant to progress."

### lichtheim-1992-maat-in-egyptian-autobiographies
- status: usable
- medium: text-ocr
- cite: Miriam Lichtheim, *Maat in Egyptian Autobiographies and Related Studies*, Orbis Biblicus et Orientalis 120 (Fribourg: Universitätsverlag / Göttingen: Vandenhoeck & Ruprecht, 1992)
- kb: `Lichtheim_Maat-in-Egyptian-Autobiographies_OBO-120_1992.md` (full text, folded into the corpus 2026-08); `miriam-lichtheim_maat-in-egyptian-autobiographies_1992.md` (attributed summary, in corpus under staging.text/DD/sources/oldsources/)
- verified: web (official OA deposit, Zurich Open Repository; ISBN 3-7278-0846-0)
- note: attributed summary note with verified page anchors. Maat as lived practice-defined ethic (veracity, fairness, beneficence) — cosmic in principle but bottom-weighted ('the Pyramid Texts supply the heavenly dimension of Maat, but just barely,' p. 16); explicitly rejects Assmann's theologised top-down fusion, and her Assmann quotations are DD's only window into that unobtainable book. Replaces the EBSCO starter in note 1.4.

### lifton-1961-thought-reform-totalism
- status: usable
- medium: text-ocr
- cite: Robert Jay Lifton, *Thought Reform and the Psychology of Totalism: A Study of "Brainwashing" in China* (New York: Norton, 1961; reprint with new preface, University of North Carolina Press, 1989)
- kb: `Lifton_Thought-Reform-and-the-Psychology-of-Totalism_1961.md`
- verified: file (tesseract OCR provenance and title page "with a new preface by the author" at seg 0; ch. 22 "sacred science" and loaded-language passages at segs 442, 444)
- note: The eight criteria of ideological totalism; the clinical description of orthodoxy at its coercive limit.

### lightner-bendixen-purzycki-2022-datasets-underestimate-moralizing-gods
- status: usable
- medium: text
- cite: Aaron D Lightner, Theiss Bendixen & Benjamin Grant Purzycki, "Cross-cultural datasets systematically underestimate the presence of moralizing gods," preprint (2022); published in *Religion, Brain & Behavior* (2023), DOI 10.1080/2153599X.2022.2137575
- kb: `Lightner-Bendixen-Purzycki_Datasets-Underestimate-Moralizing-Gods_2022-preprint.md`
- verified: file (abstract at seg 0; §3.1 on false negatives at seg 6; published venue and DOI not checked against the file)
- note: The SCCS "moralizing high gods" variable keys on creator status and produces false negatives at low complexity, biasing toward a spurious complexity–moralizing-gods association. Cited by DD note 1.2.

### lindenfors-wartel-lind-2021-dunbars-number-deconstructed
- status: usable
- medium: text
- cite: Patrik Lindenfors, Andreas Wartel & Johan Lind, "'Dunbar's number' deconstructed," *Biology Letters* 17 (2021), 20210158, DOI 10.1098/rsbl.2021.0158
- kb: `Lindenfors-Wartel-Lind_Dunbars-Number-Deconstructed_BiolLett-2021.md`
- verified: file (journal masthead, DOI, received/accepted dates at seg 0; results table at seg 3)
- note: Phylogenetic re-estimates of 69–109 / 16–42 with 95% CIs 4–520 / 2–336; "a cognitive limit on human group size cannot be derived in this manner."

### llano-alonso-2012-cicero-natural-law
- status: usable
- medium: text
- cite: Fernando H Llano Alonso, "Cicero and Natural Law," *Archiv für Rechts- und Sozialphilosophie* 98:2 (2012), 157–168
- kb: `LlanoAlonso_Cicero-and-Natural-Law_ARSP-2012.md`
- verified: file (Latin tags *cui qui non parebit…* and Ulpian's *ius naturale* definition present at :9)
- note: Argues Cicero's *natura* is inward rationality (*recta ratio*), not Ulpian's external physical order — man as "autonomous legislator." Volume/issue/pages taken from the corpus filename and body; not web-checked.

### long-2002-epictetus-stoic-and-socratic-guide
- status: usable
- medium: text-ocr
- cite: AA Long, *Epictetus: A Stoic and Socratic Guide to Life* (Oxford: Clarendon Press, 2002), ISBN 0-19-924556-8
- kb: `Long_Epictetus-A-Stoic-and-Socratic-Guide-to-Life_2002.md`
- verified: file (running head "28 Epictetus in his Time and Place" at seg 31; heavy OCR garbling in footnotes, e.g. seg 87)
- note: The judgement-mediation reading of Epictetus ("we do not experience the world without the mediation of our own assessments").

### lutz-et-al-2004-gamma-synchrony
- status: usable
- medium: text
- cite: Antoine Lutz, Lawrence L Greischar, Nancy B Rawlings, Matthieu Ricard & Richard J Davidson, "Long-term meditators self-induce high-amplitude gamma synchrony during mental practice," *PNAS* 101:46 (2004), 16369–16373, DOI 10.1073/pnas.0407401101
- kb: `Lutz-Greischar-Ricard-Davidson_Long-Term-Meditators-Self-Induce-Gamma-Synchrony_PNAS-2004.md`
- verified: file (masthead, DOI and pagination in segs 0 and 3; eight practitioners / ten controls at seg 1)
- note: The founding contemplative-neuroscience result; eight expert subjects; the paper's own 80–120 Hz muscle adjustment is at seg 3.

### macintyre-1981-after-virtue
- status: usable
- medium: text-ocr
- cite: Alasdair MacIntyre, *After Virtue: A Study in Moral Theory*, 3rd edn (Notre Dame: University of Notre Dame Press, 2007; 1st edn 1981)
- kb: `MacIntyre_After-Virtue_1981.md`
- verified: file (tesseract OCR header; 2007 prologue "After Virtue after a Quarter of a Century" at seg 0, so the scan is the 3rd edition; ch. 15 narrative-self passage at segs 289–290 checked)
- note: The communitarian "narrative self" primary; "I am born with a past." OCR noise ("dear" for "clear", "1" for "I").

### mahmoudi-2024-rta-and-asa
- status: usable
- medium: text
- cite: Abolfazl Mahmoudi, "Ṛta and Aša: The Metaphysical Foundation of Happiness in Classical Hindu-Iranian Texts (Rigveda and Gatha)," *Ethics and Normativity* 1:1 (2024), 83–94, DOI 10.22034/EAN.2024.200158 (CC BY)
- kb: `Mahmoudi_Rta-and-Asa_EthicsAndNormativity-2024.md`
- verified: file (header carries journal, DOI, dates and CC BY licence; body chunks :0, :3, :5 checked)
- note: Comparative reading of ṛta and aša as the earliest "criterion of good" — cosmic order spanning cosmos, morality and ritual; Y 30.4/30.10 as the two commands. Opens on a perennialist premise (belief in good/evil "almost universally shared") — quote it as the position, not the finding.

### malatesta-makhno-1927-about-the-platform
- status: usable
- medium: text
- cite: Errico Malatesta & Nestor Makhno, "About the Platform" — exchange over the *Organisational Platform of the General Union of Anarchists*: Malatesta critique (*Il Risveglio*, Geneva, Oct 1927), Makhno letter (1928), Malatesta reply (*Il Risveglio*, Dec 1929), Makhno second letter (*Le Libertaire*, 9 Aug 1930; trans. Nestor McNab)
- kb: `Errico-Malatesta+Nestor-Makhno_About-the-Platform_1927.md`
- verified: web (Malatesta's 1927 component at https://theanarchistlibrary.org/library/errico-malatesta-a-project-of-anarchist-organisation — venue and both load-bearing quotations confirmed; the combined-exchange URL guesses 404'd, so the three later letters rest on the kb file)
- note: the ossification debate in real time, both sides arguing: "a government and a church" / "better that it should die" (Malatesta) vs without permanent organisation the movement "gets weaker" (Makhno). The documented instance for the form-capture failure mode. Cited in 7.1 [S17]. Cited by DD note 7.1.

### mann-2005-1491
- status: usable
- medium: text
- cite: Charles C Mann, *1491: New Revelations of the Americas Before Columbus* (New York: Knopf, 2005), ISBN 978-1-4000-4006-3
- kb: `Mann_1491-New-Revelations-of-the-Americas_2005.md`
- verified: file (chapter "Holmberg's Mistake" at segs 6–13; Dobyns population discussion at seg 122; born-digital with italics preserved)
- note: Journalistic synthesis of the revisionist archaeology (Denevan, Erickson, Balée, Dobyns); "Holmberg's Mistake" and the Noble Savage genealogy are the corpus's Americanist counterweight to the ecological-Indian projection.

### mann-et-al-2016-withdraw-or-affiliate-humiliation-initiation
- status: usable
- medium: text
- cite: Liesbeth Mann, Allard R Feddes, Bertjan Doosje & Agneta H Fischer, "Withdraw or affiliate? The role of humiliation during initiation rituals," *Cognition and Emotion* 30:1 (2016), 80–100, DOI 10.1080/02699931.2015.1050358
- kb: `Mann-et-al_Withdraw-or-Affiliate-Humiliation-During-Initiation-Rituals_CognEmotion-2016.md`
- verified: file (UvA-DARE header, author list and received/accepted dates at seg 0; hypotheses summary at seg 7)
- note: Three studies: initiation severity and humiliation reduce novices' affiliation, least when initiated as a group. Counterweight to the ordeal-bonds reading.

### mason-sep-value-pluralism
- status: usable
- medium: text
- cite: Elinor Mason, "Value Pluralism," *The Stanford Encyclopedia of Philosophy* (first published 20 June 2006; substantive revision 4 June 2023), https://plato.stanford.edu/entries/value-pluralism/
- kb: `SEP_Value-Pluralism.md`
- verified: file (SEP header with first-published and revision dates at seg 0)
- note: The taxonomy of moral value pluralism (foundational vs non-foundational, incommensurability, the relation to relativism).

### maulana-et-al-2021-sumarah-interrituality
- status: usable
- medium: text
- cite: Abdullah Muslich Rizal Maulana, Mohammad Muttaqin & Anisa Nur Fitriyani, "Paguyuban Sumarah and Interrituality: An Enquiry to the Practice of Interreligious Ritual Participation in Sujud Sumarah," *Walisongo: Jurnal Penelitian Sosial Keagamaan* 29:1 (2021), 27–54, DOI 10.21580/ws.29.1.7364
- kb: `Maulana-et-al_Paguyuban-Sumarah-and-Interrituality_Walisongo-2021.md`
- verified: file (journal masthead with DOI and page range at seg 0)
- note: Sujud Sumarah as interreligious ritual participation; members keep their Muslim/Catholic/Buddhist identity; names of God under the Sesanggeman. Cited by DD notes 3.5, 3.5.1, 3.5.2, 3.5.3, 3.5.4.

### mccullough-churchland-mendez-2013-problems-measuring-peripheral-oxytocin
- status: usable
- medium: text
- cite: Michael E McCullough, Patricia Smith Churchland & Armando J Mendez, "Problems with measuring peripheral oxytocin: Can the data on oxytocin and human behavior be trusted?", *Neuroscience & Biobehavioral Reviews* 37 (2013), 1485–1492
- kb: `McCullough-Churchland-Mendez_Problems-with-Measuring-Peripheral-Oxytocin_NBR-2013.md`
- verified: file (authors, affiliations and article history at seg 0; running head with volume and pages at seg 10)
- note: Unextracted-plasma immunoassays overstate oxytocin by orders of magnitude; the measurement critique beneath the correlational oxytocin literature.

### mckinnon-2002-sociological-definitions
- status: usable
- medium: text
- cite: Andrew M. McKinnon, "Sociological Definitions, Language Games and the ‘Essence’ of Religion," *Method and Theory in the Study of Religion* 14:1 (2002): 61–83
- kb: `McKinnon_Sociological-Definitions-Language-Games-Essence-of-Religion_2002.md` (full text, folded into the corpus 2026-08); `andrew-mckinnon_sociological-definitions-language-games-essence-of-religion_2002.md` (attributed summary, in corpus under staging.text/DD/sources/oldsources/)
- verified: web (DOI 10.1163/157006802760198776; green-OA author manuscript, Aberdeen AURA)
- note: attributed summary note with verified page anchors (▲ anchored to manuscript pages — convert to journal pagination when citing). Concedes the genealogy, keeps the category via Wittgenstein §68 and the usefulness criterion. ▲ His defence requires the term to circulate in ordinary language — 'religion' does, DD's expanded 'dharma' does not; DD must either restrict the strong claim or argue the usage is spreading.

### mcmahan-2008-making-of-buddhist-modernism
- status: usable
- medium: text-ocr
- cite: David L McMahan, *The Making of Buddhist Modernism* (New York: Oxford University Press, 2008), ISBN 978-0-19-518327-6
- kb: `McMahan_The-Making-of-Buddhist-Modernism_2008.md`
- verified: file (tesseract OCR provenance header at seg 0; running heads "the making of buddhist modernism" / "from modern to postmodern? 245" at segs 0, 297)
- note: Standard scholarly history of Buddhist modernism as a hybrid co-created by Asian modernisers and Western enthusiasts under colonial conditions; names Batchelor among the detraditionalisers. OCR — verify quotations against print. Cited by DD note 3.5.4.

### mcmahon-2020-early-urbanism-northern-mesopotamia
- status: usable
- medium: text
- cite: Augusta McMahon, "Early Urbanism in Northern Mesopotamia," *Journal of Archaeological Research* 28 (2020), 289–337, DOI 10.1007/s10814-019-09136-7
- kb: `McMahon_Early-Urbanism-in-Northern-Mesopotamia_JAR-2019.md`
- verified: file (abstract at seg 0; running header "Journal of Archaeological Research (2020) 28:289–337" at seg 47; Brak mass graves at segs 54–55). The kb filename's 2019 is the online-first year.
- note: Fourth-millennium BCE northern cities with low-density zones; Tell Brak's mass graves read as internal civil conflict generated by urban growth — cities as generators of the problems codes address.

### mediasi-2020-samin-vs-semen-documentary-analysis
- status: usable
- medium: text
- cite: "Dualisme Citra Sedulur Sikep dalam Film Dokumenter: Analisis Film 'Samin vs Semen' dan 'Sikep Samin Semen'," *Mediasi: Jurnal Kajian dan Terapan Media, Bahasa, Komunikasi* 1:2 (May 2020): 124ff (Politeknik Negeri Media Kreatif)
- kb: `Samin-vs-Semen-documentary-analysis_Mediasi-Polimedia.md`
- verified: file (journal masthead and abstract at seg 0; author name not recoverable from the ingested text)
- note: Reception study of the two Kendeng documentaries; the Sikep in *Sikep Samin Semen* hold "demo bukanlah ajaran komunitas mereka" (*ora pamer suara, ora pamer tindak*).

### mercadante-2020-spiritual-struggles-of-nones-and-sbnr
- status: usable
- medium: text
- cite: Linda Mercadante, "Spiritual Struggles of Nones and 'Spiritual but Not Religious' (SBNRs)," *Religions* 11:10 (2020), 513, DOI 10.3390/rel11100513
- kb: `Mercadante_Spiritual-Struggles-of-Nones-and-SBNR_Religions-2020.md`
- verified: file (journal masthead, affiliation and received/accepted/published dates at seg 0)
- note: Interview-based typology of nones and SBNRs and their spiritual struggles; the "None" label as identification by lack.

### michael-2023-laozi-justice
- status: usable
- medium: text
- cite: Thomas Michael, "Laozi's Conception of Justice in the Daodejing: Distinguishing the Constant Dao from the Dao of Heaven," *Religions* 14:6 (2023), 771, DOI 10.3390/rel14060771 (CC BY)
- kb: `Michael_Laozis-Conception-of-Justice_Religions-2023.md`
- verified: file (citation block with DOI and dates at :0)
- note: Two Daos in the *Daodejing* — the Constant Dao (only *wuwei*) and the Dao of Heaven (retribution); justice as "natural equality" (*zijun*, DDJ 32).

### michalopoulos-xue-2021-folklore
- status: usable
- medium: text
- cite: Stelios Michalopoulos & Melanie Meng Xue, "Folklore," *Quarterly Journal of Economics* 136:4 (2021), 1993–2046, DOI 10.1093/qje/qjab003
- kb: `Michalopoulos-Xue_Folklore_QJE-2021_published.md`, `Michalopoulos-Xue_Folklore_QJE-2021_NBER-WP-25430.md` (working-paper version)
- verified: file (OUP copyright line, DOI and pagination "1993–2046" at seg 1)
- note: Berezkin's catalogue of oral-tradition motifs for ~1,000 societies; motifs predict present-day trust, gender and risk attitudes, including in second-generation immigrants — measured cultural persistence.

### michels-1911-political-parties
- status: usable
- medium: text
- cite: Robert Michels, *Political Parties: A Sociological Study of the Oligarchical Tendencies of Modern Democracy* (1911; English trans. Eden & Cedar Paul, 1915)
- kb: —
- verified: unverified (standard reference; note links https://en.wikipedia.org/wiki/Iron_law_of_oligarchy; no direct quotation used)
- note: external, not in corpus. The "iron law of oligarchy" — canonical scholarly statement of the mode Malatesta 1909 predicted; cited by paraphrase only. Cited in 7.1 [S19].

### michels-1915-political-parties
- status: usable
- medium: text-ocr
- cite: Robert Michels, *Political Parties: A Sociological Study of the Oligarchical Tendencies of Modern Democracy*, trans. Eden & Cedar Paul (New York: Hearst's International Library, 1915; German orig. *Zur Soziologie des Parteiwesens*, 1911)
- kb: `Michels_Political-Parties_1915.md`
- verified: file (tesseract OCR provenance and title page at seg 0; "Democracy and the Iron Law of Oligarchy" chapter head at seg 454; passages at segs 40, 483)
- note: The iron law of oligarchy — organisation's "tactical and technical necessities" produce stable, irremovable professional leaders. OCR pointer; quote from print.

### miller-euthyphro-dilemma-iee
- status: usable
- medium: text
- cite: Christian Miller, "Euthyphro Dilemma," in Hugh LaFollette (ed.), *The International Encyclopedia of Ethics* (Wiley-Blackwell, 2013); preprint "forthcoming"
- kb: `Miller_Euthyphro-Dilemma_encyclopedia-entry.md`
- verified: file (author, Wake Forest affiliation and "Blackwell International Encyclopedia of Ethics (forthcoming)" in seg 0; Plato 10a quotation)
- note: Standard statement of the dilemma against theological voluntarism, with the "God's nature" rescue and its regress.

### mills-1887-yasna-avesta-org
- status: usable
- medium: text
- cite: *The Zend-Avesta, Part III: The Yasna, Visparad, Âfrînagân, Gâhs and Miscellaneous Fragments*, trans. LH Mills, Sacred Books of the East 31 (Oxford, 1887); electronic text at avesta.org (Yasna incl. Gāthās)
- kb: `Yasna-incl-Gathas_trans-Mills_avesta-org.md`
- verified: file (avesta.org page structure with "Adapted from Mills" headers; Y 30 at chunk :72 checked against SBE 31 wording)
- note: Primary text for the aša/druj dualism (Y 30.1–3 twin Spirits). Chapter headings are bare numerals (`## 30.`), so search by content not by "Yasna 43".

### morris-1993-bakunin-historical-materialism
- status: usable
- medium: text
- cite: Brian Morris, "Bakunin, Historical Materialism, and Social Philosophy" (1993; associated with Morris's *Bakunin: The Philosophy of Freedom*, Black Rose Books, 1993)
- kb: `Brian-Morris_Bakunin-Historical-Materialism-and-Social-Philosophy_1993.md`
- verified: unverified (1993 date from file frontmatter; Black Rose monograph link plausible but not confirmed this pass)
- note: secondary treatment used for Bakunin's *ambivalence* on religion ("the first gleam of human truth", a possible "historic necessity", not an "absolute evil"; church-as-pub consolation) — the nuance the slogans omit. Morris's "no refutation has ever been forthcoming" aside is partisan, flagged in 7.3's Tensions. Cited by DD note 7.3.

### morris-tolstoy-and-anarchism
- status: usable
- medium: text
- cite: Brian Morris, "Tolstoy and Anarchism" (essay/review of the Green Classics reissue of *What Then Must We Do?*; undated, early 1990s)
- kb: `Brian-Morris_Tolstoy-and-Anarchism.md`
- verified: unverified (original venue not established this pass — likely *Freedom* or an anthologised Morris essay; Morris's Tolstoy essays are collected in his PM Press reader)
- note: documentary source for Tolstoy's religious anarchism — *The Kingdom of God Is Within You* (1894), the *Government is Violence* anthology (ed. Stephens, 1991), the "our caste"/"get off their backs" argument of *What Then Must We Do?*, and Tolstoy's pre-1917 prediction that Jacobin revolution leads to new oppression. ▲ Advocacy essay (closes: "there really is no alternative to the kind of anarchism he espoused"); use documentarily. Cited by DD note 7.3.

### mosse-2020-modernity-of-caste-and-the-market-economy
- status: usable
- medium: text
- cite: David Mosse, "The Modernity of Caste and the Market Economy," *Modern Asian Studies* 54:4 (2020), 1225–1271 (published online 2019), DOI 10.1017/S0026749X19000039
- kb: `Mosse_The-Modernity-of-Caste-and-the-Market-Economy_MAS-2019.md`
- verified: file (title, author, SOAS affiliation and abstract at seg 0; volume/pages from the published record, not re-checked online)
- note: Caste effects persisting inside India's market economy; the policy "enclosure" of caste in religion and caste politics.

### mukodi-burhanuddin-2015-domestifikasi-perempuan-samin
- status: usable
- medium: text
- cite: Mukodi & Afid Burhanuddin, "Domestifikasi Perempuan Samin dalam Khasanah Masyarakat Islam Modern," *Al-Tahrir: Jurnal Pemikiran Islam* 15:2 (November 2015): 411–430, DOI 10.21154/al-tahrir.v15i2.271
- kb: `Mukodi-Burhanuddin_Domestifikasi-Perempuan-Samin_Al-Tahrir-2015.md`
- verified: file (title, authors and abstract at seg 0; Indonesian abstract with "budaya patriarki" at seg 4)
- note: Kelopo Dhuwur (Blora) fieldwork; women "still placed as a sub-ordinate of men"; patriarchal culture "dalam tataran tertentu", especially in matchmaking and marriage.

### mullins-et-al-2018-systematic-assessment-of-axial-age-proposals
- status: usable
- medium: text
- cite: Daniel Austin Mullins, Daniel Hoyer, Christina Collins, Thomas Currie, Kevin Feeney, Pieter François, Patrick E Savage, Harvey Whitehouse & Peter Turchin, "A Systematic Assessment of 'Axial Age' Proposals Using Global Comparative Historical Evidence," *American Sociological Review* 83:3 (2018), 596–626 — corpus holds the Oxford preprint
- kb: `Mullins-et-al_Systematic-Assessment-of-Axial-Age-Proposals_ASR-2018_preprint.md`
- verified: file (Oxford preprint header and author list at seg 0; abstract; conclusion segs 35–41; journal volume/pages not re-checked online)
- note: The Seshat test of the Axial Age across five axial and five "non-axial" regions — no circumscribed age, traits earlier and elsewhere, "in fits and starts"; the principal empirical counterweight to Jaspers.

### munt-2012-sumarah-meditation-cognitive-emotional
- status: usable
- medium: text
- cite: Melanie Munt, *Sumarah Meditation in Cognitive-Emotional Perspective: Participant Motivation and Effects and Their Link with Personal- and Background Determinants* (Master's thesis in clinical psychology, Vrije Universiteit Brussel, 2012; promoter S Celestin-Westreich)
- kb: `Munt_Sumarah-Meditation-Cognitive-Emotional-Perspective_2012.md`
- verified: file (header note and abstract at seg 0–1; method segs 27–33; results segs 41–48; limitations seg 61)
- note: The only quantitative study of Sumarah practice — 42 Western practitioners around German (2010) and Italian (2011) workshops, uncontrolled repeated measures; effects on emotion regulation and behaviour; "Spiritual themes (0)" in reported relational effects. Names Klein 2003 and Howe 1980 as practice sources. Cited by DD note 3.5.2.

### murray-bookchin-1969-anarchy-and-organization
- status: usable
- medium: text
- cite: Murray Bookchin, "Anarchy and Organization: A Letter to the Left" (1969), written in reply to Huey Newton, "In Defense of Self Defense", *The Black Panther*, 16 November 1968
- kb: `Murray-Bookchin_Anarchy-and-Organization-a-Letter-to-the-Left_1969.md`
- verified: partial (the Newton reply provenance is stated in the kb file's own headnote; not independently checked in this pass — the 7.1 agent also used this file)
- note: ▲ already used by note 7.1. 2.4 quotes a different clause of the same sentence: the self-dissolution design criterion, that a revolutionary organisation must be "structured to dissolve into the popular forms created by the revolution once its function as a catalyst is completed", otherwise it "becomes a vehicle for carrying the forms of the past into the revolution". Cited by DD note 7.1.

## Coordination flags for whoever merges these

- Three of the six (`colin-ward-1996-anarchy-in-action`, `malatesta-makhno-1927-1930-about-the-platform`,
  `murray-bookchin-1969-anarchy-and-organization`) are also proposed by notes 7.1, 8.3 and/or 2.5.
  Merge, do not duplicate; keep the union of the `note:` fields.
- Ward's *Anarchy in Action* may already exist in `SOURCES.md` as `[E9]` via note 0.2.

### murray-bookchin-1971-listen-marxist
- status: usable
- medium: text
- cite: Murray Bookchin, "Listen, Marxist!" (1971; collected in *Post-Scarcity Anarchism*, Ramparts Press)
- kb: `Murray-Bookchin_Listen-Marxist_1971.md`
- verified: web (https://theanarchistlibrary.org/library/murray-bookchin-listen-marxist — date, provenance and both load-bearing quotations confirmed)
- note: "the germ of treachery existed in them from birth"; Bolshevik centralisation as "a counterrevolution of its own against the very social forces it professed to represent"; "the forms replaced the content… means replaced ends." ▲ Partisan historiography of the Russian Revolution (Kronstadt, factory committees) — cite as the movement's self-diagnosis, not as settled history. Cited in 7.1 [S13]. Cited by DD note 7.1.

### murray-bookchin-1978-utopia-not-futurism
- status: usable
- medium: text
- cite: Murray Bookchin, "Utopia, Not Futurism: Why Doing the Impossible is the Most Rational Thing We Can Do," lecture at the Toward Tomorrow Fair, Amherst MA, 24 August 1978; transcript published by Uneven Earth, October 2019, by permission of the Bookchin Trust
- kb: `Murray-Bookchin_Utopia-Not-Futurism_Why-Doing-the-Impossible-is-the-Most-Rational-Thing-We-Can-Do_2019.md`
- verified: web (unevenearth.org/2019/10/bookchin_doing_the_impossible; mirrored at The Anarchist Library and anarchistfederation.net). Note the transcript is "edited lightly for flow, brevity, and grammar" per the publisher.
- note: the designed pole of the discover/design question ("Be practical, do the impossible"); the 1978 atomisation diagnosis anticipating the loneliness literature; "People change unconsciously before they change consciously.". Cited by DD note 8.3.

### murray-bookchin-2008-free-cities
- status: usable
- medium: text
- cite: Murray Bookchin, *Free Cities: Communalism and the Left*, ed. Eirik Eiglad (Pluto Press, ISBN 978-0-7453-2818-8; editor's preface dated 2008, trade publication 2011)
- kb: `Murray-Bookchin_Free-Cities_Communalism-and-the-Left_2008.md`
- verified: web (ISBN 9780745328188 via AbeBooks/Amazon; manuscript held at NYU Tamiment, finding aid TAM 538)
- note: libertarian municipalism as deliberate institution-building; documents Bookchin's late break with anarchism ("defending anarchism against anarchists") and his founding of communalism. CAVEAT: posthumous anthology assembled by the editor from "letters, lectures, unfinished drafts, and manuscripts," with acknowledged consolidation and revision — quotations carry the editor's hand and should be flagged as editorially mediated. Cited by DD note 8.3.

### murray-bookchin-2015-the-next-revolution
- status: usable
- medium: text
- cite: Murray Bookchin, *The Next Revolution: Popular Assemblies and the Promise of Direct Democracy*, ed. Debbie Bookchin & Blair Taylor, foreword by Ursula K. Le Guin (London: Verso, 2015)
- kb: `Murray-Bookchin_The-Next-Revolution_Popular-Assemblies-and-the-Promise-of-Direct-Democracy_2015.md`
- verified: web (Verso 2015, ISBN 978-1-78168-581-5, editors and Le Guin foreword confirmed at https://www.versobooks.com/products/34-the-next-revolution and https://openlibrary.org/books/OL31035172M/The_next_revolution)
- note: posthumous collection of the libertarian-municipalism / communalism essays. Used in 8.1 for confederalism as an explicitly anti-parochial coordination architecture: confederation "counteract[s] the tendency of decentralized communities to drift toward exclusivity and parochialism"; policymaking reserved to face-to-face assemblies while confederal councils are administrative with mandated, recallable delegates. ▲ Programmatic advocacy, not evidence — no case is made here that the design has been tested above municipal scale. Cited in 8.1 [S22]. Cited by DD note 7.3.

### nesse-2019-tinbergens-four-questions
- status: usable
- medium: text
- cite: Randolph M Nesse, "Tinbergen's four questions: Two proximate, two evolutionary," *Evolution, Medicine, and Public Health* 2019(1): 2, DOI 10.1093/emph/eoy035
- kb: `Nesse_Tinbergens-Four-Questions_EMPH-2019.md`
- verified: file (masthead and DOI in seg 0)
- note: one-page primer; modern labels and the proximate/evolutionary split after Mayr 1951.

### new-inquiry-distracted-by-attention-citton-review
- status: usable
- medium: text
- cite: "Distracted by Attention" (review of Yves Citton, *The Ecology of Attention*), *The New Inquiry*. https://thenewinquiry.com/distracted-by-attention/
- kb: (none — external web source, folded into the [S10] gloss)
- verified: web (search-result excerpt confirms the review discusses Citton's engagement with Debord's motto of the spectacle; full text not fetched)
- note: supports the single lineage claim that Citton's attention-ecology takes up Debord's thesis-12 motto ("What appears is good; what is good appears"). Author name not confirmed, so cited by title only.

### newport-2019-digital-minimalism
- status: usable
- medium: text
- cite: Cal Newport, *Digital Minimalism: Choosing a Focused Life in a Noisy World* (New York: Portfolio/Penguin, 2019)
- kb: `Newport_Digital-Minimalism_2019.md`
- verified: file (full text, 188 segments; "philosophy of technology use" at seg 21; declutter protocol at segs 41–42)
- note: The individual-practice pole of the digital-age responses, read in full.

### nussbaum-2003-capabilities-as-fundamental-entitlements
- status: usable
- medium: text
- cite: Martha C Nussbaum, "Capabilities as Fundamental Entitlements: Sen and Social Justice," *Feminist Economics* 9:2–3 (2003), 33–59, DOI 10.1080/1354570022000077926
- kb: `Nussbaum_Capabilities-as-Fundamental-Entitlements_2003.md`
- verified: file (Routledge download header and title at seg 0; list passage seg 11, overlapping-consensus passage seg 25)
- note: The capabilities list as a threshold of entitlements endorsable across comprehensive doctrines without autonomy as an end.

### nyanaponika-1965-abhidhamma-studies
- status: usable
- medium: text-ocr
- cite: Nyanaponika Thera, *Abhidhamma Studies: Researches in Buddhist Psychology*, 2nd ed. (Kandy: Buddhist Publication Society, 1965; 1st ed. Colombo 1949)
- kb: `Nyanaponika_Abhidhamma-Studies_1965.md`
- verified: file (tesseract OCR, pages transcribed 3, 6; introduction in sid 0 names the Dhammasaṅgaṇī/Atthasālinī translation project)
- note: Reads the grammarians' "bearer of own nature" definition against the atomist misreading (sids 42–43). Edition/date of the scan not confirmed beyond the filename.

### odgers-2024-the-great-rewiring-review-of-haidt
- status: usable
- medium: text
- cite: Candice L Odgers, "The great rewiring: is social media really behind an epidemic of teenage mental illness?" (review of Jonathan Haidt, *The Anxious Generation*), *Nature* 628 (2024), 29–30, DOI 10.1038/d41586-024-00902-2
- kb: `Odgers_The-Great-Rewiring-Review-of-Haidt_Nature-2024.md`
- verified: file (citation line and DOI at the foot of seg 9)
- note: ▲ Scraped nature.com page — segs 0–8 and 10 are navigation; the review text is seg 9 only. "No evidence… rewiring children's brains"; reforms still required; bans may backfire.

### olivelle-1999-dharmasutras
- status: usable
- medium: text
- cite: Patrick Olivelle (trans.), *Dharmasūtras: The Law Codes of Āpastamba, Gautama, Baudhāyana, and Vasiṣṭha* (Oxford World's Classics; Oxford: Oxford University Press, 1999)
- kb: `Olivelle_Dharmasutras_OUP-1999.md`
- verified: file (bibliography segs 7–8 list Kangle's Arthaśāstra and Bühler; explanatory note to Āpastamba 2.24.23 on the puruṣārthas at seg 511)
- note: Primary translation of the four early Dharmasūtras with Olivelle's apparatus; the puruṣārtha note supplies the tradition's own dharma/artha/kāma ranking.

### olivelle-2004-semantic-history-of-dharma
- status: usable
- medium: text-ocr
- cite: Patrick Olivelle, "The Semantic History of Dharma: The Middle and Late Vedic Periods," *Journal of Indian Philosophy* 32 (2004): 491–511; repr. in Olivelle (ed.), *Dharma: Studies in its Semantic, Cultural and Religious History* (Delhi: MLBD, 2009), 69–89
- kb: `Olivelle-ed_Dharma-Semantic-Cultural-Religious-History_2009_INCOMPLETE-SCAN.md` (full text, folded into the corpus 2026-08); `patrick-olivelle_the-semantic-history-of-dharma_2004.md` (attributed summary, in corpus under staging.text/DD/sources/oldsources/)
- verified: web (DOI 10.1007/s10781-004-8629-2 for the JIP original; read from the MLBD reprint scan, which is incomplete — Horsch and Brereton absent)
- note: ▲ Full text is an incomplete tesseract scan of the 2009 MLBD volume (preface letter-spaced; Brereton/Horsch articles absent). attributed summary note with verified page anchors (MLBD pagination; +422 for JIP). ▲ Breaks Part 1's smooth-broadening narrative: dharma marginal and *narrowing* (royal/juridical, Varuṇa and the king) across middle/late Vedic corpora; centrality arrives via Buddhist appropriation and Aśoka, with Dharmaśāstra as Brahmanical response (hypothesis, marked as such). ▲ Scan OCR is poor — dehyphenate before quote-checking; see note's OCR-hazard section. Cited by DD note 1.4.

### olivelle-2005-manus-code-of-law
- status: usable
- medium: text-ocr
- cite: Patrick Olivelle (ed. & trans.), with Suman Olivelle, *Manu's Code of Law: A Critical Edition and Translation of the Mānava-Dharmaśāstra* (South Asia Research; New York: Oxford University Press, 2005)
- kb: `Olivelle_Manus-Code-of-Law_OUP-2005.md`
- verified: file (tesseract OCR provenance header at seg 0; title page and acknowledgements at segs 0–3; ch. 7 daṇḍa verses 7.2–22 at segs 276–278 with Olivelle's verse numbering)
- note: Critical edition and translation of Manu; ch. 7 on the king and Punishment (daṇḍa) is the primary counter-text to "dharma is beyond daṇḍa".

### ong-2002-orality-and-literacy
- status: usable
- medium: text
- cite: Walter J Ong, *Orality and Literacy: The Technologizing of the Word*, 2nd ed. (London: Routledge, 2002; 1st ed. Methuen, 1982)
- kb: `Ong_Orality-and-Literacy_2nd-ed-2002.md`
- verified: file (running heads "ORALITY AND LITERACY" with pagination, e.g. p. 74 at seg 82, "WRITING RESTRUCTURES CONSCIOUSNESS 85" at seg 93; clean digital text)
- note: Writing as "context-free"/"autonomous" discourse detached from its author; "There is no way directly to refute a text." Full text now backs the Goody/Ong/Street placeholder.

### orben-2020-teenagers-screens-social-media-narrative-review
- status: usable
- medium: text
- cite: Amy Orben, "Teenagers, screens and social media: a narrative review of reviews and key studies," *Social Psychiatry and Psychiatric Epidemiology* 55 (2020), 407–414, DOI 10.1007/s00127-019-01825-4
- kb: `Orben_Teenagers-Screens-and-Social-Media-A-Narrative-Review_SocPsychiatry-2020.md`
- verified: file (title, author, received/accepted/published dates and CC notice at seg 0; volume/pages from the published record)
- note: Review of >80 reviews; "no scientific consensus" on screen-based lifestyles and youth mental health.

### orben-przybylski-2019-adolescent-well-being-digital-technology
- status: usable
- medium: text
- cite: Amy Orben & Andrew K Przybylski, "The association between adolescent well-being and digital technology use," *Nature Human Behaviour* 3 (2019), 173–182, DOI 10.1038/s41562-018-0506-1
- kb: `Orben-Przybylski_Adolescent-Well-Being-and-Digital-Technology-Use_NatureHumBehav-2019_typeset.md`, `Orben-Przybylski_Adolescent-Well-Being-and-Digital-Technology-Use_NatureHumBehav-2019_AAM.md` (accepted manuscript)
- verified: file (abstract at seg 2 of the typeset copy; Table 3 comparison specifications at seg 22)
- note: Specification-curve analysis, n = 355,358; association "at most 0.4% of the variation," comparable to eating potatoes; "too small to warrant policy change." The null-leaning side of the dispute. Cited by DD note 6.2.

### ortman-et-al-2014-pre-history-of-urban-scaling
- status: usable
- medium: text
- cite: Scott G Ortman, Andrew HF Cabaniss, Jennie O Sturm & Luís MA Bettencourt, "The Pre-History of Urban Scaling," *PLoS ONE* 9:2 (2014), e87902, DOI 10.1371/journal.pone.0087902
- kb: `Ortman-et-al_The-Pre-History-of-Urban-Scaling_PLOSONE-2014.md`
- verified: file (abstract at seg 0; "social reactors" passage at seg 3)
- note: Settlement-scaling theory applied to pre-Hispanic central Mexico; cities magnify social interaction rates as modern cities do.

### ortman-et-al-2015-settlement-scaling-increasing-returns
- status: usable
- medium: text
- cite: Scott G Ortman, Andrew HF Cabaniss, Jennie O Sturm & Luís MA Bettencourt, "Settlement scaling and increasing returns in an ancient society," *Science Advances* 1:1 (2015), e1400066, DOI 10.1126/sciadv.1400066
- kb: `Ortman-et-al_Settlement-Scaling-and-Increasing-Returns-in-an-Ancient-Society_SciAdv-2015.md`
- verified: file (title and author line at seg 0; superlinear-costs caveat at seg 17)
- note: Increasing returns to scale in an ancient settlement system; disease and violence also scale superlinearly.

### ortner-1974-is-female-to-male-as-nature-is-to-culture
- status: usable
- medium: text
- cite: Sherry B Ortner, "Is Female to Male as Nature Is to Culture?", in Michelle Zimbalist Rosaldo & Louise Lamphere (eds), *Woman, Culture, and Society* (Stanford: Stanford University Press, 1974), pp. 68–87
- kb: `Ortner_Is-Female-to-Male-as-Nature-is-to-Culture_1974.md`
- verified: file (citation line and title at seg 0; running head "74 SHERRY B. ORTNER" at seg 8; conclusions at segs 24–25)
- note: The classic structural account of the universal devaluation of women — woman read as "closer to nature"; "a construct of culture rather than a fact of nature"; the feedback loop between symbol and institution.

### ostrom-2009-beyond-markets-and-states-nobel-lecture
- status: usable
- medium: text
- cite: Elinor Ostrom, "Beyond Markets and States: Polycentric Governance of Complex Economic Systems," Prize Lecture, 8 December 2009 (Nobel Foundation), repr. *American Economic Review* 100:3 (2010), 641–672
- kb: `Ostrom_Beyond-Markets-and-States_Nobel-Lecture-2009.md`
- verified: file (lecture header with date and affiliations at seg 0; design-principles list at segs 21–22)
- note: Ostrom's own late restatement of the CPR design principles with the Cox et al 2009 revisions and the "best practices" concession.

### owen-2020-stoic-epicurean-training-dpr-model
- status: usable
- medium: text
- cite: Owen (first name not recoverable from the file), "Understanding Stoic and Epicurean ethical 'training' in light of the DPR model" (2020; journal not stated in the file)
- kb: `Owen_Stoic-and-Epicurean-Ethical-Training-and-the-DPR-Model_2020.md`
- verified: file (title and Hadot epigraph in seg 0; 32 segments; venue and author details need a web check)
- note: Reads ancient ethical training through the CBT therapist-training DPR model; names the Modern Stoicism project.

### oxford-humanities-vedas-scriptless-texts
- status: usable
- medium: text
- cite: Oxford Humanities (University of Oxford, TORCH), "The Vedas: the Once and Future Scriptless Texts" (web essay, undated)
- kb: `OxfordHumanities_The-Vedas-Once-and-Future-Scriptless-Texts.md`
- verified: file (2-segment born-digital page; the "extraordinary fidelity over more than twenty centuries" sentence at seg 0)
- note: Source of the note's long-standing external S8; now in the corpus. Author not named on the page.

### paine-1797-agrarian-justice
- status: usable
- medium: text
- cite: Thomas Paine, *Agrarian Justice* (Paris/London, 1797), in Moncure Daniel Conway (ed.), *The Writings of Thomas Paine*, vol. III (New York: Putnam, 1895), Project Gutenberg 31270
- kb: `Paine_Agrarian-Justice-in-The-Writings-of-Thomas-Paine_Gutenberg-31270.txt`
- verified: file (Gutenberg 31270 plain text; the *Agrarian Justice* essay runs from about seg 888; the fund proposal at seg 898; the file is the whole vol. III — 1,238 segments — so most of it is other Paine writings)
- note: The 1797 proposal of a national fund paying fifteen pounds at twenty-one and an old-age annuity as compensation for the loss of natural inheritance in land — the ancestor of universal basic income. Cited here only for the floor-without-subsidy point; UBI proper belongs to 8.2.

### parker-1916-constitution-of-the-five-nations
- status: usable
- medium: text-ocr
- cite: Arthur C Parker, *The Constitution of the Five Nations, or The Iroquois Book of the Great Law*, New York State Museum Bulletin 184 (Albany: University of the State of New York, 1916)
- kb: `Parker_The-Constitution-of-the-Five-Nations_1916.md`
- verified: file (tesseract OCR header says 11 pages transcribed; title, introduction and 1898/1908 wampum-custody history at seg 0; the 1900 Six Nations Council dictation preface at seg 36; running heads "NEW YORK STATE MUSEUM")
- note: Primary edition of the Great Law (Newhouse and Chiefs' versions) with the condolence ceremonies. ▲ "Future generations," not "seven generations," is the text's phrase; partial transcription.

### parker-1993-basic-bakunin
- status: usable
- medium: text
- cite: Colin Parker, *Basic Bakunin* (Anarchist Communist Federation, 1993; South African ed. Zabalaza Books, 2004, intro. Lucien van der Walt; 2nd SA ed. 2019)
- kb: `Colin-Parker_Basic-Bakunin_1993.md`
- verified: web (The Anarchist Library; zabalazabooks.net; van der Walt's 2004 SA introduction confirmed at lucienvanderwalt.com)
- note: movement primer, partisan register — use only for Bakunin's documented arguments/predictions ("a new class of experts, scientists and professional politicians" legitimated by "the claim to acting in accordance with scientific laws"), never for its own verdicts. Cited by DD note 7.3.

### passmore-jordan-2020-no-universals-kinship-terminology
- status: usable
- medium: text
- cite: Sam Passmore & Fiona M Jordan, "No universals in the cultural evolution of kinship terminology," *Evolutionary Human Sciences* 2 (2020): e42, DOI 10.1017/ehs.2020.41 (CC BY 4.0)
- kb: `PMC7612818-no-universals-in-the-cultural-evolution-of-kinship-terminolo.md`
- verified: file (PMC7612818 header, journal/year/licence in seg 0; conclusion in seg 19)
- note: phylogenetic test finding no universal link between kin terminology and social structure — a documented non-universal and a caveat on tallied cross-cultural regularities.

### pew-2023-spirituality-among-americans
- status: usable
- medium: text
- cite: Pew Research Center (Becka A Alper, Chip Rotolo et al), *Spirituality Among Americans* (7 December 2023)
- kb: `Pew_Spirituality-Among-Americans_2023.md`
- verified: file (title, authors and headline at seg 0; SBNR portrait at segs 6–7)
- note: 70% spiritual in some way; 22% spiritual but not religious; SBNR beliefs and attitudes to organised religion.

### pew-2025-how-the-global-religious-landscape-changed-2010-2020
- status: usable
- medium: text
- cite: Pew Research Center (Conrad Hackett, Marcin Stonawski et al), *How the Global Religious Landscape Changed From 2010 to 2020* (9 June 2025)
- kb: `Pew_How-the-Global-Religious-Landscape-Changed-2010-2020_2025.md`
- verified: file (authors at seg 0; 24.2% at seg 3; fertility/switching at segs 4, 8–9; country figures at segs 6–7; the 2010 baseline is in the web edition, not the ingested summary)
- note: Global unaffiliated share and its switching-driven growth against a low-fertility base; unaffiliated-majority countries.

### pew-2025-religious-landscape-study-executive-summary
- status: usable
- medium: text
- cite: Pew Research Center (Gregory A Smith, Alan Cooperman et al), *2023–24 Religious Landscape Study: Executive Summary* (26 February 2025)
- kb: `Pew_Religious-Landscape-Study-Executive-Summary_2025.md`
- verified: file (authors and table of contents at segs 0–2; headline figures at seg 3; the 2007/2014 trend line is not in the ingested summary)
- note: The plateau finding — unaffiliated "has leveled off – at least temporarily"; 29% unaffiliated (5/6/19).

### pizarro-et-al-2022-collective-effervescence-meta-analysis
- status: usable
- medium: text
- cite: José J Pizarro, Larraitz N Zumeta, Pierre Bouchat, Anna Włodarczyk, Bernard Rimé, Nekane Basabe, Alberto Amutio & Darío Páez, "Emotional processes, collective behavior, and social movements: A meta-analytic review of collective effervescence outcomes during collective gatherings and demonstrations," *Frontiers in Psychology* 13 (2022), 974683, DOI 10.3389/fpsyg.2022.974683
- kb: `Pizarro-Zumeta-et-al_Collective-Effervescence-Outcomes-Meta-Analysis_FrontPsychol-2022.md`, `Pizarro-et-al_Collective-Effervescence-Outcomes-Meta-Analytic-Review_FrontiersPsychology-2022.md` (duplicate copy under 3-grounding-durkheim)
- verified: file (DOI and publication date at seg 0; k = 50, N = 182,738 at seg 1)
- note: Meta-analytic construct validation of Durkheim's collective effervescence; associations with fusion, wellbeing (r = 0.32) and the "instrument of persuasion" question. Duplicate ingestion.

### plato-euthyphro-jowett
- status: usable
- medium: text
- cite: Plato, *Euthyphro*, trans. Benjamin Jowett, Project Gutenberg eBook #1642
- kb: `Plato_Euthyphro_trans-Jowett_Gutenberg-1642.txt`
- verified: file (Gutenberg header seg 0; the 10a–11a exchange at seg 22)
- note: Primary text of the dilemma — "It is loved because it is holy, not holy because it is loved?"

### poeppl-et-al-2019-view-behind-the-mask-of-sanity
- status: usable
- medium: text
- cite: Timm B Poeppl, Maximilian Donges, Andreas Mokros, Rainer Rupprecht, Peter T Fox, Angela R Laird, Danilo Bzdok, Berthold Langguth & Simon B Eickhoff, "A View Behind the Mask of Sanity: Meta-Analysis of Aberrant Brain Activity in Psychopaths," *Molecular Psychiatry* 24 (2019), 463–470
- kb: `Poeppl-et-al_A-View-Behind-the-Mask-of-Sanity-Meta-Analysis_MolPsychiatry-2019.md`
- verified: file (title and full author block at seg 0; 28 eligible studies at seg 4; volume/pages from the published record, not web-checked)
- note: Coordinate-based meta-analysis; opens by conceding no reliable pattern of altered activity had been established; reports robust frontoinsular increase.

### pokorny-lrc-pie-dher-to-hold-support
- status: usable
- medium: text
- cite: Linguistics Research Center (UT Austin), *Indo-European Lexicon*, s.v. Pokorny etymon *2. dher-, dherə-* 'to hold, support' (master entry 0399), adapting Julius Pokorny, *Indogermanisches etymologisches Wörterbuch* (Bern: Francke, 1959)
- kb: `Pokorny-IEW_dher-to-hold-support_LRC-UT-Austin.md` (full text, folded into the corpus 2026-08); `pokorny-lrc_pie-dher-to-hold-support.md` (attributed summary, in corpus under staging.text/DD/sources/oldsources/)
- verified: web (https://lrc.la.utexas.edu/lex/master/0399)
- note: attributed summary note with verified page anchors. Replaces Wiktionary for the √dhṛ → PIE → *firmus* → *firm* spine in note 1.1 (S7); adds *throne* (Gk. *thronos*) and *Darius* ('upholding the good') as English-visible cognates. ▲ Adjacent entry 0398 is the homophonous '1. dher-' 'dirt, dregs' — do not confuse. Cite for root and reflexes only, never for the meaning of *dharma*; Mayrhofer EWAia remains the citation of record. Cited by DD note 1.1.

### polanyi-1944-the-great-transformation
- status: usable
- medium: text-ocr
- cite: Karl Polanyi, *The Great Transformation: The Political and Economic Origins of Our Time* (1944; 2nd Beacon Press ed., Boston, 2001, with foreword by Joseph Stiglitz and introduction by Fred Block)
- kb: `Polanyi_The-Great-Transformation_1944.md`
- verified: file (Block's introduction at segs 18–34 with the 2001 edition's footnotes; running head "The Self-Regulating Market and the Fictitious Commodities [ 79 ]" at seg 120 matches the Beacon pagination; 373 segments)
- note: The embeddedness thesis in Polanyi's own words — "submerged in his social relationships" (seg 86), the fictitious commodities (seg 116), the countermove (seg 186). Segs 0–34 are Stiglitz/Block front matter, not Polanyi; cite from seg 35 on. OCR splits words mid-line ("so cieties") — quote after reassembly.

### postgate-wang-wilkinson-1995-early-writing
- status: usable
- medium: text
- cite: Nicholas Postgate, Tao Wang & Toby Wilkinson, "The evidence for early writing: utilitarian or ceremonial?", *Antiquity* 69:264 (1995), 459–480
- kb: `Postgate-Wang-Wilkinson_The-Evidence-for-Early-Writing-Utilitarian-or-Ceremonial_Antiquity-1995.md`
- verified: file (title, authors and abstract at seg 0; conclusion at seg 6; volume/pages not checked online)
- note: Comparative argument that earliest scripts were utilitarian/administrative everywhere and the ceremonial preponderance is a preservation artefact.

### prinz-2008-is-morality-innate
- status: usable
- medium: text
- cite: Jesse J Prinz, "Is Morality Innate?", in Walter Sinnott-Armstrong (ed.), *Moral Psychology*, vol. 1: *The Evolution of Morality* (MIT Press, 2008), pp. 367–406
- kb: `Prinz_Is-Morality-Innate_2008.md`
- verified: file ("Forthcoming in W. Sinnott-Armstrong (ed.), Moral Psychology. Oxford University Press" header in seg 0 — preprint; the chapter appeared from MIT Press, so page numbers are the printed volume's, not the file's)
- note: innateness sceptic — morality "ecumenical" but a byproduct of faculties evolved for other purposes; the counterweight to nativist readings of universals.

### prri-2024-religious-change-in-america
- status: usable
- medium: text
- cite: PRRI, *Religious Change in America* (27 March 2024)
- kb: `PRRI_Religious-Change-in-America_2024.md`
- verified: file (date and executive summary at seg 0; affiliation trend at seg 7)
- note: Independent US series — 26% unaffiliated in 2023 vs 21% in 2013; atheists and agnostics doubled while "nothing in particular" stayed flat; retention and switching by tradition.

### purser-2019-the-mindfulness-conspiracy
- status: usable
- medium: text
- cite: Ronald Purser, "The mindfulness conspiracy," *The Guardian*, 14 June 2019 (extract from *McMindfulness*, Repeater Books, 2019)
- kb: `Purser_The-Mindfulness-Conspiracy_Guardian-2019.md`
- verified: file (byline and date in seg 0; 14 segments)
- note: Mindfulness as "a religion of the self," "anchored in the ethos of the market"; the political critique in Purser's own words.

### purser-loy-2013-beyond-mcmindfulness
- status: usable
- medium: text
- cite: Ronald Purser & David Loy, "Beyond McMindfulness," *HuffPost*, 1 July 2013
- kb: `Purser-Loy_Beyond-McMindfulness_HuffPost-2013.md`
- verified: file (byline, author bios and date in seg 0; 5 segments)
- note: The essay that coined "McMindfulness"; uncoupling mindfulness from its ethical context as "denaturing"; sammā vs micchā sati.

### purzycki-et-al-2018-material-security-life-history-moralistic-religions
- status: usable
- medium: text
- cite: Benjamin Grant Purzycki, Cody T Ross, Coren Apicella, Quentin D Atkinson, Emma Cohen, Rita Anne McNamara, Aiyana K Willard, Dimitris Xygalatas, Ara Norenzayan & Joseph Henrich, "Material security, life history, and moralistic religions: A cross-cultural examination," *PLoS ONE* 13:3 (2018), e0193856, DOI 10.1371/journal.pone.0193856 (CC BY)
- kb: `Purzycki-et-al_Material-Security-Life-History-and-Moralistic-Religions_PLOSONE-2018.md`
- verified: file (full citation block, DOI and dates at seg 1)
- note: Direct individual-level test of the affluence/life-history mechanism behind Baumard et al. 2015 — no reliable relationship found in 592 individuals across eight societies.

### pustakaswara-philosophy-of-wong-sikep-video
- status: usable
- medium: transcript
- cite: Pustakaswara (presenter "NF"), "The Philosophy of Wong Sikep, Followers of Samin Surosentiko, Feared by the Dutch" (YouTube discussion built on Anis Sholeh Ba'asin & Muhammad Anis Ba'asin, *Samin: Mistisisme Petani di Tengah Pergolakan*, Semarang)
- kb: `The-Philosophy-of-Wong-Sikep_Followers-of-Samin-Surosentiko_Feared-by-the-Dutch.md`
- verified: file (5 segments; names the Ba'asin book and quotes *Het Nieuws van den Dag*, 5 March 1907)
- note: Carries the 1907 interrogation exchange ("My body is my home") and the *patih* slap anecdote (Ba'asin p. 63). Already cited as [S15] in note 4.1 but previously missing from this register. Cited by DD note 4.1.

### putri-2017-meaning-making-environmental-movement-sedulur-sikep
- status: usable
- medium: text
- cite: Primi Suharmadhi Putri, "The Meaning Making of an Environmental Movement: A Perspective on Sedulur Sikep's Narrative in Anti-Cement Movement," *PCD Journal* 5:2 (2017): 297ff
- kb: `Putri_The-Meaning-Making-of-an-Environmental-Movement_PCD-2017.md`
- verified: file (journal header, dates and abstract at seg 0)
- note: Sikep narratives on the anti-cement movement; woman as manifestation of earth; *siji kanggo sak lawase* monogamy.

### queloz-cueni-2019-genealogical-debunking
- status: usable
- medium: text
- cite: Matthieu Queloz & Damian Cueni, "Nietzsche as a Critic of Genealogical Debunking: Making Room for Naturalism without Subversion," *The Monist* 102:3 (2019), 277–297. doi:10.1093/monist/onz010
- kb: (none — external)
- verified: web (Oxford Academic listing and DOI confirmed 2026-07-27; philarchive preprint exists)
- note: the scholarly anchor for the genetic-fallacy counter-argument — genealogical origins subvert only in conjunction with a further evaluative premise; engages GS §345 directly. Cited via abstract and public preprint, not full journal text (abstract-only access level).

### rai-fiske-2011-moral-psychology-is-relationship-regulation
- status: usable
- medium: text
- cite: Tage Shakti Rai & Alan Page Fiske, "Moral Psychology Is Relationship Regulation: Moral Motives for Unity, Hierarchy, Equality, and Proportionality," *Psychological Review* 118:1 (2011): 57–75
- kb: `Rai-Fiske_Moral-Psychology-is-Relationship-Regulation_2011.md`
- verified: file (seg 3; title/authors not re-checked against a masthead segment)
- note: universality in relational motives, diversity in relational models; "morally motivated acts, not simply errors in judgment."

### reed-ikigai-podcast-18-nanba-walking
- status: usable
- medium: transcript
- cite: William Reed (guest), "The Art of Nanba Walking," *Ikigai Podcast* ep. 18 (YouTube transcript)
- kb: `The-Art-of-Nanba-Walking.transcript.txt`
- verified: file (episode number and guest named in seg 0; host not named in the transcript, no date)
- note: Reed reports Yano Tatsuhiko's conservatory students finding yoga, Feldenkrais and the Alexander Technique relaxing in session but not carrying over into playing — a second-hand anecdote on transfer, used only as such.

### reid-nunn-2015-ancient-aboriginal-stories-sea-level
- status: usable
- medium: text
- cite: Nick Reid & Patrick Nunn, "Ancient Aboriginal stories preserve history of a rise in sea level," *The Conversation*, 13 January 2015, https://theconversation.com/ancient-aboriginal-stories-preserve-history-of-a-rise-in-sea-level-36010
- kb: `Nunn-Reid_Ancient-Aboriginal-Stories-Preserve-History-of-Sea-Level-Rise_TheConversation-2015.md`
- verified: file (URL and publication date in seg 0; web-page boilerplate present; article text segs 5–7)
- note: Popular precursor to Nunn & Reid, *Australian Geographer* 47:1 (2016): 18 stories (the paper has 21), 10,000–13,000-year Fitzroy Island case, the authenticity argument. Cite the journal article for the calibrated figures.

### religionforbreakfast-2025-fandoms-are-religions
- status: usable
- medium: transcript
- cite: ReligionForBreakfast (Andrew M Henry), "Fandoms are Religions" (YouTube video essay, 12 September 2025)
- kb: `ReligionForBreakfast_Fandoms-are-Religions_2025.md`
- verified: file (transcript header carries channel, title and date; 12 segments)
- note: Functionalist-turn survey (Tylor, Otto, the Turners, Brakke, Dalton, JZ Smith) run through fandom; also the Athanasius 367 CE festal-letter canon detail. Cited by DD note 2.4; discussed in the companion essay defining-definition.md. Cited by DD note 2.4.

### rennung-goeritz-2016-prosocial-consequences-of-interpersonal-synchrony
- status: usable
- medium: text
- cite: Miriam Rennung & Anja S Göritz, "Prosocial Consequences of Interpersonal Synchrony: A Meta-Analysis," *Zeitschrift für Psychologie* 224:3 (2016), 168–189, DOI 10.1027/2151-2604/a000252
- kb: `Rennung-Goeritz_Prosocial-Consequences-of-Interpersonal-Synchrony-Meta-Analysis_2016.md`
- verified: file (journal, volume and pages in the running footer at seg 17; abstract at seg 0; experimenter-awareness moderation at seg 24)
- note: 60 experiments; medium effect of synchrony on prosociality, inflated by g = 0.29 when experimenters were unblinded. The counterweight to the synchrony literature's headline.

### rhys-davids-1909-psalms-of-the-sisters
- status: usable
- medium: text-ocr
- cite: Caroline AF Rhys Davids (trans.), *Psalms of the Early Buddhists, I: Psalms of the Sisters* (Pali Text Society Translation Series 1; London: Henry Frowde/OUP, 1909)
- kb: `RhysDavids_Psalms-of-the-Early-Buddhists-Psalms-of-the-Sisters_1909.md`
- verified: file (OCR provenance header, pages 1–742; introduction contents at seg 0; Muttā's verse at seg 45; Sumaṅgala's mother at seg 53)
- note: ▲ Full tesseract scan with heavy garble ("Am Tin freedom" for "Am I in freedom") — a pointer to the Therīgāthā, not a quotable string; verify verses against the PTS printing. Introduction carries her 23 vs 13 per cent emancipation-theme count.

### riesebrodt-2010-promise-of-salvation
- status: usable
- medium: text
- cite: Martin Riesebrodt, *The Promise of Salvation: A Theory of Religion*, trans. Steven Rendall (Chicago: University of Chicago Press, 2010)
- kb: `Riesebrodt_The-Promise-of-Salvation_2010.md` (full text, folded into the corpus 2026-08); `martin-riesebrodt_the-promise-of-salvation_2010.md` (attributed summary, in corpus under staging.text/DD/sources/oldsources/)
- verified: web (ISBN 978-0-226-71391-5)
- note: attributed summary note with verified page anchors. The closest structural precedent for DD: answers the constructionist objection, then defines religion substantively (interventionist practices toward superhuman powers). ▲ The fork this creates for DD: his universality is empirical and falsifiable *because* the definition is substantive — and the same criterion ejects secular frameworks ('morality does not require religion,' pp. 183–84). DD cannot borrow the universality while keeping non-privileging. Full text in DD local archive (scratch/sources/part1/, gitignored); community upload.

### roberts-wolfson-2004-rediscovery-of-recovery
- status: usable
- medium: text
- cite: Glenn Roberts & Paul Wolfson, "The rediscovery of recovery: open to all," *Advances in Psychiatric Treatment* (2004) 10:37–49
- kb: `Glenn-Roberts_APT-Article.md`
- verified: web (Cambridge Core article page for *Advances in Psychiatric Treatment* vol. 10, "The rediscovery of recovery: open to all", Roberts & Wolfson; reported as the journal's most frequently cited article)
- note: the one milieu-independent Roberts document — predates his secular-dharma involvement and contains zero Buddhist/dharmic/mindfulness vocabulary (grep-checked). Documents psychiatry's redefinition of "recovery" from cure to living well with enduring symptoms (Anthony 1993; Deegan), and the testimony-vs-operationalisation dispute (Liberman & Kopelowicz) — an independent convergence on the dharma-shaped form, and a precedent for 7.4's measurement problem. Cited by DD note 6.1.

### romano-gross-dedreu-2024-nasty-neighbor-effect
- status: usable
- medium: text
- cite: Angelo Romano, Jörg Gross & Carsten KW De Dreu, "The nasty neighbor effect in humans," *Science Advances* 10, eadm7968 (26 June 2024)
- kb: `Romano-Gross-DeDreu_The-Nasty-Neighbor-Effect-in-Humans_ScienceAdvances-2024.md`
- verified: file (masthead with volume, article id and date at seg 0; study design at seg 5)
- note: People compete more with in-group members than with out-group members or strangers under perceived within-group scarcity; by the senior author of the "tend-and-defend" papers — complication, not recantation.

### rosch-mervis-1975-family-resemblances
- status: usable
- medium: text-ocr
- cite: Eleanor Rosch & Carolyn B. Mervis, "Family Resemblances: Studies in the Internal Structure of Categories," *Cognitive Psychology* 7 (1975): 573–605
- kb: `Rosch-Mervis_Family-Resemblances_CognitivePsych-1975.md` (full text, folded into the corpus 2026-08); `rosch-mervis_family-resemblances_1975.md` (attributed summary, in corpus under staging.text/DD/sources/oldsources/)
- verified: web (DOI 10.1016/0010-0285(75)90024-9)
- note: attributed summary note with verified page anchors. Family-resemblance score predicts prototypicality at ρ = .84–.94 across six categories — a measurable 'textbook case vs blurry rim' for the four-feature test. ▲ *Bird* was not among the tested categories (the robin/penguin norms are Rosch 1975a); object categories, ~1,076 US undergraduates — extension to normative categories is DD's own wager. Full text in DD local archive (scratch/sources/part1/, gitignored).

### rose-1996-nourishing-terrains
- status: usable
- medium: text
- cite: Deborah Bird Rose, *Nourishing Terrains: Australian Aboriginal Views of Landscape and Wilderness* (Canberra: Australian Heritage Commission, 1996), ISBN 0-642-23561-9
- kb: `Rose_Nourishing-Terrains_AustralianHeritageCommission-1996.md`
- verified: file (introduction and "Country" chapter at segs 1–7 with footnote apparatus; born-digital text, clean)
- note: "Country" as living entity and proper noun; Rose's refusal of the conservation-ethic debate; quoted Aboriginal explanations, songs and song-poems throughout.

### rosyid-2023-komunitas-samin-agama-adam
- status: usable
- medium: text
- cite: Moh Rosyid, "Komunitas Samin: Agama Adam dan Ajarannya," *Hanifiya: Jurnal Studi Agama-Agama* (September 2023)
- kb: `Rosyid_Komunitas-Samin-Agama-Adam-dan-Ajarannya_Hanifiya-2023.md`
- verified: file (title, author, IAIN Kudus affiliation and dates at seg 0; volume/issue not in the ingested text)
- note: Kudus community; Agama Adam transmitted "secara regenerasi dengan bahasa tutur"; classed by the state as *penghayat kepercayaan*.

### royzman-kim-leeman-2015-curious-tale-of-julie-and-mark
- status: usable
- medium: text
- cite: Edward B Royzman, Kwanwoo Kim & Robert F Leeman, "The curious tale of Julie and Mark: Unraveling the moral dumbfounding effect," *Judgment and Decision Making* 10:4 (2015), 296–313
- kb: `Royzman-Kim-Leeman_The-Curious-Tale-of-Julie-and-Mark_JDM-2015.md`
- verified: file (journal header with volume, issue and pages at seg 0)
- note: Re-runs Haidt's incest vignette with harm beliefs factored in — "a dumbfounding estimate of about 0."

### ruiz-collantes-2023-democracy-against-homo-sapiens-alpha
- status: usable
- medium: text
- cite: Xavier Ruiz Collantes, "Democracy against Homo sapiens alpha: Reverse dominance and political equality in human history," *Constellations* (2023), 1–19, DOI 10.1111/1467-8675.12680 (CC BY)
- kb: `RuizCollantes_Democracy-Against-Homo-Sapiens-Alpha-Reverse-Dominance_Constellations-2023.md`
- verified: file (DOI, Wiley copyright line and CC BY notice at segs 0–1; conclusion at segs 33–34)
- note: Political theory reading Boehm's reverse dominance as the Palaeolithic "original democracies." ▲ Advocacy built on the nomadic-egalitarian model.

### rybanska-et-al-2018-rituals-improve-childrens-delay-of-gratification
- status: usable
- medium: text
- cite: Veronika Rybanska, Ryan McKay, Jonathan Jong & Harvey Whitehouse, "Rituals Improve Children's Ability to Delay Gratification," *Child Development* 89:2 (2018), 349–359, DOI 10.1111/cdev.12762
- kb: `Rybanska-McKay-Jong-Whitehouse_Rituals-Improve-Childrens-Ability-to-Delay-Gratification_ChildDev-2017.md`
- verified: file (accepted-manuscript text: title at seg 0, protocol at seg 7, ritual vs instrumental instruction wording at seg 8; the filename year 2017 is the acceptance date)
- note: 210 children, Slovakia and Vanuatu; circle-time games with ritual cues improve executive function and delay of gratification. Corpus copy is the accepted manuscript without the published abstract.

### san-code-of-research-ethics-2017
- status: usable
- medium: text
- cite: South African San Institute, *San Code of Research Ethics* (Kimberley: SASI / South African San Council, under the EU TRUST project, 2017)
- kb: — (external web source; candidate for harvesting into `` as an attributed summary note)
- verified: web (verified against the published booklet PDF (trust-project.eu; images read directly): four values (respect, honesty, justice and fairness, care) plus process; genomics-research grievances; "come through the door, not the window" (Andries Steenkamp). <https://trust-project.eu/wp-content/uploads/2017/03/San-Code-of-RESEARCH-Ethics-Booklet-final.pdf>)
- note: first research-ethics code issued by an African indigenous people; the indigenous-authored counterweight to the note's otherwise entirely outsider Kalahari sourcing. Access-level: full-text (image PDF, quotations transcribed from page images).

### san-drechsler-shakya-2023-buddhism-wealth-and-privilege
- status: usable
- medium: text
- cite: Pisith San, Wolfgang Drechsler & Shobhit Shakya, "Buddhism, Wealth, and Privilege: Ambedkar and Habermas," *Religions* 14:8 (2023), 1057, DOI 10.3390/rel14081057 (CC BY)
- kb: `San-Drechsler-Shakya_Buddhism-Wealth-and-Privilege-Ambedkar-and-Habermas_Religions-2023.md`
- verified: file (MDPI citation block with DOI at seg 0)
- note: Reads Ambedkar's Navayāna and Habermas's late essay on Buddhism against Theravāda; Navayāna as deliberate filtering of the tradition for twentieth-century communities.

### sapolsky-behave-2017
- status: usable
- medium: text
- cite: Robert M. Sapolsky, *Behave: The Biology of Humans at Our Best and Worst* (Penguin Press, 2017)
- kb: `Behave_the-biology-of-humans-at-our-best-and-worst.md`
- verified: web (ISBN 978-1-59420-507-1)
- note: neurobiology of behaviour; frontal cortex, amygdala, gene-effect-size caveats. Cited by DD note 6.4.

### dharma-sangha-reunion-2020
- status: barred
- barred: ephemera
- medium: text
- kb: `dharma-sangha-reunion-2020.md`
- verified: unverified
- note: secular-Buddhist community event notice; no evidential weight. Cited by DD note 0.7.

### is-rationalism-a-form-of-autism-expanded
- status: barred
- barred: self
- medium: text
- kb: `is-rationalism-a-form-of-autism.expanded.txt`
- verified: unverified
- note: corpus-internal LLM-expanded provocation; author-originated ideas here move to [A], not [S#].

### 21-a-secular-dharma-transcript
- status: barred
- barred: self
- medium: transcript
- kb: `21-a-secular-dharma.transcript.txt`
- verified: unverified
- note: NEEDS-HUMAN: author's own first-person / autobiographical prose (personal detail omitted)

### 40-children-neurodivergence-secular-dharma
- status: barred
- barred: self
- medium: transcript
- kb: `40-Children-Neurodivergence-Power-Psychopathy-Hatred-Grievance-a-secular-dharma.transcript.txt`
- verified: unverified
- note: author's own first-person / autobiographical prose (personal detail omitted)

### a-morality-of-harm-expanded-txt
- status: barred
- barred: self
- medium: text
- kb: `a-morality-of-harm.expanded.txt`
- verified: unverified
- note: prov=gd_keep_notes and filename ends .expanded.txt

### alexander-grace-female-power-decline-west
- status: barred
- barred: ephemera
- medium: transcript
- kb: `Alexander-Grace_How-Female-Power-Caused-The-Decline-Of-The-West.md`
- verified: unverified
- note: YouTube monologue by "Alexander Grace" (youtube.com/watch?v=bOeaRd5Izoc) arguing that "female power" caused the West's decline — opinion/polemic, not scholarship, carrying no evidential weight. Barred so it cannot be cited as a source. Relevant to [[6.4-gender-and-dharma]] **only as a specimen** of the gendered anti-"woke" grievance genre — i.e. an object of analysis, never a citation supporting a claim. Surfaced on the KB-review probes (2026-07-24) and typed here to keep it out of the citable pool.

### amodei-2024-machines-of-loving-grace
- status: usable
- medium: text
- cite: Dario Amodei, "Machines of Loving Grace" (darioamodei.com, October 2024)
- kb: `machines-of-loving-grace.md`
- verified: web (https://darioamodei.com/essay/machines-of-loving-grace; October 2024)

### anarkata-move-like-mycorrhizae
- status: usable
- medium: text
- cite: Anarkata, "Move Like Mycorrhizae: Some Suggestions for Praxis" (South Chicago Anarchist Black Cross / True Leap Press zine; The Anarchist Library)
- kb: `anarkata-move-like-mycorrhizae.md`
- verified: web (theanarchistlibrary.org/library/anarkata-move-like-mycorrhizae)
- note: "Anarkata" is a collective/movement name (Afrofuturist Black anarchist praxis), not an individual author.

### antara-2026-badui-seba-ritual
- status: usable
- medium: text
- cite: ANTARA News (via jawawa.id), "1,580 Badui residents prepare to celebrate the 2026 Seba ritual" (jawawa.id, 23 April 2026)
- kb: `1696298-1-580-badui-residents-prepare-to-celebrate-the-2026-seba-ritual.md`
- verified: web (jawawa.id/newsitem/1-580-badui-residents-prepare-to-celebrate-the-2026-seba-ritual-1777013684; ANTARA_ID, 23 Apr 2026)
- note: Not in the local jawawa DB (2026 item); resolved via jawawa.id search -- live URL id (1777013684) differs from the KB filename prefix (1696298); confirmed live.

### antara-baduy-200km-sacred-journey
- status: usable
- medium: text
- cite: ANTARA News, "Inside the Baduy's 200 km Sacred Journey Through the Night" (en.antaranews.com)
- kb: `1700838-inside-the-baduys-200-km-sacred-journey-through-the-night.md`
- verified: web (en.antaranews.com/news/413629/inside-the-baduys-200-km-sacred-journey-through-the-night)
- note: Confirmed exact title/outlet via web search; jawawa.id item is an archived copy of this ANTARA News piece on the Seba pilgrimage.

### aristotle-durant-we-are-what-we-repeatedly-do
- status: usable
- medium: text
- cite: Attributed to Aristotle ("We are what we repeatedly do; excellence, then, is not an act, but a habit") -- the wording is Will Durant's 1926 paraphrase of Aristotle's Nicomachean Ethics, in The Story of Philosophy (Simon & Schuster)
- kb: `repeatedly-excellence-act-habit-aristotle_gpt-4o-mini.md`
- verified: web (ISBN 9780671201593; Will Durant, The Story of Philosophy, 1926)
- note: prov=zenquotes; KB text is an LLM (gpt-4o-mini) discourse generated from a Zenquotes quote card, not a summary of a specific parent document. NEEDS-HUMAN: confirm how the note should represent the Aristotle/Durant attribution nuance.

### sapolsky-father-offspring-61-asd-genetics
- status: usable
- medium: transcript
- cite: Robert Sapolsky, "#61: De-extinction, Jen Aniston Neurons, ASD Vaccines," Robert Sapolsky | Father-Offspring Interviews (YouTube, video ID WWyBslf98XE)
- kb: `sapolsky-061-de-extinction-jen-aniston-neurons-asd-vaccines.txt`
- verified: video-URL (https://www.youtube.com/watch?v=WWyBslf98XE; manual subtitles per header)
- note: Lay account of autism genetics in reply to the 2025 US HHS "not genetic" claim: heritability "50, 60%," de novo mutations, polygenic architecture, copy-number variants, small-effect prenatal exposures, parenting excluded.

### sapolsky-father-offspring-85-history-of-asd
- status: usable
- medium: transcript
- cite: Robert Sapolsky, "#85: Obesity, Deja Vu, History of ASD," Robert Sapolsky | Father-Offspring Interviews (YouTube, video ID k4tOF47_K8A)
- kb: `sapolsky-085-obesity-deja-vu-history-of-asd.txt`
- verified: video-URL (https://www.youtube.com/watch?v=k4tOF47_K8A; manual subtitles per header)
- note: Sapolsky relays Baron-Cohen's The Pattern Seekers (systemising as a ~100,000-year human novelty; frequency-dependent selection) with his own brakes — "I wish he had backed this up with a little bit more" and the unaddressed Neanderthal-introgression timing problem.

### schein-gray-2018-theory-of-dyadic-morality
- status: usable
- medium: text
- cite: Chelsea Schein & Kurt Gray, "The Theory of Dyadic Morality: Reinventing Moral Judgment by Redefining Harm," *Personality and Social Psychology Review* 22:1 (2018), 32–70, DOI 10.1177/1088868317698288
- kb: `Schein-Gray_The-Theory-of-Dyadic-Morality_PSPR-2018_author-copy.md`
- verified: file (journal header with DOI and page range at seg 0; author copy)
- note: Harm as the fundamental basis of moral judgement; the monothetic rival to the family-resemblance treatment of the moral/conventional line.

### schilbrack-2022-concept-of-religion-sep
- status: usable
- medium: text
- cite: Kevin Schilbrack, "The Concept of Religion," *Stanford Encyclopedia of Philosophy* (first published 28 March 2022)
- kb: `Schilbrack_The-Concept-of-Religion_SEP-2022.md` (full text, folded into the corpus 2026-08); `kevin-schilbrack_the-concept-of-religion_sep-2022.md` (attributed summary, in corpus under staging.text/DD/sources/oldsources/)
- verified: web (https://plato.stanford.edu/entries/concept-religion/)
- note: attributed summary note with verified page anchors (section-anchored). The standard reply to Asad — realism about social structures plus map-against-territory testability. ▲ Does NOT license 'disclosed authorship' as a defence; holds polythetic framings 'equally ethnocentric'; and warns that functionally defined universality 'is not a discovery but a product of one's definition' — the sharpest published pressure on Part 1's 'every society grows one'. Open access.

### schimmelpfennig-et-al-2022-paradox-of-diversity
- status: usable
- medium: text
- cite: Robin Schimmelpfennig, Layla Razek, Eric Schnell & Michael Muthukrishna, "Paradox of diversity in the collective brain," *Philosophical Transactions of the Royal Society B* 377 (2022), 20200316, DOI 10.1098/rstb.2020.0316 (PMC8666911)
- kb: `PMC8666911-paradox-of-diversity-in-the-collective-brain.md`
- verified: file (PMC header with journal, year and PMCID at seg 0; only abstract, introduction and conclusion ingested — 3 segments)
- note: Cultural-trait diversity as fuel for recombination and a cost to coordination and trust; "cultural evolvability" as the resolving frame. Cultural, not neuro-cognitive, diversity — use by analogy only.

### schlerath-skjaervo-1987-asa-iranica
- status: usable
- medium: text
- cite: B. Schlerath & P. O. Skjærvø, "AŠA," *Encyclopædia Iranica* II/7 (1987): 694–696 (online ed.)
- kb: `Iranica_ASA_Schlerath-Skjaervo_wayback.md` (full text, folded into the corpus 2026-08); `schlerath-skjaervo_asa_encyclopaedia-iranica.md` (attributed summary, in corpus under staging.text/DD/sources/oldsources/)
- verified: web (iranicaonline.org/articles/asa-means-truth-in-avestan; consulted via Wayback snapshot 2023-11-17)
- note: attributed summary note with verified page anchors. Confirms *asha*/*ṛta* as the same Indo-Iranian word (Part 1's 'same word in different mouths' now on bedrock); reconstructs \**ṛtām dhar-* 'to uphold the truth' among the oldest shared formulas (~2000 BCE) — dharma's root formulaically paired with ṛta. ▲ With Lüders and Halbfass, argues the rendering is 'truth', not bare 'cosmic order'. Replaces zoroastrian.org / hinduwebsite.com in note 1.4 (S8). Cited by DD note 1.1.

### schlosser-et-al-2019-unpleasant-meditation-related-experiences
- status: usable
- medium: text
- cite: Marco Schlosser, Terje Sparby, Sebastjan Vörös, Rebecca Jones & Natalie L Marchant, "Unpleasant meditation-related experiences in regular meditators: Prevalence, predictors, and conceptual considerations," *PLoS ONE* 14:5 (2019), e0216643, DOI 10.1371/journal.pone.0216643
- kb: `Schlosser-et-al_Unpleasant-Meditation-Related-Experiences-in-Regular-Meditators_PLoSONE-2019.md`
- verified: file (PLoS ONE DOI and date "May 9, 2019" in running footer at segs 1, 8)
- note: Regular-meditator survey; unpleasant experiences unrelated to practice dose; fewer than 25% of trials assess adverse events. Cited by DD note 5.1.

### schulz-et-al-2019-church-intensive-kinship
- status: usable
- medium: text
- cite: Jonathan F Schulz, Duman Bahrami-Rad, Jonathan P Beauchamp & Joseph Henrich, "The Church, intensive kinship, and global psychological variation," *Science* 366:6466 (2019), eaau5141, DOI 10.1126/science.aau5141
- kb: `Schulz-et-al_The-Church-Intensive-Kinship-and-Global-Psychological-Variation_Science-2019.md`
- verified: file (structured abstract at segs 0–1; results with correlation magnitudes at seg 8)
- note: The Marriage and Family Program dissolving intensive kinship → impersonal prosociality; the case that a code can manufacture stranger-society psychology.

### schumacher-1966-buddhist-economics
- status: usable
- medium: text
- cite: EF Schumacher, "Buddhist Economics," in Guy Wint (ed.), *Asia: A Handbook* (London: Anthony Blond, 1966); repr. in *Small Is Beautiful: Economics as if People Mattered* (London: Blond & Briggs, 1973), ch. 4
- kb: `Schumacher_Buddhist-Economics_1973.md`
- verified: file (publication history in seg 0 — 1966 first printing, Resurgence 1968, MANAS 1969, Small Is Beautiful 1973; born-digital web text with footnote anchors; 10 segments)
- note: The threefold function of work, the Middle Way on wealth ("not wealth… but the attachment to wealth"), "simplicity and non-violence," local production; Coomaraswamy's tool/machine distinction.

### schwerk-2022-review-payne-secularizing-buddhism
- status: usable
- medium: text
- cite: Dagmar Schwerk, review of Richard K Payne (ed.), *Secularizing Buddhism: New Perspectives on a Dynamic Tradition* (Shambhala, 2021), *Journal of Global Buddhism* 23:1 (2022), 87–94, DOI 10.26034/lu.jgb.2022.2331
- kb: `Schwerk_Review-of-Payne-Secularizing-Buddhism_JGB-2022.md`
- verified: file (journal header with volume, pages and DOI in seg 0)
- note: Reports Bodhi's "cut off the bloodline" and Turenne's three criticisms of Batchelor with the volume's page numbers; the chapters themselves are not in the corpus.

### scott-1976-the-moral-economy-of-the-peasant
- status: usable
- medium: text-ocr
- cite: James C Scott, *The Moral Economy of the Peasant: Rebellion and Subsistence in Southeast Asia* (New Haven: Yale University Press, 1976)
- kb: `Scott_The-Moral-Economy-of-the-Peasant_1976.md`
- verified: file (314 segments; subsistence-ethic passages located, e.g. seg 256)
- note: The subsistence ethic and the "safety-first" peasant; frame for the Samin's defence of customary access. OCR scan — pointer, not quotable.

### scott-1985-weapons-of-the-weak
- status: usable
- medium: text-ocr
- cite: James C Scott, *Weapons of the Weak: Everyday Forms of Peasant Resistance* (New Haven: Yale University Press, 1985)
- kb: `Scott_Weapons-of-the-Weak_1985.md`
- verified: file (OCR provenance header at seg 0 lists pages transcribed 1–2, 147, 228, 297, 300, 302 only)
- note: ▲ Partial scan — title pages and six body pages. Usable to anchor the title and the everyday-resistance vocabulary, not the argument; cite the printed edition for substance.

### scott-1990-domination-and-the-arts-of-resistance
- status: usable
- medium: text-ocr
- cite: James C Scott, *Domination and the Arts of Resistance: Hidden Transcripts* (New Haven: Yale University Press, 1990)
- kb: `Scott_Domination-and-the-Arts-of-Resistance_1990.md`
- verified: file (tesseract OCR header; preface at seg 1, hidden-transcript definition at seg 3)
- note: Hidden transcripts — offstage dissent as the standpoint that survives where open dissent is denied.

### scott-2017-against-the-grain
- status: usable
- medium: text
- cite: James C Scott, *Against the Grain: A Deep History of the Earliest States* (New Haven: Yale University Press, 2017)
- kb: `james-c-scott_against-the-grain.md`
- verified: file (title page, 2017, preface naming the 2011 Tanner Lectures at seg 0; Anarchist Library-style transcription with PDF source URL)
- note: State-sceptical deep history of Mesopotamian state formation: the early state as "wobbly," flight to the periphery recorded only in legal codes, stateness as a continuum.

### sen-1979-equality-of-what
- status: usable
- medium: text
- cite: Amartya Sen, "Equality of What?", The Tanner Lecture on Human Values, Stanford University, 22 May 1979; in *The Tanner Lectures on Human Values* I (1980), 195–220
- kb: `Sen_Equality-of-What_Tanner-Lecture-1979.md`
- verified: file (running heads "The Tanner Lectures on Human Values" with pages 218–219 at segs 20–21; the "basic capabilities" passage at seg 20)
- note: The origin of the capabilities approach — "basic capabilities: a person being able to do certain basic things" against utility and primary-goods metrics.

### sep-friedrich-nietzsche
- status: usable
- medium: text
- cite: "Friedrich Nietzsche," *Stanford Encyclopedia of Philosophy*
- kb: —
- verified: web 2026-07-27 (fetched; cited reception-history content confirmed)
- note: Elisabeth Förster-Nietzsche's control of the literary estate and its antisemitic editorial distortion; the mid-century might-makes-right reception and Kaufmann's recuperation. <https://plato.stanford.edu/entries/nietzsche/>

### sep-nietzsche-moral-political-philosophy
- status: usable
- medium: text
- cite: "Nietzsche's Moral and Political Philosophy," *Stanford Encyclopedia of Philosophy* (first pub. 2004; substantive revision 5 Sep 2024)
- kb: —
- verified: web 2026-07-27 (fetched; existence, revision date, and cited content confirmed)
- note: the critique of morality as thwarting the highest human types; the privilege-readings vs anti-realism dispute over Nietzsche's own evaluative standpoint. <https://plato.stanford.edu/entries/nietzsche-moral-political/>

### shahin-2016-nietzsche-and-anarchy
- status: usable
- medium: text
- cite: Shahin, *Nietzsche and Anarchy* (Elephant Editions / Active Distribution, 2016)
- kb: `shahin_nietzsche-and-anarchy.md`
- verified: unverified
- note: pseudonymous author; publication by Elephant Editions/Active Distribution stated in the file itself. Cited in 3.4 only as reception evidence (anarchist reappropriation of Nietzsche), never as Nietzsche interpretation. Cited by DD note 3.4.

### shariff-norenzayan-2007-god-is-watching-you
- status: usable
- medium: text
- cite: Azim F Shariff & Ara Norenzayan, "God Is Watching You: Priming God Concepts Increases Prosocial Behavior in an Anonymous Economic Game," *Psychological Science* 18:9 (2007), 803–809, DOI 10.1111/j.1467-9280.2007.01983.x
- kb: `Shariff-Norenzayan_God-Is-Watching-You_PsychSci-2007.md`
- verified: file (abstract at seg 0; journal details from the abstract header)
- note: The founding priming study for supernatural monitoring; effect comparable to secular-institution primes and unrelated to self-reported religiosity.

### shiraishi-1990-dangirs-testimony
- status: usable
- medium: text
- cite: Takashi Shiraishi, "Dangir's Testimony: Saminism Reconsidered," *Indonesia* 50 (October 1990): 95–120 (Cornell Southeast Asia Program)
- kb: `Shiraishi_Dangirs-Testimony-Saminism-Reconsidered_Indonesia-1990.md`
- verified: file (author and two-part structure at seg 0; running head "Dangir's Testimony 115" at seg 41)
- note: Translation of the 1928 Pati interrogation minutes plus commentary: "doubly alienated"; spies' "fantastic mixture"; the doctrine of language ("It is man who utters the word"); *wong sikep* vs the state's "Samin" label.

### singh-glowacki-2022-beyond-the-nomadic-egalitarian-model
- status: usable
- medium: text
- cite: Manvir Singh & Luke Glowacki, "Human social organization during the Late Pleistocene: Beyond the nomadic-egalitarian model," *Evolution and Human Behavior* 43:5 (2022): 418–431
- kb: `Singh-Glowacki_Beyond-the-Nomadic-Egalitarian-Model_EHB-2022.md`
- verified: file (accepted-manuscript header and abstract in seg 0, "last updated July 19, 2022")
- note: the diverse-Pleistocene model against the nomadic-egalitarian baseline; names Boehm, Migliano, Tooby & Cosmides as work built on the model it challenges.

### skeem-cooke-2010-is-criminal-behavior-central-to-psychopathy
- status: usable
- medium: text
- cite: Jennifer L Skeem & David J Cooke, "Is Criminal Behavior a Central Component of Psychopathy? Conceptual Directions for Resolving the Debate," *Psychological Assessment* 22:2 (2010), 433–445, DOI 10.1037/a0008512
- kb: `SkeemCooke_Is-Criminal-Behavior-a-Central-Component-of-Psychopathy_PsychAssess-2010.md`
- verified: file (APA masthead with volume, pages and DOI at seg 3)
- note: The construct-validity critique of the PCL-R paradigm: measure conflated with construct; criminal behaviour a downstream correlate, not the core. The internal counterweight to Hare.

### skeem-cooke-2010-one-measure-does-not-a-construct-make
- status: usable
- medium: text
- cite: Jennifer L Skeem & David J Cooke, "One Measure Does Not a Construct Make: Directions Toward Reinvigorating Psychopathy Research — Reply to Hare and Neumann (2010)," *Psychological Assessment* 22:2 (2010), 455–459
- kb: `SkeemCooke_One-Measure-Does-Not-a-Construct-Make-Reply-to-Hare-Neumann_PsychAssess-2010.md`
- verified: file (title and author block at seg 0; page range from the published record, not web-checked)
- note: Rejoinder recording Hare & Neumann's partial concession that criminal behaviour is not central to psychopathy; the "gold standard" slip.

### slingerland-2000-effortless-action
- status: usable
- medium: text-ocr
- cite: Edward Slingerland, "Effortless Action: The Chinese Spiritual Ideal of Wu-wei," *Journal of the American Academy of Religion* 68:2 (2000): 293–328
- kb: `Slingerland_Effortless-Action-Wu-wei_JAAR-2000.md` (full text, folded into the corpus 2026-08); `edward-slingerland_effortless-action-wu-wei_2000.md` (attributed summary, in corpus under staging.text/DD/sources/oldsources/)
- verified: web (DOI 10.1093/jaarel/68.2.293; author-self-archived PDF)
- note: attributed summary note with verified page anchors. Wu-wei as pan-Chinese ideal, not Daoist-specific — documented from the *Odes* through Confucius, Mencius, Xunzi, Laozi, Zhuangzi ('counter a common perception of wu-wei as an exclusively Daoist ideal,' p. 297). Upgrades note 1.4 (S10); the paradox of wu-wei cross-links to note 3.1. ▲ ABBYY OCR artefacts in scan; key quotes checked against page images.

### slingerland-etal-2020-coding-culture
- status: usable
- medium: text
- cite: Edward Slingerland, Quentin D. Atkinson, Carol R. Ember, Oliver Sheehan, Michael Muthukrishna, Joseph Bulbulia & Russell D. Gray, "Coding culture: challenges and recommendations for comparative cultural databases," *Evolutionary Human Sciences* 2 (2020): e29
- kb: `slingerland-et-al_coding-culture_2020.md` (attributed summary, staged at workshops/DD/sources/ — not yet folded into corpus)
- verified: web (DOI 10.1017/ehs.2020.30; CC BY 4.0)
- note: attributed summary note with verified page anchors. The eHRAF coding-validity critique by database insiders (Ember is HRAF; authors declare involvement in DRH, eHRAF, Pulotu, D-PLACE). A methods paper, not a debunking — seven recommendations. Bears on every 'coded across N societies' claim behind note 1.2. Safe to archive. Cited by DD note 1.2.

### smith-1998-religion-religions-religious
- status: usable
- medium: text-ocr
- cite: Jonathan Z Smith, "Religion, Religions, Religious," in Mark C Taylor (ed.), *Critical Terms for Religious Studies* (Chicago: University of Chicago Press, 1998), ch. 15, pp. 269–284
- kb: `Taylor-ed_Critical-Terms-for-Religious-Studies_1998_incl-JZSmith.md`
- verified: file (the closing "not a native term … theirs to define" paragraph quoted verbatim in Taylor's introduction at seg 9, attributed "(Chap. 15)"; the chapter's own text not located by keyword in the file — letter-spaced OCR in places; McKinnon 2002 gives the same passage as 1998:281–2)
- note: The whole edited volume is in the corpus under this filename; the register entry is for Smith's chapter, the one DD cites. Religion as a scholar-made second-order generic concept.

### smith-2017-communal-secularity-sunday-assembly
- status: usable
- medium: text
- cite: Jesse M Smith, "Communal Secularity: Congregational Work at the Sunday Assembly," in Ryan T Cragun, Christel Manning & Lori L Fazzino (eds), *Organized Secularism in the United States: New Directions in Research* (Berlin: De Gruyter, 2017), pp. 151–170
- kb: `Smith_Communal-Secularity-Congregational-Work-at-the-Sunday-Assembly_2017.md`
- verified: file (chapter title and introduction at seg 0; volume and page range from the published record, not web-checked)
- note: The one ethnography of a secular congregation in the corpus: services "sacralize the secular"; without a core faith message the Assembly places little demand on members.

### smith-et-al-2017-hunter-gatherer-storytelling
- status: usable
- medium: text
- cite: Daniel Smith, Philip Schlaepfer, Katie Major, Mark Dyble, Abigail E Page, James Thompson, Nikhil Chaudhary, Gul Deniz Salali, Ruth Mace, Leonora Astete, Marilyn Ngales, Lucio Vinicius & Andrea Bamberg Migliano, "Cooperation and the evolution of hunter-gatherer storytelling," *Nature Communications* 8 (2017), 1853, DOI 10.1038/s41467-017-02036-8 (CC BY 4.0)
- kb: `Smith-et-al_Cooperation-and-the-Evolution-of-Hunter-Gatherer-Storytelling_NatComms-2017.md`
- verified: file (results, Table 1 and discussion at segs 2–15; reference list at seg 32 cites Purzycki 2016 and Watts 2015; heading fragments from PDF superscripts scattered through the text)
- note: The Agta storytelling study itself; replaces the prosocial.world write-up as the anchor. "'Broadcasting' cooperative norms"; coordination via meta-knowledge; storytellers preferred over foragers as camp-mates.

### sorensen-et-al-2024-roadmap-to-pluralistic-alignment
- status: usable
- medium: text
- cite: Taylor Sorensen, Jared Moore, Jillian Fisher, Mitchell Gordon, Niloofar Mireshghallah, Christopher Michael Rytting, Andre Ye, Liwei Jiang, Ximing Lu, Nouha Dziri, Tim Althoff & Yejin Choi, "Position: A Roadmap to Pluralistic Alignment," *Proceedings of the 41st International Conference on Machine Learning* (PMLR 235, 2024); arXiv:2402.05070
- kb: `Sorensen-et-al_A-Roadmap-to-Pluralistic-Alignment_arXiv-2402.05070.md`
- verified: file (title, twelve authors and abstract at seg 0; arXiv id from the filename)
- note: Overton / steerable / distributional pluralism; evidence that standard alignment reduces distributional pluralism.

### sosis-bressler-2003-commune-longevity
- status: usable
- medium: text
- cite: Richard Sosis & Eric R Bressler, "Cooperation and Commune Longevity: A Test of the Costly Signaling Theory of Religion," *Cross-Cultural Research* 37:2 (2003), 211–239, DOI 10.1177/1069397103251426
- kb: `Sosis-Bressler_Cooperation-and-Commune-Longevity_CCR-2003.md`
- verified: file (DOI and running heads "Sosis, Bressler / COMMUNE LONGEVITY 215–222" in segs 0–13; Table 2 at seg 13)
- note: 83 nineteenth-century US communes, 1,556 commune-years; religious communes mean 35.6 years vs secular 7.7, anarchist 9 (n = 7); costly requirements predict survival.

### stanley-yin-sinnott-armstrong-2019-reason-based-explanation-moral-dumbfounding
- status: usable
- medium: text
- cite: Matthew L Stanley, Siyuan Yin & Walter Sinnott-Armstrong, "A reason-based explanation for moral dumbfounding," *Judgment and Decision Making* 14:2 (2019), 120–129, DOI 10.1017/S1930297500003351
- kb: `Stanley-Yin-SinnottArmstrong_A-Reason-Based-Explanation-for-Moral-Dumbfounding_JDM-2019.md`
- verified: file (journal header and DOI at segs 0–2)
- note: Follow-up to Royzman et al: the residue of unreversed judgments explained by unstated harm-related reasons (80% initially not OK; 32% OK after failing to justify).

### stanner-1958-continuity-and-change
- status: usable
- medium: text-ocr
- cite: WEH Stanner, "Continuity and Change among the Aborigines," Presidential Address, Section F, ANZAAS, *Australian Journal of Science* 21:5A (1958); repr. in *White Man Got No Dreaming: Essays 1938–1973* (Canberra: ANU Press, 1979), pp. 41–66
- kb: `Stanner_Continuity-and-Change_White-Man-Got-No-Dreaming-excerpt_1958.md`
- verified: file (tesseract OCR of the ANU Press reprint; running head "Continuity and Change (1958)" at seg 32; letter-spaced throughout — quotations reassembled by hand from segs 35 and 50)
- note: Stanner's own statement of the Dreaming as a set of once-for-all value-doctrines held by a self-regulating society without state instrumentalities; "The Dreaming and The Market are mutually exclusive." Pointer only for wording.

### stanner-1963-on-aboriginal-religion
- status: usable
- medium: text-ocr
- cite: WEH Stanner, *On Aboriginal Religion* (Oceania Monograph 11, 1963; new ed. with introduction by Ian Keen, Sydney: Sydney University Press, 2014)
- kb: `Stanner_On-Aboriginal-Religion_SydneyUP-2014.md`
- verified: file (Keen's introduction "On Aboriginal Religion: An Appreciation" at segs 18–20; Murinbata essays with original pagination in running heads, e.g. "On Aboriginal Religion 69" at seg 145)
- note: The Murinbata essays; Keen's introduction supplies the "once-for-all … everywhen" summary of Stanner's ontology and the Stanner 1965 reference for the coinage.

### stenmark-2022-worldview-studies
- status: usable
- medium: text
- cite: Mikael Stenmark, "Worldview studies," *Religious Studies* 58 (2022): 564–582 (online-first 2021)
- kb: `mikael-stenmark_worldview-studies_2021.md` (attributed summary, staged at workshops/DD/sources/ — not yet folded into corpus)
- verified: web (DOI 10.1017/S0034412521000135; CC BY 4.0)
- note: attributed summary note with verified page anchors. The closest published ally to DD's central move: secular and religious outlooks as species of one genus. His worldview = life-orienting constellation of beliefs, values and attitudes, consciously held or not; practice acknowledged but never criterial — DD's dharma ≈ worldview with behaviour and belonging promoted to defining features. ▲ Philosopher on Western materials; cross-cultural claims cannot be outsourced to him.

### stewart-2015-dharma-punx-rebel-dharma
- status: usable
- medium: text
- cite: Francis Stewart, "The anarchist, the punk rocker and the Buddha walk into a bar(n): Dharma Punx and Rebel Dharma," *Punk & Post Punk* 4:1 (2015): 71–89
- kb: `francis-stewart_dharma-punx-and-rebel-dharma_2015.md` (attributed summary, staged at workshops/DD/sources/ — not yet folded into corpus)
- verified: web (DOI 10.1386/punk.4.1.71_1; green-OA accepted manuscript, Stirling STORRE)
- note: attributed summary note with verified page anchors (▲ manuscript pagination — convert when citing; ms is pre-copyedit, e.g. 'Vispanna'). Fieldwork on Dharma Punx (US) and Rebel Dharma (UK). ▲ Verdict for Part 1's borderline case: punk supplies identity, code, community; every transformative practice is imported from Buddhism via Levine — supports the 'two or three out of four' hedge rather than resolving it. Cross-links the corpus's Ronan/Prouty fusion specimens.

### suhler-churchland-2011-can-innate-modular-foundations-explain-morality
- status: usable
- medium: text-ocr
- cite: Christopher L Suhler & Patricia Churchland, "Can Innate, Modular 'Foundations' Explain Morality? Challenges for Haidt's Moral Foundations Theory," *Journal of Cognitive Neuroscience* 23:9 (2011), 2103–2116
- kb: `Suhler-Churchland_Can-Innate-Modular-Foundations-Explain-Morality_2011.md`
- verified: file (tesseract OCR, 21 pages; abstract at seg 0 with author garbled to "Subler"; conclusion at seg 25; journal/pages from the published record)
- note: The innateness/modularity critique of MFT; "neither modules nor innateness in any explanatorily useful sense." OCR — pointer, verify wording against print before quoting.

### sukirno-2018-diskriminasi-hak-sipil-agama-lokal
- status: usable
- medium: text
- cite: Sukirno, "Diskriminasi Pemenuhan Hak Sipil Bagi Penganut Agama Lokal," *Administrative Law & Governance Journal* 1:3 (August 2018), 231–, Universitas Diponegoro
- kb: `Sukirno_Diskriminasi-Pemenuhan-Hak-Sipil-Penganut-Agama-Lokal_ALJ-2018.md`
- verified: file (journal header, volume and ISSN at seg 0; MK 97/PUU-XIV/2016 and the 2018 circular at segs 11–12)
- note: Population-document discrimination against penghayat and local-religion adherents (Sedulur Sikep, Parmalim) from the 1978 Home Affairs circular to the Adminduk law, and the piecemeal implementation of the 2017 Court ruling. Gives the decision date as 18 October 2017. Cited by DD notes 3.5.1, 3.5.4.

### sule-2022-xenophobia-end-of-ontological-ubuntu
- status: usable
- medium: text
- cite: Peter Echewija Sule, "Xenophobia and the end of ontological Ubuntu," *Acta Academica* 54:2 (2022), art. 4, DOI 10.18820/24150479/aa54i2/4
- kb: `Matolino_Xenophobia-and-the-End-of-Ontological-Ubuntu_SAJP-2022.md`
- verified: web (SciELO article page and Acta Academica record, checked 2026-08-27)
- note: ▲ The corpus filename misattributes this paper to Bernard Matolino; the author is Sule (Federal University of Lafia), responding to Matolino & Kwindingwi 2013. Internal African critique of "ontological Ubuntu" (Africans-as-communalists) via the xenophobia case; keeps only an axiological, prescriptive Ubuntu. The dissolution strategy's own critic.

### sumarah-net-homepage
- status: usable
- medium: text
- cite: sumarah.net, front page ("Life is but a stop along the path to drink a glass of tea"), accessed 2026
- kb: `Sumarah-net_homepage.md`
- verified: file (single segment; self-description text)
- note: Insider self-description of the Western Sumarah network — "a philosophy of life and a form of meditation". Cited by DD notes 3.5, 3.5.1, 3.5.2, 3.5.4.

### supratikno-adi-2023-samin-community-globalization-era
- status: usable
- medium: text
- cite: Supratikno & Suwarto Adi, "The Samin Community in the Globalization Era: Role of the Religion of Adam in the Post-Cement Industry Advocacy" (Satya Wacana Christian University, Salatiga, 2023)
- kb: `Supratikno-Adi_The-Samin-Community-in-the-Globalization-Era_2023.md`
- verified: file (title and second author at seg 0; ▲ first author's name and the venue are not recoverable from the ingested text — taken from the filename)
- note: Sukolilo (Pati) study; Agama Adam glossed by informants as *pangucap* (utterance) — "*mbecikna laku, ngugemi ucap*"; faith as resource against the cement industry.

### taves-2009-religious-experience-reconsidered
- status: usable
- medium: text-ocr
- cite: Ann Taves, *Religious Experience Reconsidered: A Building-Block Approach to the Study of Religion and Other Special Things* (Princeton: Princeton University Press, 2009)
- kb: `Taves_Religious-Experience-Reconsidered_2009.md` (full text, folded into the corpus 2026-08); `ann-taves_religious-experience-reconsidered_2009.md` (attributed summary, in corpus under staging.text/DD/sources/oldsources/)
- verified: web (ISBN 978-0-691-14087-2, from the copyright page)
- note: attributed summary note with verified page anchors. The methodological middle way: composites ('religions') are scholars' aggregates, but comparison rebuilds from smaller units — ascriptions of specialness, 'a deeply rooted human characteristic' (p. 34) offered as a testable hypothesis, not a fiat universal. Her mārga-derived 'special path' is the closest published analogue to dharma-as-path. Model for recasting 'every society grows one'. Full text in DD local archive (scratch/sources/part1/, gitignored); community upload. Cited by DD note 3.5.3.

### taylor-2007-a-secular-age
- status: usable
- medium: text-ocr
- cite: Charles Taylor, *A Secular Age* (Cambridge, MA: Belknap Press of Harvard University Press, 2007)
- kb: `Taylor_A-Secular-Age_2007.md`
- verified: file (contents page at seg 1 with part/chapter pagination; "subtraction stories" definition at seg 32 = p. 22; tesseract OCR with letter-spaced running heads)
- note: Full text of the book; the subtraction-story polemic, exclusive humanism, the nova effect and the fragilisation of all positions. Pointer only for quotation — verify wording against print.

### teeter-1997-presentation-of-maat
- status: usable
- medium: text-ocr
- cite: Emily Teeter, *The Presentation of Maat: Ritual and Legitimacy in Ancient Egypt*, Studies in Ancient Oriental Civilization 57 (Chicago: Oriental Institute, 1997)
- kb: `Teeter_The-Presentation-of-Maat_SAOC-57_1997.md` (full text, folded into the corpus 2026-08); `emily-teeter_the-presentation-of-maat_1997.md` (attributed summary, in corpus under staging.text/DD/sources/oldsources/)
- verified: web (official OI/ISAC open-access edition, isac.uchicago.edu; ISBN 1-885923-05-1)
- note: attributed summary note with verified page anchors. 205 catalogued scenes, Thutmose III to Aspelta: presenting maat was a royal monopoly bound to legitimacy — the king upholds a primordial order he never makes. ▲ Structural echo of Olivelle's royal-vocabulary dharma — both orders begin as king-maintained legitimacy machinery. Iconographic study: do not cite for ethical content (that is Lichtheim). Safe to archive.

### tinbergen-1963-on-aims-and-methods-of-ethology
- status: usable
- medium: text-ocr
- cite: Niko Tinbergen, "On Aims and Methods of Ethology," *Zeitschrift für Tierpsychologie* 20 (1963): 410–433
- kb: `Tinbergen_On-Aims-and-Methods-of-Ethology_1963.md`
- verified: file (segs 11–12; heavily garbled OCR — "survival yvaluc", "Echology")
- note: origin of the four questions (causation, ontogeny, evolution, survival value). Pointer only; verify any wording against the printed article.

### trc-south-africa-1998-final-report-vol-1
- status: usable
- medium: text
- cite: Truth and Reconciliation Commission of South Africa, *Truth and Reconciliation Commission of South Africa Report*, Volume 1 (Cape Town: TRC, 29 October 1998), incl. the Chairperson's Foreword and ch. 5 "Concepts and Principles"
- kb: `TRC-South-Africa_Final-Report-Volume-1_1998.md`
- verified: file (running heads "V O L U M E 1 C H A P T E R 1 Foreword by Chairperson" at seg 6; ch. 5 heading at seg 109)
- note: The Commission's own account of its mandate; the founding Act's preamble ("a need for ubuntu but not for victimisation") at seg 8.

### trc-south-africa-1998-final-report-vol-5
- status: usable
- medium: text
- cite: Truth and Reconciliation Commission of South Africa, *Truth and Reconciliation Commission of South Africa Report*, Volume 5 (Cape Town: TRC, 29 October 1998), incl. ch. 9 "Reconciliation"
- kb: `TRC-South-Africa_Final-Report-Volume-5_1998.md`
- verified: file (reconciliation/restorative-justice paragraphs numbered 145–149 at seg 488; "spirit of ubuntu" and dignity passage at seg 498)
- note: The report's statement of restorative justice — revenge and impunity both refused; dignity "can only be acknowledged."

### trivers-1971-evolution-of-reciprocal-altruism
- status: usable
- medium: text
- cite: Robert L Trivers, "The Evolution of Reciprocal Altruism," *Quarterly Review of Biology* 46:1 (1971): 35–57
- kb: `Trivers_The-Evolution-of-Reciprocal-Altruism_1971.md`
- verified: file (abstract in seg 0; running head "MARCH 1971 RECIPROCAL ALTRUISM 49" in seg 29)
- note: founding model for selection against the cheater; moralistic aggression, gratitude, guilt as regulators of the altruistic system.

### turchin-whitehouse-et-al-2022-explaining-rise-of-moralizing-religions
- status: usable
- medium: text
- cite: Peter Turchin, Harvey Whitehouse et al., "Explaining the rise of moralizing religions: a test of competing hypotheses using the Seshat Databank," *Religion, Brain & Behavior* 13:2 (2023, online 2022), 167–194, DOI 10.1080/2153599X.2022.2065345 (CC BY)
- kb: `Turchin-Whitehouse-et-al_Explaining-the-Rise-of-Moralizing-Religions_RBB-2022_published.md`, `Turchin-Whitehouse-et-al_Explaining-the-Rise-of-Moralizing-Religions_2019-preprint.md`
- verified: file (abstract, Taylor & Francis open-access notice and © 2022 line at seg 0 of the published file; volume/issue/pages not checked against the journal page)
- note: The Seshat team's reworked analysis after the retraction: warfare and resource availability as common drivers of both social complexity and moralizing religion. Cite for what replaced the retracted claim, never as its vindication.

### tutu-1999-no-future-without-forgiveness
- status: usable
- medium: text-ocr
- cite: Desmond Tutu, *No Future Without Forgiveness* (New York: Doubleday, 1999)
- kb: `Tutu_No-Future-Without-Forgiveness_1999.md`
- verified: file (tesseract OCR provenance header; title page and Kirkus blurb at seg 0; the ubuntu definition passage at segs 24–25 checked)
- note: The TRC chair's own statement of ubuntu — "A person is a person through other persons"; "the best form of self-interest." Quotable only after checking against print.

### twenge-campbell-2018-screen-time-psychological-well-being
- status: usable
- medium: text
- cite: Jean M Twenge & W Keith Campbell, "Associations between screen time and lower psychological well-being among children and adolescents: Evidence from a population-based study," *Preventive Medicine Reports* 12 (2018), 271–283
- kb: `Twenge-Campbell_Associations-Between-Screen-Time-and-Lower-Psychological-Well-Being_PrevMedRep-2018.md`
- verified: file (title, authors, abstract at seg 0; volume/pages from the published record)
- note: n = 40,337 NSCH 2016; after 1 h/day, more screen time associated with lower wellbeing.

### twenge-et-al-2018-depressive-symptoms-new-media-screen-time
- status: usable
- medium: text
- cite: Jean M Twenge, Thomas E Joiner, Megan L Rogers & Gabrielle N Martin, "Increases in Depressive Symptoms, Suicide-Related Outcomes, and Suicide Rates Among U.S. Adolescents After 2010 and Links to Increased New Media Screen Time," *Clinical Psychological Science* 6:1 (2018), 3–17
- kb: `Twenge-et-al_Increases-in-Depressive-Symptoms-and-Suicide-Related-Outcomes_ClinPsychSci-2018.md`
- verified: file (title, authors, abstract at seg 1; received/accepted dates present; volume/pages from the published record)
- note: The alarm side of the adolescent-wellbeing dispute; N = 506,820.

### van-dam-et-al-2018-mind-the-hype
- status: usable
- medium: text
- cite: Nicholas T Van Dam, Marieke K van Vugt, David R Vago, Laura Schmalzl, Clifford D Saron, Andrew Olendzki, Ted Meissner, Sara W Lazar, Catherine E Kerr, Jolie Gorchov, Kieran C R Fox, Brent A Field, Willoughby B Britton, Julie A Brefczynski-Lewis & David E Meyer, "Mind the Hype: A Critical Evaluation and Prescriptive Agenda for Research on Mindfulness and Meditation," *Perspectives on Psychological Science* 13:1 (2018), 36–61, DOI 10.1177/1745691617709589
- kb: `VanDam-et-al_Mind-the-Hype_PPS-2018_published-version.md`, `VanDam-et-al_Mind-the-Hype_PPS-2018.md`
- verified: file (published-version file: section headings and reference list at segs 0–13, 44; author list and DOI not re-checked online)
- note: Self-report and construct-validity problems in mindfulness research; the retreat to neurobehavioural proxies. Cited by DD notes 3.2, 3.5.3, 5.1.

### varshney-2024-decolonial-ai-alignment-visesa-dharma
- status: usable
- medium: text
- cite: Kush R Varshney, "Decolonial AI Alignment: Openness, Viśeṣa-Dharma, and Including Excluded Knowledges," *Proceedings of the Seventh AAAI/ACM Conference on AI, Ethics, and Society (AIES 2024)*, AAAI Press, 2024
- kb: `Varshney_Decolonial-AI-Alignment-Openness-Visesa-Dharma_AIES-2024.md`
- verified: file (title, IBM Research affiliation and "Copyright © 2024, Association for the Advancement of Artificial Intelligence" at segs 0–1)
- note: Sādhāraṇa- vs viśeṣa-dharma deployed as a non-absolutist alternative to universal LLM harm taxonomies; the bridge from 1.3's boundary problem to 8.4.

### viding-mccrory-2012-genetic-and-neurocognitive-contributions-to-psychopathy
- status: usable
- medium: text-ocr
- cite: Essi Viding & Eamon J McCrory, "Genetic and neurocognitive contributions to the development of psychopathy," *Development and Psychopathology* 24:3 (2012), 969–983, DOI 10.1017/S095457941200048X
- kb: `Viding-McCrory_Genetic-and-Neurocognitive-Contributions-to-Psychopathy_DevPsychopathol-2012.md`
- verified: file (tesseract OCR; title and authors at seg 0; heritability passage at segs 4–5; volume/pages/DOI from the published record, not web-checked)
- note: CU-trait heritability 40–78% across twin studies; nonshared environment dominant; developmental-psychopathology framing (equifinality/multifinality).

### viding-mccrory-2018-understanding-the-development-of-psychopathy
- status: usable
- medium: text
- cite: Essi Viding & Eamon McCrory, "Understanding the development of psychopathy: progress and challenges," *Psychological Medicine* 48:4 (2018), 566–577, DOI 10.1017/S0033291717002847
- kb: `Viding-McCrory_Understanding-the-Development-of-Psychopathy_PsychMed-2018.md`
- verified: file (accepted-manuscript header with authors and affiliation at seg 0; volume/pages/DOI from the published record, not web-checked)
- note: "Children cannot present with psychopathy"; CU traits as risk marker; protective environments counter heritable risk.

### waismann-1945-verifiability
- status: usable
- medium: text-ocr
- cite: Friedrich Waismann, "Verifiability," *Proceedings of the Aristotelian Society*, Supp. Vol. 19 (1945): 119–150
- kb: `Waismann_Verifiability_PAS-Supp-1945.md` (full text, folded into the corpus 2026-08); `friedrich-waismann_verifiability_1945.md` (attributed summary, in corpus under staging.text/DD/sources/oldsources/)
- verified: web (JSTOR 4106433; symposium with MacKinnon and Kneale)
- note: attributed summary note with verified page anchors. Replaces the Wikipedia citation in note 1.3 (S15). Open texture ('Porosität der Begriffe', Kneale's translation, p. 121 n.): the impossibility of forestalling unforeseen cases, distinct from remediable vagueness. ▲ Waismann confines it to empirical description — the legal extension is Hart's, the dharma extension is DD's own; 1.3's borderline cases are closer to vagueness than open texture. Full text in DD local archive (scratch/sources/part1/, gitignored).

### wakhidah-2024-legal-culture-of-samin-family-law
- status: usable
- medium: text
- cite: Nur Wakhidah et al, "The Legal Culture of Samin Community of Family Law in Central Java," *Al-Ihkam: Jurnal Hukum dan Pranata Sosial* 19:1 (2024): 126–150, DOI 10.19105/al-lhkam.v19i1.10341
- kb: `The-Legal-Culture-of-Samin-Community-of-Family-Law-in-Central-Java_Al-Ihkam.md`
- verified: file (journal header with volume, pages and DOI at seg 0; co-authors not recoverable beyond the corresponding author)
- note: Customary marriage rite and the lifetime-monogamy pledge; "politically, the state does not recognize the existence of the Samin law" (seg 11).

### waldron-2002-rule-of-law-essentially-contested
- status: usable
- medium: text
- cite: Jeremy Waldron, "Is the Rule of Law an Essentially Contested Concept (in Florida)?," *Law and Philosophy* 21:2 (2002), 137–164
- kb: `Waldron_Is-the-Rule-of-Law-an-Essentially-Contested-Concept_2002.md`
- verified: file (preprint header "forthcoming in special issue of Law and Philosophy" at seg 0; journal volume/pages not checked against the published version)
- note: Applies Gallie to the rule of law via the 2000 Florida recount; normativity + complexity as the key to essential contestability; the "upbeat" reading of contestation.

### walum-waldman-young-2016-intranasal-oxytocin-statistical-considerations
- status: usable
- medium: text
- cite: Hasse Walum, Irwin D Waldman & Larry J Young, "Statistical and Methodological Considerations for the Interpretation of Intranasal Oxytocin Studies," *Biological Psychiatry* 79:3 (2016), 251–257, DOI 10.1016/j.biopsych.2015.06.016
- kb: `Walum-Waldman-Young_Statistical-and-Methodological-Considerations-Intranasal-Oxytocin_BiolPsychiatry-2016.md`
- verified: file (abstract at seg 0; d = 0.28 and median n = 49 at seg 3; pagination from the published record, not web-checked)
- note: Power analysis of the intranasal-oxytocin field: underpowered, low positive predictive value, characteristically non-replicating.

### walzer-1985-exodus-and-revolution
- status: usable
- medium: text-ocr
- cite: Michael Walzer, *Exodus and Revolution* (New York: Basic Books, 1985)
- kb: `Walzer_Exodus-and-Revolution_1986.md`
- verified: file (tesseract OCR; Basic Books title page at seg 0; the Sinai covenant chapter "The Covenant: A Free People" at segs 66–72; filename year 1986 is the paperback, first edition 1985)
- note: The covenant read as informed popular consent and "radical voluntarism" — the feature that most separates Abrahamic grounding from cosmic order. Running heads are interleaved into the text by the OCR.

### weber-1946-from-max-weber
- status: usable
- medium: text-ocr
- cite: Max Weber, *From Max Weber: Essays in Sociology*, trans. and ed. HH Gerth & C Wright Mills (New York: Oxford University Press, 1946)
- kb: `Weber_From-Max-Weber-Essays-in-Sociology_1946.md`
- verified: file (tesseract OCR provenance at seg 0; "Bureaucracy" §10 "The Permanent Character of the Bureaucratic Machine" at seg 261)
- note: Gerth–Mills selection incl. "Politics as a Vocation," "Bureaucracy," "The Social Psychology of the World Religions."

### weber-1978-economy-and-society
- status: usable
- medium: text-ocr
- cite: Max Weber, *Economy and Society: An Outline of Interpretive Sociology*, ed. Guenther Roth & Claus Wittich, trans. Ephraim Fischoff et al. (Berkeley: University of California Press, 1978; German orig. 1921–22)
- kb: `Weber_Economy-and-Society_Roth-Wittich-ed.md`
- verified: file (Roth–Wittich edition confirmed from the kb file's front matter and running heads "BASIC SOCIOLOGICAL TERMS [Ch. I"; §§4–6 custom/convention/law/ethics located at segs 185–194, Part Two ch. I at seg 589; visible OCR noise, e.g. "caned" for "called")
- note: Part One ch. 1 typology of usage, custom, convention and law by kind of guarantee, plus the "ethical" order valid without external guarantee — the contrastive apparatus for the custom/etiquette/law boundary.

### welwood-1984-principles-of-inner-work
- status: usable
- medium: text-ocr
- cite: John Welwood, "Principles of Inner Work: Psychological and Spiritual," *The Journal of Transpersonal Psychology* 16:1 (1984), 63–73
- kb: `Welwood_Principles-of-Inner-Work-Psychological-and-Spiritual_JTP-1984.md`
- verified: file (running head "Principles of Inner Work 65" at seg 3; OCR noise, e.g. "i-re suit")
- note: Origin of "spiritual bypassing" — using practice to bypass personal "unfinished business".

### weng-et-al-2013-compassion-training-alters-altruism
- status: usable
- medium: text
- cite: Helen Y Weng, Andrew S Fox, Alexander J Shackman, Diane E Stodola, Jessica ZK Caldwell, Matthew C Olson, Gregory M Rogers & Richard J Davidson, "Compassion training alters altruism and neural responses to suffering," *Psychological Science* 24:7 (2013), 1171–1180
- kb: `Weng-Davidson-et-al_Compassion-Training-Alters-Altruism-and-Neural-Responses_PsychSci-2013.md`
- verified: file (abstract at seg 0; NIH author-manuscript watermark at seg 1; author list and pagination from the published record, not web-checked)
- note: Short-term compassion training increases altruistic redistribution to a victim outside the training context; the behavioural link for the compassion-circuitry claim.

### whitehouse-et-al-2017-extreme-cooperation-shared-dysphoric-experiences
- status: usable
- medium: text
- cite: Harvey Whitehouse, Jonathan Jong, Michael D Buhrmester, Ángel Gómez, Brock Bastian, Christopher M Kavanagh, Martha Newson, Miriam Matthews, Jonathan A Lanman, Ryan McKay & Sergey Gavrilets, "The evolution of extreme cooperation via shared dysphoric experiences," *Scientific Reports* 7 (2017), 44292, DOI 10.1038/srep44292
- kb: `Whitehouse-et-al_The-Evolution-of-Extreme-Cooperation-via-Shared-Dysphoric-Experiences_SciRep-2017.md`
- verified: file (journal masthead with DOI, authors and abstract at seg 0)
- note: Model plus empirical tests (veterans, fraternities, football fans, martial artists, twins): shared painful experience → identity fusion → willingness to fight and die for the group.

### whitehouse-et-al-2021-retraction-note-complex-societies-moralizing-gods
- status: usable
- medium: text
- cite: Harvey Whitehouse, Pieter François, Patrick E Savage, Thomas E Currie, Kevin C Feeney, Enrico Cioni, Rosalind Purcell, Robert M Ross, Jennifer Larson, John Baines, Barend ter Haar, Alan Covey & Peter Turchin, "Retraction Note: Complex societies precede moralizing gods throughout world history," *Nature* 595 (8 July 2021), 320, DOI 10.1038/s41586-021-03656-3
- kb: `Whitehouse-et-al_Retraction-Note-Complex-Societies-Precede-Moralizing-Gods_Nature-2021.md`
- verified: file (journal, volume, page, DOI and date at seg 0)
- note: The retraction itself, with the authors' admission on the 'absent'/'unknown' coding; the project rule that the 2019 Letter is not cited in either direction rests on it.

### whitehouse-lanman-2014-the-ties-that-bind-us
- status: usable
- medium: text
- cite: Harvey Whitehouse & Jonathan A Lanman, "The Ties That Bind Us: Ritual, Fusion, and Identification," *Current Anthropology* 55:6 (2014), 674–695, DOI 10.1086/678698
- kb: `Whitehouse-Lanman_The-Ties-That-Bind-Us-Ritual-Fusion-Identification_CurrAnthro-2014.md`
- verified: file (title/authors at seg 0; running head "Current Anthropology Volume 55, Number 6, December 2014" at seg 24)
- note: Modes-of-religiosity theory in its field form — routinisation as the hallmark of the doctrinal mode, imagistic fusion via dysphoric ritual; rebel-group mortality datum.

### whyte-2017-indigenous-climate-change-studies
- status: usable
- medium: text
- cite: Kyle Whyte, "Indigenous Climate Change Studies: Indigenizing Futures, Decolonizing the Anthropocene," *English Language Notes* 55:1–2 (2017), 153–162
- kb: `Whyte_Indigenous-Climate-Change-Studies_2017.md`
- verified: file (journal header "English Language Notes 55.1-2 Fall 2017" at seg 1; page numbers 155 ff. in-text)
- note: Potawatomi philosopher; indigenous peoples "already living today in post-apocalyptic situation"; the Anthropocene as rooted in colonisation; anthropogenic change as diverse. Indigenous-authored.

### wikipedia-walden
- status: usable
- medium: text
- cite: "Walden," Wikipedia (accessed 2026-07-27); scholarly context Laura Dassow Walls, *Henry David Thoreau: A Life* (University of Chicago Press, 2017), ISBN 978-0-226-34469-0
- kb: — (external; no KB file)
- verified: web (article fetched 2026-07-27: Emerson's ownership, work-exchange arrangement, 4 July 1845 – 6 September 1847, several-times-weekly Concord trips, in-kind support; Walls 2017 confirmed via University of Chicago Press catalogue)
- note: the documented facts behind the Lowell critique, used in 6.3 to keep the Thoreau strand honest. Walls is the standing scholarly biography if a deeper treatment is later needed; her text was not itself consulted.

### witness-2023-in-the-name-of-mother-earth-kendeng-women
- status: usable
- medium: text
- cite: WITNESS, "In the Name of Mother Earth: The Kendeng Women" (profile of Sukinah, witness.org, 22 June 2023)
- kb: `WITNESS_In-the-Name-of-Mother-Earth-Kendeng-Women_2023.md`
- verified: file (profile header and date in seg 0; 5 segments)
- note: Advocacy-organisation profile of Sukinah and the Kartini Kendeng feet-in-cement protests; places her inside JM-PPK. Advocacy source — use for the activists' self-account, not for contested facts.

### woodhead-2016-intensified-religious-pluralism
- status: usable
- medium: text
- cite: Linda Woodhead, "Intensified Religious Pluralism and De-differentiation: the British Example," *Society* 53:1 (2016), 41–46 (open access)
- kb: `Woodhead_Intensified-Religious-Pluralism-and-De-differentiation_Society-2016.md`
- verified: file (symposium header and abstract at seg 0; secularists figure at seg 5; volume/pages from the published record, not web-checked)
- note: A third pluralism beyond Berger's two — the breakdown of the religious/secular boundary; secularists only 13% of nones and not growing.

### woodhead-2016-rise-of-no-religion-in-britain
- status: usable
- medium: text-ocr
- cite: Linda Woodhead, "The rise of 'no religion' in Britain: The emergence of a new cultural majority," *Journal of the British Academy* 4 (2016), 245–261 (British Academy Lecture, 19 January 2016)
- kb: `Woodhead_The-Rise-of-No-Religion-in-Britain_JBA-2016.md`
- verified: file (tesseract OCR, 18 pages; lecture title and abstract at seg 0; running page numbers 246–248 at segs 1–4)
- note: "No religion" passing half of GB adults by 2015; the age gradient; "most are not straightforwardly secular."

### xygalatas-2023-culture-cognition-and-ritual
- status: usable
- medium: text
- cite: Dimitris Xygalatas, "Culture, Cognition, and Ritual," chapter preprint for *Advances in Culture and Psychology* (2023)
- kb: `Xygalatas_Culture-Cognition-and-Ritual_2023_chapter-preprint.md`
- verified: file (title, affiliation and abstract at seg 0; Mauritius Thaipusam experiment at segs 22–23)
- note: Review chapter with the author's field experiments (Mauritius prayer vs kavadi donations; Power's Tamil Nadu signalling studies). Preprint — page numbers unavailable.

### zakharin-bates-2021-remapping-the-foundations-of-morality
- status: usable
- medium: text
- cite: Michael Zakharin & Timothy C Bates, "Remapping the foundations of morality: Well-fitting structural model of the Moral Foundations Questionnaire," *PLoS ONE* 16:10 (2021), e0258910
- kb: `Zakharin-Bates_Remapping-the-Foundations-of-Morality_PLoSONE-2021.md`
- verified: file (title, authors and abstract at seg 0; article number from the published record)
- note: Five studies, N = 11,496; no theorised MFQ model fits; seven-factor solution with the binding foundations re-cut. Note 5.3 previously named the first author "Kirill" — the file gives Michael.

### zarkasi-et-al-2021-social-resistance-strategy-samin
- status: usable
- medium: text
- cite: Ibnu Fath Zarkasi, Desiderius Soedibyo, Rina Herlina Haryanti & Ramaditya Rahardian, "Social Resistance Strategy of Indigenous Samin Community," *Politika: Jurnal Ilmu Politik* 12:2 (2021): 194–207, DOI 10.14710/politika.12.1.2021.194-207
- kb: `Zarkasi-et-al_Social-Resistance-Strategy-of-Indigenous-Samin-Community_Politika-2021.md`
- verified: file (masthead with DOI and authors at seg 0)
- note: JMPPK as the coalition vehicle; allies LBH Semarang/Jakarta, WALHI, KRuHA, Desantara, KONTRAS.

### zenquotes-2619-aristotle-habit
- status: barred
- barred: ephemera
- medium: text
- kb: `2619.txt`
- verified: unverified
- note: bare quote-farm file (workshops/zenquotes/quotes/) containing only "We are what we repeatedly do…" attributed flatly to Aristotle — no context, no source, and it propagates the misattribution that entry aristotle-durant-we-are-what-we-repeatedly-do exists to correct (the wording is Will Durant's 1926 paraphrase). Barred as ephemera by author decision 2026-07-19; use the Durant entry instead.

### bailey-inventing-world-3-0-evolutionary-ethics-ai
- status: usable
- medium: transcript
- cite: Matthew James Bailey, "Inventing World 3.0: Evolutionary Ethics for Artificial Intelligence" (London Futurists talk, chaired by David Wood, YouTube, ZbiQns2n0qI)
- kb: `ZbiQns2n0qI.transcript.txt`
- verified: video-URL (https://www.youtube.com/watch?v=ZbiQns2n0qI)
- note: File located at appliedanthropology/workshops/transcripts/ (not indexed in the shared DB at query time); content peeked directly to identify speaker/host/title. Cited by DD note 8.2.

### barrett-2017-how-emotions-are-made
- status: usable
- medium: text
- cite: Lisa Feldman Barrett, *How Emotions Are Made: The Secret Life of the Brain* (Houghton Mifflin Harcourt, 2017)
- kb: `Lisa-Feldman-Barrett_How-Emotions-Are-Made_the-secret-life-of-the-brain.md`
- verified: web (ISBN 9780544133310)

### batchelor-2015-after-buddhism
- status: usable
- medium: text
- cite: Stephen Batchelor, *After Buddhism: Rethinking the Dharma for a Secular Age* (Yale University Press, 2015)
- kb: `After-Buddhism.md`
- verified: web (ISBN 978-0-300-20518-3)

### batchelor-2017-secular-buddhism
- status: usable
- medium: text
- cite: Stephen Batchelor, Secular Buddhism: Imagining Dharma in an Uncertain World (Yale University Press, 2017)
- kb: `secular-buddhism.md`
- verified: web (Google Books entry, confirmed via DB content peek: 'Stephen Batchelor, Yale University Press, 1 Jan 2017')
- note: Item is a Google Books metadata/blurb page archived under staging.text/websearch_data/, not a bare-domain ephemera page - it documents a real, citable book. Cited by DD notes 0.3, 6.1.

### batchelor-2017-secular-buddhism-imagining-the-dharma
- status: usable
- medium: text
- cite: Stephen Batchelor, *Secular Buddhism: Imagining the Dharma in an Uncertain World* (Yale University Press, 2017)
- kb: `Secular_Buddhism.md`
- verified: web (ISBN 978-0-300-23425-1)

### batchelor-2020-art-of-solitude
- status: usable
- medium: text
- cite: Stephen Batchelor, The Art of Solitude (Yale University Press, 2020)
- kb: `Art_of_Solitude.md`
- verified: web (ISBN 9780300248940)
- note: DB text opens with the book's Preamble under Batchelor's byline

### batchelor-2023-mbel-interview
- status: usable
- medium: text
- cite: Stephen Batchelor, interviewed by Mike Slott (Secular Buddhist Network) with Ayda Duroux, Saskia Graf & Jochen Weber (Buddha-Stiftung), "An Interview with Stephen Batchelor on Mindfulness Based Ethical Living (MBEL)" (Secular Buddhist Network, 22 Feb 2023)
- kb: `Interview_with_Stephen_Batchelor_on_Mindfulness_Based_Ethical_Living_MBEL.txt`, `NiqN03KBSME.transcript.txt`
- verified: web (secularbuddhistnetwork.org)
- note: prov=Bodhi (general Buddhism-topic dir, not necessarily Bhikkhu Bodhi). `NiqN03KBSME.transcript.txt` is the video transcript of the same interview (YouTube id NiqN03KBSME; same participants and content) — one work, two corpus forms. Cited by DD note 6.1.

### batchelor-a-secular-buddhism-lecture
- status: usable
- medium: transcript
- cite: Stephen Batchelor, "A Secular Buddhism" (lecture, YouTube, video ID Hhlj_SU9SAE)
- kb: `Hhlj_SU9SAE.transcript.txt`
- verified: video-URL (https://www.youtube.com/watch?v=Hhlj_SU9SAE)
- note: cited in 7.5 [S6] for the "Protestant perspective" and the anti-colonial Burmese origins of the Vipassana movement.

### batchelor-buddhism-and-the-art-of-imagining
- status: usable
- medium: transcript
- cite: Stephen Batchelor, "Buddhism and The Art of Imagining" (talk, YouTube, video ID hdBU5TAcPYs)
- kb: `hdBU5TAcPYs.transcript.txt`
- verified: video-URL (https://www.youtube.com/watch?v=hdBU5TAcPYs)
- note: cited in 7.5 [S4] corroborating "Buddhism" as a nineteenth-century European coinage.

### batchelor-batchelor-2019-what-is-this
- status: usable
- medium: text
- cite: Martine Batchelor and Stephen Batchelor, What is This? Ancient Questions for Modern Minds (Tuwhiri Project, 2019)
- kb: `Martine+Stephen-Batchelor_What-is-this.md`
- verified: web (ISBN 9780473474973)

### batchelor-song-2024-what-if-buddhists-ran-the-world
- status: usable
- medium: text
- cite: Stephen Batchelor and Bing Song, "What if Buddhists Ran the World?" (Berggruen Institute Futurology series, recorded Venice, Nov 2024)
- kb: `Stephen-Bachelor_What-if-Buddhists-Ran-the-World.md`
- verified: video-URL (https://www.youtube.com/watch?v=izowdNr6tJY; Berggruen Institute Futurology, recorded Venice, Nov 2024)
- note: Source filename misspells "Batchelor" as "Bachelor."

### batchelor-song-2024-what-if-buddhists-ran-the-world-2
- status: usable
- medium: text
- cite: Stephen Batchelor and Bing Song, "What if Buddhists Ran the World?" Futurology podcast (Berggruen Institute, 2024)
- kb: `What-if-Buddhists-Ran-the-World.md`
- verified: video-URL (https://www.youtube.com/watch?v=izowdNr6tJY; Berggruen Institute Futurology, recorded Venice, Nov 2024)

### batistoni-barclay-raihani-2022-third-party-punishers
- status: usable
- medium: text
- cite: Tommaso Batistoni, Pat Barclay & Nichola J. Raihani, "Third-party punishers do not compete to be chosen as partners in an experimental game", *Proceedings of the Royal Society B* 289 (2022), PMCID PMC8753170
- kb: `PMC8753170-third-party-punishers-do-not-compete-to-be-chosen-as-partner.md`
- verified: web (PMC8753170; authors confirmed via Europe PMC authorString "Batistoni T, Barclay P, Raihani NJ")
- note: experimental test of punishment-as-costly-signal; no partner-choice escalation; punishment "a more ambiguous signal of cooperative intent compared to help". ▲ Partly falsifies 5.5's peacock's-tail claim. Cited by DD notes 2.3, 5.5.

### baum-richerson-2025-lab-cultural-evolution-punishing
- status: usable
- medium: text
- cite: William M. Baum & Peter J. Richerson, "Cultural evolution in the laboratory: evolution of cooperative altruistic punishing", *Evolutionary Human Sciences* 7 (2025), PMCID PMC12645323
- kb: `PMC12645323-cultural-evolution-in-the-laboratory-evolution-of-cooperativ.md`
- verified: web (PMC12645323; authors confirmed via Europe PMC authorString "Baum WM, Richerson PJ")
- note: multi-generation public-goods experiments; cooperative altruistic punishing evolves only when punishment is cheap; "canny defectors achieved the highest payoffs, always by a small margin". Live-human anchor for the "exploiter held down, never eliminated" claim, replacing a Behave gloss. Cited by DD note 5.5.

### ben-oren-2023-specialization-double-edged
- status: usable
- medium: text
- cite: Yotam Ben-Oren, Oren Kolodny & Nicole Creanza, "Cultural specialization as a double-edged sword: division into specialized guilds might promote cultural complexity at the cost of higher susceptibility to cultural loss", *Philosophical Transactions of the Royal Society B* (2023), PMCID PMC9869445
- kb: `PMC9869445-cultural-specialization-as-a-double-edged-sword-division-int.md`
- verified: web (PMC9869445; authors confirmed via Europe PMC authorString "Ben-Oren Y, Kolodny O, Creanza N")
- note: specialist custodianship raises attainable cultural complexity but concentrates knowledge, amplifying loss under demographic/environmental shock — the transmission-theoretic form of note 2.4's institutionalisation paradox, independent of Batchelor. Cited by DD note 2.4.

### berkman-1929-what-is-communist-anarchism
- status: usable
- medium: text
- cite: Alexander Berkman, *What Is Communist Anarchism?* (Vanguard Press, 1929; also published as *Now and After: The ABC of Communist Anarchism*)
- kb: `alexander-berkman_what-is-communist-anarchism.md`
- verified: web (repr. https://theanarchistlibrary.org/library/alexander-berkman-what-is-communist-anarchism)
- note: cited in 7.7 [S2]; corpus also holds the .epub under workshops/anarchy/epubs/.

### berl-2021-prestige-content-biases
- status: usable
- medium: text
- cite: Richard E.W. Berl, Alarna N. Samarasinghe, Seán G. Roberts, Fiona M. Jordan & Michael C. Gavin, "Prestige and content biases together shape the cultural transmission of narratives", *Evolutionary Human Sciences* (2021), PMCID PMC10427335
- kb: `PMC10427335-prestige-and-content-biases-together-shape-the-cultural-tran.md`
- verified: web (PMC10427335; authors confirmed via Europe PMC authorString "Berl REW, Samarasinghe AN, Roberts SG, Jordan FM, Gavin MC")
- note: transmission-chain experiment; prestige bias real but the *smallest* measured effect (+15% recall); content biases (social, survival, negative-emotional, counterintuitive) dominate. ▲ Qualifies rather than supports the standard prestige-led account. Cited by DD notes 2.4, 5.2.

### bettera-2024-secondo-natura
- status: usable
- medium: text
- cite: Stefano Davide Bettera, Secondo natura: Critica dell'ideologia liberal progressista (Solferino, 2024)
- kb: `Secondo_Natura`, `Secondo_Natura.it.md`
- verified: web (ISBN 9788828215592)
- note: truncated filename; corpus holds 4 variant files (it, gpt-4o-latest.en, chatgpt-4o-latest.en, gpt-4o-mini.en) -- machine-translated/summarised renderings of this Italian book; verify which variant was actually cited against the original

### bettera-2024-secondo-natura-2
- status: usable
- medium: text
- cite: Stefano Davide Bettera, *Secondo natura: Critica dell'ideologia liberal progressista* (Solferino, 2024)
- kb: `Secondo_Natura.*.md`
- verified: web (ISBN 9788828215592)
- note: NEEDS-HUMAN: input filename is literally "Secondo_Natura.\*.md" (unexpanded glob, not a real file). DB has four variants under staging.text/Stefano_Bettera/ (chatgpt-4o-latest.en, gpt-4o-latest.en, gpt-4o-mini.en, it) -- confirm which specific file/language was actually cited; the .en variants are LLM translations/summaries of the Italian original. Cited by DD note 7.1.

### bhagavad-gita-oevortex
- status: usable
- medium: text
- cite: *Bhagavad Gītā*, chs. 1–18, anonymous English rendering — corpus copy extracted (700 verses → 18 chapter files) from the HuggingFace dataset `OEvortex/Bhagavad_Gita` (MIT licence); underlying scripture public domain. Cite **by chapter.verse**, never by page.
- kb: `bhagavad-gita-ch01.md`, `bhagavad-gita-ch02.md`, `bhagavad-gita-ch03.md`, `bhagavad-gita-ch04.md`, `bhagavad-gita-ch05.md`, `bhagavad-gita-ch06.md`, `bhagavad-gita-ch07.md`, `bhagavad-gita-ch08.md`, `bhagavad-gita-ch09.md`, `bhagavad-gita-ch10.md`, `bhagavad-gita-ch11.md`, `bhagavad-gita-ch12.md`, `bhagavad-gita-ch13.md`, `bhagavad-gita-ch14.md`, `bhagavad-gita-ch15.md`, `bhagavad-gita-ch16.md`, `bhagavad-gita-ch17.md`, `bhagavad-gita-ch18.md`
- verified: unverified
- note: ▲ TRANSLATOR/EDITION UNRESOLVED. Chapter-file headers state only "Source: OEvortex/Bhagavad_Gita (MIT). English translation." — no translator, publisher, year or base edition (confirmed in `$VECTORDBS/appliedanthropology/workshops/hf/bhagavad-gita/README.md`). The English is a loose, expansive paraphrase with typos and interpolated glosses; it renders the key term inconsistently (3.35 "one's own duty (Dharma)"; 18.47 "one's own tasks") and at 18.66 renders *sarva-dharmān parityajya* ("abandoning all dharmas") as "Detach yourself from all worldly things" — the word *dharma* vanishes; 3.35 also carries an uncorrected typo ("filles with menace"). **Usable only for citing the STRUCTURE of the text's argument, by chapter.verse; NOT usable for word-level or philological claims, and no wording may be quoted as authoritative, until cross-checked against a named scholarly edition (van Buitenen, Zaehner, Miller, or public-domain Telang/SBE vol. 8).** Chapter-file frontmatter categories are `myth-religion-culture` / `philosophy-ethics` (not `secular-dharma`), consistent with the dataset README's "traditional, not secular-dharma canon". Enters notes per the non-privileging stance as one tradition's self-theorisation to be tested against the checklist, never as an authority over it. Reconciles three keys three review agents proposed independently (`bhagavad-gita-hf-oevortex`, `bhagavad-gita-primary-text`, `bhagavad-gita-oevortex`). Note 3.1 additionally cites the Gita's *argument* via secondary web commentary (wisdomlib/TIJER) at its own [S6]; that secondary citation stands separately and is not this entry. Cited by DD notes 1.3, 3.1, 3.4, 7.3.

### biglan-2020-big-pharma-death-of-americans
- status: usable
- medium: text
- cite: Anthony Biglan, "Big Pharma and the Death of Americans" (This View of Life / prosocial.world, 26 Mar 2020)
- kb: `big-pharma-and-the-death-of-americans.md`
- verified: web (https://www.prosocial.world/posts/big-pharma-and-the-death-of-americans; 2020-03-26)
- note: Polemical critical-psychiatry framing per project gloss; ADHD/DSM-5 critique is a contested minority position.

### blume-2024-evolutionary-power-of-ritual
- status: usable
- medium: text
- cite: Michael Blume, "The Evolutionary Power Of Ritual" (This View of Life, 8 Jun 2013; repr. prosocial.world)
- kb: `posts_the-evolutionary-power-of-ritual`
- verified: web (https://www.prosocial.world/posts/the-evolutionary-power-of-ritual; originally thisviewoflife.com, 2013-06-08)
- note: resolved via prosocial.world.db frontmatter

### bodhi-college-sim-retreat-day0-introduction
- status: usable
- medium: transcript
- cite: Winton Higgins et al., Secular Insight Meditation (SIM) Retreat -- Day 0 introduction and group discussion (Bodhi College, recording transcript)
- kb: `SIM_retreat.txt`
- verified: unverified
- note: Multi-speaker retreat Q&A transcript (VTT-derived: 'day_0_-\_introduction_to_retreat_583.mp4.vtt'); lead voice self-identifies as 'Wynton' (political-theory/genocide-studies academic turned Buddhist teacher = Winton Higgins), but many participants speak; NEEDS-HUMAN: confirm exact retreat date/attribution if precision is required

### bodhi-mindful-solidarity
- status: usable
- medium: text
- cite: Bhikkhu Bodhi, "Mindful Solidarity" (essay)
- kb: `Mindful-Solidarity.md`
- verified: unverified
- note: prov=Bodhi. Web search confirms Bhikkhu Bodhi's recurring "solidarity/compassion/justice" framing (e.g. MIT 2018 talk "moral vision in an age of crisis") but did not pin down the exact publication venue for an essay titled precisely "Mindful Solidarity". NEEDS-HUMAN: confirm original publication venue.

### bregman-2020-humankind
- status: usable
- medium: text
- cite: Rutger Bregman, *Humankind: A Hopeful History*, trans. Elizabeth Manton & Erica Moore (Bloomsbury, 2020)
- kb: `rutger-bregman_humankind_a-hopeful-history.md`
- verified: web (ISBN 978-1-4088-9893-2)
- note: anchor source of note 8.5 — the 1965–66 'Ata shipwreck ("real Lord of the Flies") and the Robbers Cave / Middle Grove correction (via Gina Perry's archive work). Reviewers have criticised Bregman's use of sources; weigh popular-synthesis claims accordingly. Cited by DD note 8.5.

### bretl-goering-2022-moral-intuitions
- status: usable
- medium: text
- cite: Brandon L. Bretl & Marlon Goering, "Age- and sex-based differences in the moral intuitions of American early adolescents", *Evolutionary Human Sciences* 4 (2022), PMCID PMC10426028
- kb: `PMC10426028-age-and-sex-based-differences-in-the-moral-intuitions-of-ame.md`
- verified: web (PMC10426028; authors confirmed via Europe PMC authorString "Bretl BL, Goering M")
- note: within-population (age/sex) variation in autonomy, loyalty and empathy/animal-harm intuitions among US American early adolescents, with a pubertal-onset hypothesis; also states the is/ought guard explicitly — evolutionary functional fitness "does not necessarily have anything to say about how beneficial these… mechanisms are in the contexts of modern-day societies". Descriptive psychology only — must not license any normative "better/worse" claim. Cited by DD notes 3.4, 5.3.

### bryant-smaldino-2025-distortion-music
- status: usable
- medium: text
- cite: Gregory A. Bryant & Paul E. Smaldino, "The cultural evolution of distortion in music (and other norms of mixed appeal)", *Philosophical Transactions of the Royal Society B* 380(1923):20240014 (2025), PMCID PMC11966159
- kb: `PMC11966159-the-cultural-evolution-of-distortion-in-music-and-other-norm.md`
- verified: web (PMC11966159; authors confirmed via Europe PMC authorString "Bryant GA, Smaldino PE" and UCLA faculty page)
- note: norms of mixed appeal driven by intra-group cohesion and inter-group differentiation; general account of subgroup-differentiating markers. ▲ The corpus file's `authors:` frontmatter field is EMPTY — author attribution comes from Europe PMC, not the corpus. Cited by DD note 2.4.

### byy4khbb-fk-discussion-transcript
- status: barred
- barred: self
- medium: transcript
- kb: `Byy4kHbB-Fk.transcript.txt`
- verified: unverified
- note: author's own first-person / autobiographical prose (personal detail omitted)

### chand-2025-building-mental-immunity
- status: usable
- medium: text
- cite: Nele Strynckx, "Building Mental Immunity" (prosocial.world, 21 Feb 2023)
- kb: `posts_building-mental-immunity.md`
- verified: web (https://www.prosocial.world/posts/building-mental-immunity; 2023-02-21)

### christakis-2019-blueprint
- status: usable
- medium: text
- cite: Nicholas A. Christakis, Blueprint: The Evolutionary Origins of a Good Society (Little, Brown Spark, 2019)
- kb: `nicholas-a-christakis_blueprint_the-evolutionary-origins-of-a-good-society.md`
- verified: web (ISBN 9780316230032)

### combined-dharma-keep-notes
- status: barred
- barred: self
- medium: text
- kb: `combined_dharma_keep_notes.txt`
- verified: unverified
- note: prov=gd_keep_notes.

### cosmopolitanism-expanded
- status: barred
- barred: self
- medium: text
- kb: `cosmopolitanism.expanded`
- verified: unverified
- note: DB lookup resolves the full sourcedoc to staging.text/gd_keep_notes/docs/cosmopolitanism.expanded.txt - matches both the prov=gd_keep_notes barred-self criterion and the filename-ends-.expanded(.txt) criterion; the truncated batch filename just drops the .txt.

### crawford-2021-atlas-of-ai
- status: usable
- medium: text
- cite: Kate Crawford, Atlas of AI: Power, Politics, and the Planetary Costs of Artificial Intelligence (Yale University Press, 2021)
- kb: `Kate-Crawford_The-Atlas-of-AI-Power-Politics-and-the-Planetary-Costs_2021.md`
- verified: web (ISBN 9780300209570)
- note: Title/author/year well established (filename itself is Author_Title_Year); ISBN not independently tool-verified.

### currie-2021-evolution-of-institutions
- status: usable
- medium: text
- cite: Thomas E. Currie, Marco Campenni, Adam Flitton, Tim Njagi, Enoch Ontiri, Cedric Perret & Lindsay Walker, "The cultural evolution and ecology of institutions", *Philosophical Transactions of the Royal Society B* (2021), PMCID PMC8126459
- kb: `PMC8126459-the-cultural-evolution-and-ecology-of-institutions.md`
- verified: web (PMC8126459; authors confirmed via Europe PMC authorString "Currie TE, Campenni M, Flitton A, Njagi T, Ontiri E, Perret C, Walker L")
- note: institutions as "socially created and culturally inherited proscriptions on behaviour that define roles and set expectations about social interactions"; institutions-as-rules vs as-equilibria; institutions may be "designed by a minority for a minority" and enforce socially detrimental behaviour. Cited by DD note 2.4.

### curry-2019-seven-moral-rules
- status: usable
- medium: text
- cite: Oliver Scott Curry, "Seven Moral Rules Found All Around the World," prosocial.world (2019), summarizing Oliver Scott Curry, Daniel Austin Mullins and Harvey Whitehouse, "Is It Good to Cooperate? Testing the Theory of Morality-as-Cooperation in 60 Societies," Current Anthropology 60(1) (2019): 47-69
- kb: `the-seven-moral-rules-found-all-around-the-world`
- verified: web (prosocial.world/posts/the-seven-moral-rules-found-all-around-the-world; underlying study confirmed via ScienceDaily/EurekAlert/Current Anthropology)
- note: Full path resolved via DB (staging.text/prosocial.world/the-seven-moral-rules-found-all-around-the-world.md).

### curry-mullins-whitehouse-2019-seven-moral-rules
- status: usable
- medium: text
- cite: Oliver Scott Curry, Daniel Austin Mullins and Harvey Whitehouse, "Is It Good to Cooperate? Testing the Theory of Morality-as-Cooperation in 60 Societies," Current Anthropology 60(1) (2019); popularized as "Seven Moral Rules Found All Around the World" (University of Oxford press release, 2019; repr. prosocial.world)
- kb: `posts_the-seven-moral-rules-found-all-around-the-world.md`, `Curry-Mullins-Whitehouse_Is-It-Good-to-Cooperate_CurrentAnthropology-2019_with-commentaries.md`, `Curry-Mullins-Whitehouse_2019_SUPPLEMENT-coding-tables.md` (2019 paper: published abstract plus attributed summary, and the supplementary coding tables)
- verified: web (https://doi.org/10.1086/701478)
- note: Attributed summary with verified page anchors staged as `curry-mullins-whitehouse_is-it-good-to-cooperate_2019.md` (workshops/DD/sources/), covering the full typeset article INCLUDING the four published Comments (Bloom; Gintis; Smith & Kurzban, 'Morality Is Not Always Good'; Wong) and the authors' Reply — the Oxford ORA deposit of the published version, plus supplement, in the DD local archive. Key figures: 961/962 coded valence observations positive (p. 54); fairness observed in 9/60 societies; coverage confound r = 0.43 (p. 55); fairness κ = 0.14. ▲ 'None was found' is the honest gloss, not 'there are none'; the codebook's rule five has no 'legitimate' qualifier. Prefer this entry over curry-2019-seven-moral-rules (blog gloss) for any [S#] carrying weight. Cited by DD note 1.2.

### dalai-lama-simple-religion-quote
- status: usable
- medium: text
- cite: Dalai Lama XIV, "This is my simple religion. There is no need for temples; no need for complicated philosophy. Our own brain, our own heart is our temple; the philosophy is kindness." (widely attributed; The Dalai Lama: A Policy of Kindness: An Anthology of Writings By and About the Dalai Lama, ed. Sidney Piburn, Snow Lion Publications, 1990, p. 52)
- kb: `simple-religion-need-temples-need-complicated-philosophy-brain-heart-ou_gpt-4o-mini.md`
- verified: web (ISBN 9781559390224; A Policy of Kindness, ed. Piburn, 1990, p. 52 per multiple quote-reference sites)
- note: truncated filename resolved via DB LIKE match to zenquotes/discourse.md/simple-religion-need-temples-need-complicated-philosophy-brain-heart-ou_gpt-4o-mini.mdgpt-4o-mini.md; KB text is an LLM (gpt-4o-mini) discourse elaborating this Dalai Lama quote -- verify against original. Cited by DD note 8.3.

### daring-to-define-by-whose-right
- status: barred
- barred: self
- medium: text
- kb: `daring-to-define-by-whose-right.txt`
- verified: unverified
- note: prov=faqs, listed barred:self dir

### dd-staging-self-notes
- status: barred
- barred: self
- medium: text
- kb: any `staging.text/DD/` path
- verified: unverified
- note: the project's own notes embedded in the corpus — never citable.

### de-waal-responds-to-new-atheist-critics
- status: usable
- medium: text
- cite: Frans de Waal, "Primatologist Frans de Waal Responds to His New Atheist Critics," prosocial.world
- kb: `posts_primatologist-frans-de-waal-responds-to-his-new-atheist-critics.md`
- verified: web (prosocial.world/posts/primatologist-frans-de-waal-responds-to-his-new-atheist-critics)
- note: de Waal responding to critics of a Salon.com excerpt of his own work.

### define-dharma-in-its-broadest-sense
- status: barred
- barred: self
- medium: text
- kb: `define-dharma-in-its-broadest-sense.txt`
- verified: unverified
- note: prov=faqs; AI-authored corpus essay per gloss's own annotation.

### defining-dharma-gpt41
- status: barred
- barred: self
- medium: text
- kb: `defining-dharma_gpt41.md`
- verified: unverified
- note: prov=definition, an LLM-generated corpus definition note; no [S#]-citable external content.

### definition-md
- status: barred
- barred: self
- medium: text
- kb: `Definition.md`
- verified: unverified
- note: prov=definition; project's own "Definition: defining definition" companion essay

### dharma-is-the-pre-sage-of-philosophy
- status: barred
- barred: self
- medium: text
- kb: `Dharma-is-the-Pre-Sage-of-Philosophy_o3.md`
- verified: unverified
- note: DB lookup found the file at staging.text/definition/Dharma-is-the-Pre-Sage-of-Philosophy_o3.md -- prov=definition, an explicit barred:self bucket. AI-authored (o3) corpus essay, no S# apparatus.

### dharmic-tribalism-expanded
- status: barred
- barred: self
- medium: text
- kb: `dharmic-tribalism.expanded.txt`
- verified: unverified
- note: prov=gd_keep_notes and filename ends .expanded.txt -- double match on barred:self criteria

### dores-cruz-2021-gossip-everyday-life
- status: usable
- medium: text
- cite: Terence D. Dores Cruz, Isabel Thielmann, Simon Columbus, Catherine Molho, Junhui Wu, Francesca Righetti, Reinout E. de Vries, Antonis Koutsoumpis, Paul A. M. van Lange, Bianca Beersma & Daniel Balliet, "Gossip and reputation in everyday life", *Philosophical Transactions of the Royal Society B* 376 (2021), PMCID PMC8487731
- kb: `PMC8487731-gossip-and-reputation-in-everyday-life.md`
- verified: web (PMC8487731; authors confirmed via Europe PMC authorString)
- note: ten-day experience-sampling study (N = 309; 5,284 gossip events) showing everyday gossip concerns targets' cooperativeness and drives reputation updating, partner selection and indirect reciprocity. Field evidence replacing Brown-via-Wikipedia for the gossip universal. Cited by DD notes 1.2, 2.3.

### einzelganger-2021-wu-wei-cook-ding
- status: usable
- medium: transcript
- cite: Einzelgänger, "Wu-wei | The Art of Letting Things Happen" (YouTube, 30 September 2021)
- kb: `Einzelganger.txt`
- verified: video-URL (https://www.youtube.com/watch?v=g0rhN8U14dk)
- note: sourcedoc is a 958-segment concatenation of many Einzelgänger video scripts; specific video inferred by matching gloss content (Cook Ding/wu wei) via in-DB search

### einzelganger-law-of-reverse-effect
- status: usable
- medium: transcript
- cite: Einzelgänger, "Once You Stop Caring, Results Come | The Law of Reverse Effect" (YouTube)
- kb: `VpcQVjSVqOM.transcript.txt`
- verified: video-URL (https://www.youtube.com/watch?v=VpcQVjSVqOM)
- note: Confirmed via oEmbed (author_name: Einzelgänger). Matches gloss (wu wei / "the zone" / striving-less theme).

### einzelganger-law-of-reversed-effort
- status: usable
- medium: transcript
- cite: Einzelganger, "The Harder You Try, The Worse It Gets | Law of Reversed Effort" (YouTube, video ID -IlG32Pb43g)
- kb: `-IlG32Pb43g.transcript.txt`
- verified: video-URL (https://www.youtube.com/watch?v=-IlG32Pb43g)
- note: Discusses Frankl's paradoxical intention / hyper-intention (stutterer example); philosophy-essay channel, not an academic source.

### ene-wong-salali-2022-is-it-good-to-be-bad
- status: usable
- medium: text
- cite: Ioana Ene, Keri Ka-Yee Wong & Gul Deniz Salali, "Is it good to be bad? An evolutionary analysis of the adaptive potential of psychopathic traits", *Evolutionary Human Sciences* 4 (2022), PMCID PMC10426111
- kb: `PMC10426111-is-it-good-to-be-bad-an-evolutionary-analysis-of-the-adaptiv.md`
- verified: web (PMC10426111; authors confirmed via Europe PMC authorString "Ene I, Wong KK, Salali GD"; ▲ year is 2022 per doc header and Europe PMC, corrected from an earlier note reference to 2023)
- note: review of frequency-dependent and life-history models of psychopathy; dimensional not categorical; adaptiveness mediated by cultural norms (whether people "tolerate, ostracise or are easily deceived by psychopaths"). Now corpus-internal (was an external PMC link in note 5.5). Cited by DD note 5.5.

### espin-branas-garza-2022-group-functional-punishment
- status: usable
- medium: text
- cite: Antonio M. Espín, Pablo Brañas-Garza, Juan F. Gamella, Benedikt Herrmann & Jesús Martín, "Culture and group-functional punishment behaviour", *Evolutionary Human Sciences* 4 (2022), PMCID PMC10426100
- kb: `PMC10426100-culture-and-group-functional-punishment-behaviour.md`
- verified: web (PMC10426100; authors confirmed via Europe PMC authorString "Espín AM, Brañas-Garza P, Gamella JF, Herrmann B, Martín J")
- note: altruistic punishers "condemned to a lower evolutionary success within their group"; the sanctioning system as a "second-order social dilemma"; cultural group selection picks which norms proliferate, but punishment stabilises any norm, adaptive or maladaptive. Primary-literature anchor for the third-party-punishment claim previously on a prosocial.world post. Cited by DD notes 2.3, 3.4.

### etymology-origins-of-dharma-md
- status: barred
- barred: self
- medium: text
- kb: `etymology-origins-of-dharma.md`
- verified: unverified
- note: prov=faqs; AI-authored corpus FAQ note per rule 1 (gloss itself flags '*AI-authored co[ntent]*')

### evans-moses-2011-interview-graeber
- status: usable
- medium: text
- cite: Ellen Evans and Jon Moses, "Interview with David Graeber," The White Review (7 Dec 2011)
- kb: `ellen-evans+jon-moses_interview-with-david-graeber.md`
- verified: web (https://theanarchistlibrary.org/library/ellen-evans-jon-moses-interview-with-david-graeber; retrieved from thewhitereview.org)

### events-organizational-development-generative-entrenchment
- status: barred
- barred: ephemera
- medium: text
- kb: `events_organizational-development-as-generative-entrenchment.md`
- verified: unverified
- note: prosocial.world events_ page (event listing/promo), not attributable essay content. P3 (2026-07-02): 5.6 [S31] re-grounded to external Boroomand & Smaldino (2021) / Smaldino et al. (2024); no live [S#] cites this.

### evolution-institute-climate-change-cooperation
- status: usable
- medium: text
- cite: Evolution Institute (Jathan Sadowski, Evan Selinger, and Thomas Seager), "Climate Change and Inter-Group Cooperation" (prosocial.world, 24 July 2012)
- kb: `posts_climate-change-and-inter-group-cooperation`
- verified: web (prosocial.world/posts/climate-change-and-inter-group-cooperation; 2012-07-24)
- note: resolved via prosocial.world.db frontmatter

### falk-2022-addressing-gaps-climate
- status: usable
- medium: text
- cite: Richard Falk, "Addressing Gaps Between Knowledge, Action, Justice: The Climate Change Challenge" (This View of Life / prosocial.world, 13 January 2022)
- kb: `posts_addressing-gaps-between-knowledge-action-justice-the-climate-change-challenge.md`
- verified: web (https://www.prosocial.world/posts/addressing-gaps-between-knowledge-action-justice-the-climate-change-challenge; live, fetched 2026-07-19)
- note: Falk = professor emeritus of international law, Princeton. Source of the Paris-2015 "global moment of universal recognition" passage cited in 8.1 [S5].

### fisher-2022-the-chaos-machine
- status: usable
- medium: text
- cite: Max Fisher, The Chaos Machine: The Inside Story of How Social Media Rewired Our Minds and Our World (Little, Brown and Company, 2022)
- kb: `Max-Fisher_The-Chaos-Machine_The-Inside-Story-of-How-Social-Media_2022.md`
- verified: web (ISBN 978-0-316-70332-1)

### fleischman-evolutionary-psychology-introduction
- status: usable
- medium: transcript
- cite: Diana Fleischman, "Evolutionary Psychology: An Introduction" (The Weekend University, YouTube, video ID lb8fH9wouYI; 2019)
- kb: `Evolutionary-Psychology-An-Introduction-Dr-Diana-Fleischman.transcript.txt`
- verified: video-URL (https://www.youtube.com/watch?v=lb8fH9wouYI)

### fleischman-universal-morality-obscured-by-evolved-morality
- status: usable
- medium: text
- cite: Diana Fleischman, "Universal Morality Is Obscured by Evolved Morality," prosocial.world (also thisviewoflife.com)
- kb: `universal-morality-is-obscured-by-evolved-morality.md`
- verified: web (prosocial.world/posts/universal-morality-is-obscured-by-evolved-morality)

### formations-of-a-spiritual-society
- status: usable
- medium: text
- cite: "The Formations of a Spiritual Society," prosocial.world
- kb: `posts_the-formations-of-a-spiritual-society.md`
- verified: web (prosocial.world/posts/the-formations-of-a-spiritual-society)
- note: Byline not confirmed via search.

### foster-postma-lamba-mesoudi-2026-microfinance-cooperation
- status: usable
- medium: text
- cite: Dugald Foster, Erik Postma, Shakti Lamba & Alex Mesoudi, "Testing evolutionary theories of human cooperation via meta-analysis of microfinance repayment", *Evolutionary Human Sciences* 8 (2026), PMCID PMC13122405
- kb: `PMC13122405-testing-evolutionary-theories-of-human-cooperation-via-meta-.md`
- verified: web (PMC13122405; authors confirmed via Europe PMC authorString "Foster D, Postma E, Lamba S, Mesoudi A")
- note: preregistered Bayesian meta-analysis of evolutionary cooperation mechanisms in real-world joint-liability microfinance (73 effect estimates, largely non-WEIRD); only punishment robustly positive, kin selection weakly negative (65% posterior more-related groups repay less), high heterogeneity and reproducibility concerns. Quantitative backing for 5.2's adaptationism hedge. Cited by DD notes 5.2, 5.5.

### four-paths-to-atheism-emergence-non-religiosity
- status: usable
- medium: text
- cite: "Four Paths to Atheism - The Emergence of Non-Religiosity," prosocial.world (discussing Ara Norenzayan & Will M. Gervais's research on pathways to religious disbelief, including "mind-blind atheism")
- kb: `four-paths-to-atheism-the-emergence-of-non-religiosity.md`
- verified: web (prosocial.world/posts/four-paths-to-atheism-the-emergence-of-non-religiosity)

### gary-dean-aggressive-coalitions-in-primates
- status: barred
- barred: self
- medium: text
- kb: `Gary-Dean_Aggressive-Coalitions-in-Primates.md`
- verified: unverified
- note: prov=Gary-Dean, author's own prose in the corpus. Sits squarely in 5.2/5.5 territory and will surface on primate-cooperation probes — barred so it cannot be mistaken for a third-party source. Underlying primate science must be cited to its own primaries.

### gary-dean-primate-cooperation-strategies
- status: barred
- barred: self
- medium: text
- kb: `Gary-Dean_Primate-Cooperation-Strategies.md`
- verified: unverified
- note: prov=Gary-Dean, author's own prose in the corpus. As above — cite the primary literature (now available via the evobio fold-in), not this summary.

### gary-dean-what-is-a-dharma
- status: barred
- barred: self
- medium: text
- kb: `Gary-Dean_What-is-a-dharma.md`
- verified: unverified
- note: prov=Gary-Dean, author's own prose in the corpus. Author's-own positions belong in notes as [A], never as [S#].

### gd-keep-0475
- status: barred
- barred: self
- medium: text
- kb: `gd_keep-0475.txt`
- verified: unverified
- note: prov=gd_keep_notes, listed barred:self dir

### geertz-1960-religion-of-java
- status: usable
- medium: text-ocr
- cite: Clifford Geertz, The Religion of Java (The Free Press, 1960; repr. 1976)
- kb: `Geertz_The-Religion-of-Java_1976.md` (full OCR text, partially transcribed; ch. 20 "Mysticism" — Sumarah — from seg 463; rasa at segs 357–365)
- verified: web (per Cambridge/UChicago Press catalogue entries)
- note: Genuine OCR text of Geertz's 1960 ethnography (1976 reprint); the earlier `clifford-geertz_…` filename is no longer in the corpus. ▲ Geertz saw a formally ranked guru-sect in 1953–54 — do not quote the movement's later "no guru" self-description for its whole history. Cited by DD notes 0.6, 3.5, 3.5.1, 3.5.3, 3.5.4.

### gintis-vanschaik-boehm-2015-zoon-politikon
- status: usable
- medium: text-ocr
- cite: Herbert Gintis, Carel van Schaik, and Christopher Boehm, "Zoon Politikon: The Evolutionary Origins of Human Political Systems," Current Anthropology 56(3) (2015): 327-353
- kb: `zoonpolitikon.md`
- verified: web (DOI 10.1086/681217)

### gold-cofnas-controversial-science-of-iq-culture
- status: usable
- medium: transcript
- cite: Andrew Gold interviewing Nathan Cofnas, "The Controversial Science of IQ & Culture" (Andrew Gold | Heretics, YouTube, video ID BvxZZ4fUHp0)
- kb: `the-controversial-science-of-iq-culture.txt`
- verified: video-URL (https://www.youtube.com/watch?v=BvxZZ4fUHp0)
- note: Filename is .txt, not .transcript.txt, but db peek confirms the content opens with this video's title -- it is this interview's transcript.

### graeber-2007-possibilities
- status: usable
- medium: text
- cite: David Graeber, Possibilities: Essays on Hierarchy, Rebellion, and Desire (AK Press, 2007)
- kb: `david-graeber-possibilities.md`
- verified: web (ISBN 9781904859666)

### graeber-2009-debt-first-five-thousand-years
- status: usable
- medium: text
- cite: David Graeber, "Debt: The First Five Thousand Years" (Mute magazine, 2009)
- kb: `david-graeber-debt-the-first-five-thousand-years.md`
- verified: web (repr. https://theanarchistlibrary.org/library/david-graeber-debt-the-first-five-thousand-years; corpus header: "Retrieved on May 16th, 2009 from www.metamute.org")
- note: the 2009 essay preceding the 2011 Melville House book of the same title — this entry cites the essay, which is what the corpus holds. Cited by DD note 6.3.

### graeber-2012-after-the-jubilee
- status: usable
- medium: text
- cite: David Graeber, "After the Jubilee," Tidal, Year II (September 2012)
- kb: `david-graeber_after-the-jubilee.md`
- verified: web (https://davidgraeber.org/articles/after-the-jubilee/; Sept 2012)

### graeber-2015-all-economies-human-economies
- status: usable
- medium: text
- cite: David Graeber, "All Economies Are Ultimately Human Economies," in *Challenging Capitalist Modernity II: Dissecting Capitalist Modernity — Building Democratic Confederalism* (Network for an Alternative Quest, 2015), §3.3, pp. 143–153
- kb: `david-graeber_all-economies-are-ultimately-human-economies.md`
- verified: web (PDF at ocalanbooks.com, per document header; conference talk, original video on YouTube)
- note: —. Cited by DD note 6.3.

### graeber-stern-weiner-2011-debt-slavery-freedom
- status: usable
- medium: text
- cite: David Graeber, interviewed by Jamie Stern-Weiner, "Debt, Slavery and our Idea of Freedom" (two-part interview, 29 August & 1 September 2011)
- kb: `david-graeber+jamie-stern-weiner_debt-slavery-and-our-idea-of-freedom.md`
- verified: web (https://davidgraeber.org/interviews/debt-slavery-and-our-idea-of-freedom/; repr. The Anarchist Library, ZNetwork)
- note: conducted on UK publication of *Debt: The First 5000 Years*. Cited by DD note 6.3.

### hagen-2018-seven-reasons-depression-not-brain-disorder
- status: usable
- medium: text
- cite: Edward Hagen (Grasshoppermouse), "Seven Reasons Why Most Major Depression Is Probably Not a Brain Disorder" (16 Dec 2018; repr. This View of Life / prosocial.world)
- kb: `seven-reasons-why-most-major-depression-is-probably-not-a-brain-disorder.md`
- verified: web (prosocial.world/posts/seven-reasons-why-most-major-depression-is-probably-not-a-brain-disorder)
- note: Contested critical-psychiatry (minority) position per project gloss.

### hagens-sapolsky-great-simplification-88
- status: usable
- medium: transcript
- cite: Nate Hagens interviewing Robert Sapolsky, "Robert Sapolsky: 'The Brain, Determinism, and Cultural Implications'" (The Great Simplification #88, YouTube, video ID xhobcj2K9v4)
- kb: `xhobcj2K9v4.transcript.txt`
- verified: video-URL (https://www.youtube.com/watch?v=xhobcj2K9v4)

### harris-diary-of-a-ceo-2023-chatgpt-warning
- status: usable
- medium: transcript
- cite: Sam Harris, interviewed by Steven Bartlett, "WARNING: ChatGPT Could Be The Start Of The End! Sam Harris," The Diary Of A CEO (YouTube, 7 August 2023)
- kb: `GmlrEgLGozw.transcript.txt`
- verified: video-URL (https://www.youtube.com/watch?v=GmlrEgLGozw)
- note: not found in current local DB (removed/moved since citation); identified via YouTube id lookup. Cited by DD note 8.2.

### harris-sapolsky-psychology-of-evil
- status: usable
- medium: transcript
- cite: Sam Harris and Robert Sapolsky, "Sam Harris and Robert Sapolsky discuss the Psychology of EVIL!" (YouTube, video ID hfcOSZu09iA; excerpted from Making Sense with Sam Harris #91, "The Biology of Good and Evil")
- kb: `Sam-Harris-and-Robert-Sapolsky-discuss-the-Psychology-of-EVIL.transcript.txt`
- verified: video-URL (https://www.youtube.com/watch?v=hfcOSZu09iA)

### hefner-bagir-2021-indonesian-pluralities
- status: usable
- medium: text
- cite: Robert W. Hefner & Zainal Abidin Bagir (eds.), *Indonesian Pluralities: Islam, Citizenship, and Democracy*, Contending Modernities series (University of Notre Dame Press, 2021)
- kb: `robert-w-hefner-ed+zainal-abidin-bagir-ed_indonesian-pluralities_islam-citizenship.md`
- verified: web (ISBN 978-0-268-10861-8)
- note: 4.6 [S15] cites the Agama Djawa Sunda / "agama leluhur" recognition material (2010 and 2017 Constitutional Court rulings).

### henrich-2015-secret-of-our-success
- status: usable
- medium: text
- cite: Joseph Henrich, The Secret of Our Success: How Culture Is Driving Human Evolution, Domesticating Our Species, and Making Us Smarter (Princeton University Press, 2015)
- kb: `Joseph-Henrich_The-Secret-of-Our-Success_How-Culture-Is-Driving-Human-Evolution-Domesticating-Our-Species.md`
- verified: web (ISBN 9780691166858)
- note: Full filename confirmed via DB path (staging.text/Secret_Of_Our_Success/); truncated "..." in the batch filename is the full subtitle.

### henry-intro-to-indigenous-religions
- status: usable
- medium: transcript
- cite: Andrew Mark Henry, "Intro to Indigenous Religions" (Religion for Breakfast, YouTube, izuL0Wquvkw)
- kb: `izuL0Wquvkw.transcript.txt`
- verified: video-URL (https://www.youtube.com/watch?v=izuL0Wquvkw)
- note: Not found in the shared corpus DB by filename lookup, but identified confidently via web search (posted Jan 2020, ReligionForBreakfast channel, host Dr. Andrew M. Henry).

### higgins-2018-after-buddhism-workbook
- status: usable
- medium: text
- cite: Winton Higgins, with Jim Champion and Ramsey Margolis, After Buddhism: A Workbook (Tuwhiri Project, 2018)
- kb: `After_Buddhism-a_workbook.md`
- verified: web (ISBN 9780473445171)
- note: Companion workbook to Stephen Batchelor's After Buddhism (Yale UP, 2015); the gloss point re: "Buddhism" as a 19th-century European coinage traces to Batchelor's original text, discussed here in commentary.

### humssguru-the-ubuntu-philosophy
- status: usable
- medium: transcript
- cite: The HUMSS Guru, "The Ubuntu Philosophy" (YouTube, video ID EaGTzaAsq7Y)
- kb: `EaGTzaAsq7Y.transcript.txt`
- verified: video-URL (https://www.youtube.com/watch?v=EaGTzaAsq7Y)
- note: Educational review-channel video (Filipino HUMSS senior-high curriculum), not a scholarly primary source, but content matches gloss (Nguni/Zulu origins, Mandela/Tutu, TRC). ▲ **Superseded for all load-bearing use** by the four scholarly entries immediately below, added 2026-07-28 after a source review found the register held no scholarly Ubuntu sources at all — only this video and one blog. Keep for colour; cite Metz, Gade, Menkiti or *Makwanyane* for substance.

### metz-2011-ubuntu-moral-theory-human-rights
- status: usable
- medium: text
- cite: Thaddeus Metz, "Ubuntu as a moral theory and human rights in South Africa," *African Human Rights Law Journal* 11(2) (2011): 532–559
- kb: `Metz_Ubuntu-as-a-Moral-Theory-and-Human-Rights-in-South-Africa_AHRLJ-2011.md` (staged at staging.text/DD/sources/1-ubuntu/, folded into the corpus 2026-08)
- verified: acquired (diamond OA; full text at `scratch/sources/part4/1-ubuntu/`, 28 pp.)
- note: The standard analytic statement of ubuntu as a *moral theory* rather than a slogan, by the philosopher who has done most to formalise it, and the natural first citation for Part 4's Ubuntu cluster. Also treats *S v Makwanyane*, so it covers both the ethics and the constitutional-law strand in one text.

### gade-2011-written-discourses-on-ubuntu
- status: usable
- medium: text
- cite: Christian B. N. Gade, "The historical development of the written discourses on ubuntu," *South African Journal of Philosophy* 30(3) (2011): 303–329
- kb: `Gade_The-Historical-Development-of-the-Written-Discourses-on-Ubuntu_SAJP-2011.md` (staged at staging.text/DD/sources/1-ubuntu/, folded into the corpus 2026-08)
- verified: acquired (OA via Aarhus PURE; full text at `scratch/sources/part4/1-ubuntu/`, 27 pp.)
- note: Traces when ubuntu was actually written about and what it was taken to mean at each stage. The load-bearing finding for Part 4: Gade advances as an explicit **hypothesis** — his word, not a demonstration — that it was "between 1993 and 1995" that ubuntu "was defined for the first time as something connected to the proverb '*umuntu ngumuntu ngabantu*'," i.e. contemporaneous with the Interim Constitution's Epilogue and the founding of the TRC, so that "the term 'ubuntu' and the proverb became intimately connected within the space of just a few years." ▲ Cite it as a dated hypothesis about the *written* discourse, not as proof about oral tradition — the distinction matters for Part 4's "a village proverb became a principle of constitutional law" sentence.

### menkiti-1984-person-and-community
- status: usable
- medium: text-ocr
- cite: Ifeanyi A. Menkiti, "Person and Community in African Traditional Thought," in Richard A. Wright (ed.), *African Philosophy: An Introduction*, 3rd edn (University Press of America, 1984), 171–181
- kb: `Menkiti_Person-and-Community-in-African-Traditional-Thought_1984.md` (staged at staging.text/DD/sources/1-ubuntu/, folded into the corpus 2026-08)
- verified: acquired (full text at `scratch/sources/part4/1-ubuntu/`, 6 pp.)
- note: The foundational statement of relational personhood — that personhood is acquired within community rather than possessed at birth — and the text the whole "I am because we are" literature argues with. Short, primary, and the correct anchor for Part 4's contrast between relational and individualist accounts of the self.

### makwanyane-1995-constitutional-court
- status: usable
- medium: text
- cite: *S v Makwanyane and Another* (CCT3/94) [1995] ZACC 3, Constitutional Court of South Africa, 6 June 1995
- verified: acquired (via Metz 2011, which quotes and analyses the ubuntu passages; primary judgment on SAFLII is `browser`-only)
- note: The judgment abolishing the death penalty in South Africa, and the case in which *ubuntu* enters constitutional jurisprudence — the documentary basis for the claim that ubuntu became a principle of law. ▲ Read here through Metz's treatment rather than in the primary; SAFLII refuses scripted fetches, so one manual download is outstanding.

### i-dare-you-define-dharma
- status: barred
- barred: self
- medium: text
- kb: `i-dare-you-define-dharma.expanded.txt`
- verified: unverified
- note: prov=gd_keep_notes; filename ends .expanded.txt; matches explicit barred:self example list.

### in-the-eye-of-the-beholder-parochial-altruism
- status: usable
- medium: text
- cite: "In the Eye of the Beholder: Parochial Altruism, Radicalization, and Extremism," prosocial.world (2023; also published thisviewoflife.com, 2020)
- kb: `in-the-eye-of-the-beholder-parochial-altruism-radicalization-and-extremism.md`
- verified: web (prosocial.world/posts/in-the-eye-of-the-beholder-parochial-altruism-radicalization-and-extremism)
- note: Specific byline not surfaced in search results. Cited by DD note 7.1.

### ishungisa-2025-prestige-gender-ideology
- status: usable
- medium: text
- cite: Alexander M. Ishungisa, Joseph A. Kilgallen, Elisha Mabula, Charlotte O. Brand, Mark Urassa & David W. Lawson, "Prestige and gender role ideology: a study of young Tanzanian men", *Evolutionary Human Sciences* (2025), PMCID PMC11949630
- kb: `PMC11949630-prestige-and-gender-role-ideology-a-study-of-young-tanzanian.md`
- verified: web (PMC11949630; authors confirmed via Europe PMC authorString "Ishungisa AM, Kilgallen JA, Mabula E, Brand CO, Urassa M, Lawson DW")
- note: field evidence for model-based social learning of *norms*; elders prestigious as "preservers and teachers of societal norms"; prestige empirically hard to separate from dominance. Cited by DD note 2.4.

### jakarta-post-australian-reporter-tale-of-living-the-news
- status: usable
- medium: text
- cite: "An Australian reporter's tale of living the news," The Jakarta Post (30 September 2001)
- kb: `1075247-an-australian-reporter-s-tale-of-living-the-news.md`
- verified: web (jawawa.id/newsitem/an-australian-reporters-tale-of-living-the-news-1447893297; JP, 2001-09-30); jawawa DB archive
- note: resolved via jawawa DB (embed_data.text path + Source/Date header)

### jakarta-post-minister-population-family-development-baduy-mbg
- status: usable
- medium: text
- cite: ANTARA News (translated, via jawawa.id), "Minister of Population and Family Development visits Baduy community to expand reach of Free Nutritious Meals Programme for 3B" (jawawa.id, 30 April 2026)
- kb: `1711255-minister-of-population-and-family-development-visits-baduy-community-to-expand.md`
- verified: web (jawawa.id/newsitem/minister-of-population-and-family-development-visits-baduy-community-to-expand-reach-of-free-nutritious-meals-1777557285; ANTARA_ID, 30 Apr 2026)
- note: Resolved via jawawa.id search -- live URL id (1777557285) differs from the KB filename prefix (1711255); confirmed live. Full headline recovered ("... for 3B"); outlet is ANTARA, not the Jakarta Post. Refers to Indonesia's MBG (Makan Bergizi Gratis) programme and Minister Wihaji.

### jakarta-post-minister-mendukbangga-baduy-family-planning
- status: usable
- medium: text
- cite: ANTARA News (translated, via jawawa.id), "Minister Mendukbangga Visits Baduy Indigenous Community for Family Planning Education" (1 May 2026)
- kb: `1711684-minister-mendukbangga-visits-baduy-indigenous-community-for-family-planning.md`
- verified: file (jawawa article dataset, 2026-05-01 batch (Source: ANTARA_ID, Date: 2026-05-01))
- note: Minister Wihaji (Mendukbangga/BKKBN head) visiting Kanekes Village, Lebak; KB-programme education delivered in Sundanese via the Family Accompaniment Team and midwives. Sibling of the 1711255 MBG-nutrition visit; cited in 4.6 [S11]. Absent from the local dev jawawa DB, which predates April 2026.

### jakarta-post-reclusive-baduy-cope-with-tourism-and-materialism
- status: usable
- medium: text
- cite: "Reclusive Baduy cope with tourism and materialism," The Jakarta Post (19 January 1997)
- kb: `1533167-reclusive-baduy-cope-with-tourism-and-materialism.md`
- verified: web (jawawa.id/newsitem/reclusive-baduy-cope-with-tourism-and-materialism-1447893297; JP, 1997-01-19); jawawa DB archive
- note: resolved via jawawa DB (embed_data.text path + Source/Date header)

### jakarta-post-west-java-patch-of-land-where-time-stands-still
- status: usable
- medium: text
- cite: "The West Java patch of land where time stands still," The Guardian (24 December 2000)
- kb: `1284432-the-west-java-patch-of-land-where-time-stands-still.md`
- verified: web (jawawa.id/newsitem/the-west-java-patch-of-land-where-time-stands-still-1447893297; GUARDIAN, 2000-12-24); jawawa DB archive
- note: resolved via jawawa DB (embed_data.text path + Source/Date header)

### jawawa-1377086-respect-for-nature-baduy
- status: usable
- medium: text
- cite: "Respect for nature serves Baduy in good stead," The Jakarta Post (5 September 1998)
- kb: `1377086-respect-for-nature-serves-baduy-in-good-stead.md`
- verified: web (jawawa.id/newsitem/respect-for-nature-serves-baduy-in-good-stead-1447893297; JP, 1998-09-05); jawawa DB archive
- note: resolved via jawawa DB (embed_data.text path + Source/Date header)

### jawawa-1684017-leiden-researcher-baduy-jet-bakels
- status: usable
- medium: text
- cite: ANTARA News (translated, via jawawa.id), "Leiden University Researcher: Preserve the Baduy Community's Culture" (jawawa.id, 17 April 2026; features Leiden Univ. researcher Jet Bakels)
- kb: `1684017-leiden-university-researcher-preserve-the-baduy-communitys-culture.md`
- verified: web (jawawa.id/newsitem/leiden-university-researcher-preserve-the-baduy-communitys-culture-1776423064; ANTARA_ID, 17 Apr 2026)
- note: Resolved via jawawa.id search -- live URL id (1776423064) differs from the KB filename prefix (1684017); confirmed live. ANTARA syndication on Leiden researcher Jet Bakels's Baduy fieldwork (since 1983-84).

### jawawa-1757483-uki-baduy-adat-commodification
- status: usable
- medium: text
- cite: ANTARA News (via jawawa.id), "UKI Highlights Protection of Customary Land and Risks of Adat Commodification" -- reporting on a Universitas Kristen Indonesia (UKI) Faculty of Law seminar on Baduy customary land (jawawa.id, 22 May 2026)
- kb: `1757483-uki-highlights-protection-of-customary-land-and-risks-of-adat-commodification.md`
- verified: web (jawawa.id/newsitem/uki-highlights-protection-of-customary-land-and-risks-of-adat-commodification-1779542151; ANTARA_ID, 22 May 2026)
- note: Resolved via jawawa.id search -- live URL id (1779542151) differs from the KB filename prefix (1757483); confirmed live. Indonesian original: "UKI soroti perlindungan tanah ulayat dan risiko komodifikasi adat," antaranews.com/berita/5578156.

### jawawa-baduy-people-immune-from-election-fever
- status: usable
- medium: text
- cite: "Baduy people immune from election fever," The Jakarta Post (5 April 2004)
- kb: `1500184-baduy-people-immune-from-election-fever.md`
- verified: web (jawawa.id/newsitem/baduy-people-immune-from-election-fever-1447893297; JP, 2004-04-05); jawawa DB archive
- note: resolved via jawawa DB (embed_data.text path + Source/Date header)

### jawawa-baduy-seba-leaders-must-be-smart
- status: usable
- medium: text
- cite: DETIK (translated, via jawawa.id), "Message From Indigenous Figures in Baduy Seba: Leaders Must Be Smart in Eradicating Corruption" (jawawa.id, 25 April 2026)
- kb: `1699529-message-from-indigenous-figures-in-baduy-seba-leaders-must-be-smart-in.md`
- verified: web (jawawa.id/newsitem/message-from-indigenous-figures-in-baduy-seba-leaders-must-be-smart-in-eradicating-corruption-1777056640; DETIK, 25 Apr 2026)
- note: Resolved via jawawa.id search -- live URL id (1777056640) differs from the KB filename prefix (1699529); confirmed live. Indonesian original (detik.com): "Pesan Tokoh Adat dalam Seba Baduy: Pemimpin Harus Pintar Berantas Korupsi"; anti-corruption pantun by Baduy elder Saidi Putra.

### jawawa-marriage-outside-five-religions-illegal-indonesia
- status: usable
- medium: text
- cite: "Marriage outside the five religions illegal in Indonesia," The Jakarta Post (24 April 2005)
- kb: `1172032-marriage-outside-the-five-religions-illegal-in-indonesia.md`
- verified: web (jawawa.id/newsitem/marriage-outside-the-five-religions-illegal-in-indonesia-1447893297; JP, 2005-04-24); jawawa DB archive
- note: resolved via jawawa DB (embed_data.text path + Source/Date header)

### jawawa-preserving-prophet-adams-legacy-west-java
- status: usable
- medium: text
- cite: "Preserving Prophet Adam's legacy in West Java," The Jakarta Post (20 November 1994)
- kb: `1003199-preserving-prophet-adam-s-legacy-in-west-java.md`
- verified: web (jawawa.id/newsitem/preserving-prophet-adams-legacy-in-west-java-1447893297; JP, 1994-11-20); jawawa DB archive
- note: resolved via jawawa DB (embed_data.text path + Source/Date header)

### jawawa-search-for-soul-through-subud
- status: usable
- medium: text
- cite: "On a search for soul through Subud," The Jakarta Post (24 March 2002)
- kb: `1242523-on-a-search-for-soul-through-subud.md`
- verified: web (jawawa.id/newsitem/on-a-search-for-soul-through-subud-1447893297; JP, 2002-03-24); jawawa DB archive
- note: resolved via jawawa DB (embed_data.text path + Source/Date header)

### jawawa-treating-mystic-believers
- status: usable
- medium: text
- cite: "Treating mystic believers," The Jakarta Post (20 November 1997)
- kb: `1510348-treating-mystic-believers.md`
- verified: web (jawawa.id/newsitem/treating-mystic-believers-1447893297; JP, 1997-11-20); jawawa DB archive
- note: resolved via jawawa DB (embed_data.text path + Source/Date header)

### john-dewey-first-evolutionary-educational-philosopher
- status: usable
- medium: text
- cite: "One of History's Greatest Interdisciplinary Thinkers" [John Dewey as "the first evolutionary educational philosopher"], prosocial.world
- kb: `posts_john-dewey-the-first-evolutionary-educational-philosopher.md`
- verified: web (prosocial.world/posts/john-dewey-the-first-evolutionary-educational-philosopher)
- note: Byline not surfaced in search results; page attributes the "Evolution's First Philosopher" label to Dewey scholar Jerome Popp.

### jonason-li-czarna-2013-dark-triad-three-countries
- status: usable
- medium: text
- cite: Peter K. Jonason, Norman P. Li & Anna Z. Czarna, "Quick and dirty: some psychosocial costs associated with the Dark Triad in three countries", *Evolutionary Psychology* 11(5) (2013), PMCID PMC10426975
- kb: `PMC10426975-quick-and-dirty-some-psychosocial-costs-associated-with-the-.md`
- verified: web (PMC10426975; authors confirmed via Europe PMC authorString "Jonason PK, Li NP, Czarna AZ")
- note: US/Singapore/Poland samples; the fast Dark-Triad strategy carries familial, romantic and platonic psychosocial costs. Cross-national ballast against overstating adaptiveness of the fast strategy. Cited by DD note 5.5.

### jordan-2016-evolution-moral-outrage
- status: usable
- medium: text
- cite: Jillian Jordan, "Evolution of Moral Outrage: I'll Punish Your Bad Behavior to Make Me Look Good" (The Conversation, 2016; repr. prosocial.world)
- kb: `posts_evolution-of-moral-outrage-ill-punish-your-bad-behavior-to-make-me-look-good.md`
- verified: web
- note: Confirmed author (Yale PhD candidate, psychology) via The Conversation original.

### jp-1998-missing-values-harmony-plurality
- status: usable
- medium: text
- cite: "The missing values of harmony and plurality," The Jakarta Post (20 September 1998)
- kb: `1378079-the-missing-values-of-harmony-and-plurality.md`
- verified: web (jawawa.id/newsitem/the-missing-values-of-harmony-and-plurality-1447893297; JP, 1998-09-20); jawawa DB archive
- note: resolved via jawawa DB (embed_data.text path + Source/Date header)

### k63-eelwz2k-gates-ai-predictions
- status: usable
- medium: transcript
- cite: "Bill Gates Shocking New 2024 AI Prediction (AGI + AI Agents)" (YouTube, video ID k63-eElwz2k, 2024; channel not identifiable from the video page)
- kb: `k63-eElwz2k.transcript.txt`
- verified: video-URL (https://www.youtube.com/watch?v=k63-eElwz2k)
- note: anonymous AI-news channel narrating Bill Gates's 2024 AI-agent predictions — second-hand commentary, not Gates verbatim. Registered usable by author decision (2026-07-19); weight accordingly. Cited in 8.2 [S4] alongside the Harris/Bartlett transcript. Cited by DD note 8.2.

### kalkhoff-serpe-pollock-2020-video-chat-proxy
- status: usable
- medium: text
- cite: Will Kalkhoff, Richard T. Serpe & Josh Pollock, "Is Video Chat a Sufficient Proxy for Face-to-Face Interaction? Biosociological Reflections on Life during the COVID-19 Pandemic" (This View of Life, 28 Jul 2020)
- kb: `posts_is-video-chat-a-sufficient-proxy-for-face-to-face-interaction-biosociological-reflections-on-life-during-the-covid-19-pandemic.md`
- verified: web
- note: Cites Turkle, *Alone Together* (2011) per gloss; full title truncated with "..." in the input filename. Cited by DD note 6.2.

### khan-2026-institutionalised-commitment
- status: usable
- medium: text
- cite: Saira Khan, "Institutionalised commitment and its origins", *Human Nature* 37 (2026), PMCID PMC13079463
- kb: `PMC13079463-institutionalised-commitment-and-its-origins.md`
- verified: web (PMC13079463; author confirmed via Europe PMC authorString "Khan S")
- note: transition from reputationally- to institutionally-enforced commitment, dated to Neolithic sedentism/agriculture/hierarchy; institutional third-party punishment enables cooperation with strangers absent reputational information. Author flags it as a narrative hypothesis. Converts an [A] in note 2.3 to a citable [S#]. Cited by DD note 2.3.

### kido-takezawa-2024-norm-psychology
- status: usable
- medium: text
- cite: Yuta Kido & Masanori Takezawa, "Coevolution of norm psychology and cooperation through exapted conformity", *Evolutionary Human Sciences* 6 (2024), PMCID PMC11503932
- kb: `PMC11503932-coevolution-of-norm-psychology-and-cooperation-through-exapt.md`
- verified: web (PMC11503932; authors confirmed via Europe PMC authorString "Kido Y, Takezawa M")
- note: gene-culture coevolutionary model of norm psychology; injunctive vs descriptive norms; internalisation evidenced by early norm acquisition in children and reward-circuit activation making "norm compliance a goal rather than a burden". Cited by DD note 1.2.

### kish-bar-on-lamm-2023-norm-psychology-identity
- status: usable
- medium: text
- cite: Kati Kish Bar-On & Ehud Lamm, "The interplay of social identity and norm psychology in the evolution of human groups", *Philosophical Transactions of the Royal Society B* 378 (2023), PMCID PMC9869443
- kb: `PMC9869443-the-interplay-of-social-identity-and-norm-psychology-in-the-.md`
- verified: web (PMC9869443; authors confirmed via Europe PMC authorString "Kish Bar-On K, Lamm E" — surname is the compound "Kish Bar-On")
- note: canonical definition of norm psychology as "the suite of psychological adaptations involved in humans' capacity to establish and enforce social norms"; argues norm psychology and social identity must be integrated. Cited by DD note 1.2.

### kline-shamsudheen-broesch-2018-variation-is-the-universal
- status: usable
- medium: text
- cite: Michelle A. Kline, Rubeena Shamsudheen and Tanya Broesch, "Variation Is the Universal: Making Cultural Evolution Work in Developmental Psychology," Philosophical Transactions of the Royal Society B 373(1743) (2018)
- kb: `variation-is-the-universal.md`
- verified: web (DOI 10.1098/rstb.2017.0059)

### klocova-kundt-puryag-lang-2025-extreme-ritual-mauritius
- status: usable
- medium: text
- cite: Eva Kundtová Klocová, Radek Kundt, Pushkar Varma Puryag & Martin Lang, "Estimated costs and benefits of participation in an extreme ritual in Mauritius", *Evolutionary Human Sciences* 7 (2025), PMCID PMC12645328
- kb: `PMC12645328-estimated-costs-and-benefits-of-participation-in-an-extreme-.md`
- verified: web (PMC12645328; authors confirmed via Europe PMC authorString "Kundtová Klocová E, Kundt R, Puryag PV, Lang M" — lead surname is the compound "Kundtová Klocová")
- note: preregistered Thaipusam Kavadi study (N = 369; Tamil Hindu in-group vs Christian out-group). ▲ In-group estimated physical costs lower but *material* costs higher; concludes "differential estimation of ritual benefits, not costs, are key to the persistence of extreme rituals" — refines rather than confirms Sosis's differential-cost-estimation account. Replaces the YouTube-transcript source for 5.2's Thaipusam claim. Cited by DD note 5.2.

### lightner-2021-ethnoscientific-expertise
- status: usable
- medium: text
- cite: Aaron D. Lightner, Cynthiann Heckelsmiller & Edward H. Hagen, "Ethnoscientific expertise and knowledge specialisation in 55 traditional cultures", *Evolutionary Human Sciences* (2021), PMCID PMC10427309
- kb: `PMC10427309-ethnoscientific-expertise-and-knowledge-specialisation-in-55.md`
- verified: web (PMC10427309; authors confirmed via Europe PMC authorString "Lightner AD, Heckelsmiller C, Hagen EH")
- note: cross-cultural coding of knowledge specialists; religious/spiritual leaders are ethnoscientific experts in 19% of records; competing cultural-transmission vs proprietary-knowledge (secretive, gatekept) models of expertise. Cited by DD note 2.4.

### lucid-dreaming-new-perspectives-2014
- status: usable
- medium: text
- cite: Ryan Hurd and Kelly Bulkeley, eds., Lucid Dreaming: New Perspectives on Consciousness in Sleep, 2 vols., foreword by Stephen LaBerge (Praeger, Santa Barbara, CA, 2014)
- kb: `Lucid-Dreaming_New-Perspectives-on-Consciousness-in-Sleep_2014.md`
- verified: web (ISBN 978-1-4408-2947-5)
- note: NEEDS-HUMAN: was under _unprocessed_ staging dir; genuine third-party work reclassified usable — confirm bibliographic details

### manning-2024-norm-reinforcement
- status: usable
- medium: text
- cite: Mason L. Manning, Bill Thompson & Thomas J. H. Morgan, "Norm reinforcement, not conformity or environmental factors, is predicted to sustain cultural variation", *Evolutionary Human Sciences* (2024), PMCID PMC11658947
- kb: `PMC11658947-norm-reinforcement-not-conformity-or-environmental-factors-i.md`
- verified: web (PMC11658947; authors confirmed via Europe PMC authorString "Manning ML, Thompson B, Morgan TJH")
- note: conformist transmission alone cannot stabilise traditions; punishment/reward-based norm reinforcement can; generates historical contingency, multi-generational adaptive lag, and boundary-driven divergence between culturally similar neighbouring groups. Cited by DD note 2.4.

### manson-2020-narcissism-lhs-instrument
- status: usable
- medium: text
- cite: Joseph H. Manson, "Is narcissism a slow life history strategy indicator?: the answer depends on the LHS instrument", *Evolutionary Psychology* 18 (2020), PMCID PMC10358412
- kb: `PMC10358412-is-narcissism-a-slow-life-history-strategy-indicator-the-ans.md`
- verified: web (PMC10358412; author confirmed via Europe PMC authorString "Manson JH")
- note: N = 929; callousness and secondary psychopathy are fast-LHS indicators across two psychometric LHS instruments, while narcissism's status is instrument-dependent. Measurement-robustness reinforcement for the psychopathy/fast-LHS mapping. Cited by DD note 5.5.

### marks-2015-evolutionary-psychology-is-neither
- status: usable
- medium: text
- cite: Jonathan Marks, "Evolutionary Psychology Is Neither" (This View of Life / prosocial.world, 22 March 2015)
- kb: `evolutionary-psychology-is-neither.md`
- verified: web (prosocial.world/posts/evolutionary-psychology-is-neither; 2015-03-22)

### meaning-alignment-institute-moral-graphs-openai-grant-winners
- status: usable
- medium: transcript
- cite: Meaning Alignment Institute, "Moral Graphs: Interview with OpenAI Grant Winners! Meaning Alignment Institute: Aligning Humanity!" (YouTube)
- kb: `bC2pQ78o754.transcript.txt`
- verified: video-URL (https://www.youtube.com/watch?v=bC2pQ78o754)
- note: filename is the bare YouTube video ID; not present in local corpus DB (path empty) but resolved via web search. Cited by DD notes 8.2, 8.4.

### melton-baumann-2010-religions-of-the-world-sumarah
- status: usable
- medium: text
- cite: J. Gordon Melton & Martin Baumann (eds.), "Sumarah" entry in *Religions of the World: A Comprehensive Encyclopedia of Beliefs and Practices* (ABC-CLIO, 2nd ed., 2010)
- kb: `sumarah-religions-of-the-world.md`, `Paul-Stange_Sumarah_2002.md`
- verified: web
- note: prov=sumarah (explicit usable-topic dir). Cited by DD notes 0.7, 3.5, 3.5.1, 3.5.2, 3.5.4.

### mesoudi-thornton-2018-what-is-cce
- status: usable
- medium: text
- cite: Alex Mesoudi & Alex Thornton, "What is cumulative cultural evolution?", *Proceedings of the Royal Society B* (2018), PMCID PMC6015846
- kb: `PMC6015846-what-is-cumulative-cultural-evolution.md`
- verified: web (PMC6015846; authors confirmed via Europe PMC authorString "Mesoudi A, Thornton A")
- note: core vs extended criteria for cumulative cultural evolution; the standard definitional reference for transmission fidelity and trait retention. Cited by DD notes 1.2, 2.4.

### migliano-vinicius-2022-foraging-niche
- status: usable
- medium: text
- cite: Andrea Bamberg Migliano & Lucio Vinicius, "The origins of human cumulative culture: from the foraging niche to collective intelligence", *Philosophical Transactions of the Royal Society B* (2022), PMCID PMC8666907
- kb: `PMC8666907-the-origins-of-human-cumulative-culture-from-the-foraging-ni.md`
- verified: web (PMC8666907; authors confirmed via Europe PMC authorString "Migliano AB, Vinicius L")
- note: transmission fidelity, teaching, specialisation, recombination and ratcheting as adaptations of the forager niche. ▲ Argues *reduced* hierarchy raised transmission fidelity — cuts against note 2.4's hierarchical paradigm carriers. Cited by DD notes 1.2, 2.4.

### milinski-2016-reputation-universal-currency
- status: usable
- medium: text
- cite: Manfred Milinski, "Reputation, a universal currency for human social interactions", *Philosophical Transactions of the Royal Society B* 371 (2016), PMCID PMC4760200
- kb: `PMC4760200-reputation-a-universal-currency-for-human-social-interaction.md`
- verified: web (PMC4760200; author confirmed via Europe PMC authorString "Milinski M")
- note: direct vs indirect reciprocity; reputation as a socially maintained score updated by observation and gossip, functioning "like money that can be used whenever the person needs help", attracting help from strangers and out-group members. Cited by DD notes 1.2, 5.2.

### mydharma-ourdharma-28258
- status: barred
- barred: self
- medium: text
- kb: `mydharma-ourdharma-28258.expanded.txt`
- verified: unverified
- note: prov=gd_keep_notes; filename ends .expanded.txt; matches explicit "mydharma/ourdharma" barred:self example.

### nedelec-dirienzo-2023-moffitt-lht
- status: usable
- medium: text
- cite: Joseph L. Nedelec & Francesco DiRienzo, "Predicting Moffitt's developmental taxonomy of antisocial behavior using life history theory: a partial test of the evolutionary taxonomy", *Evolutionary Psychology* 21 (2023), PMCID PMC10655648
- kb: `PMC10655648-predicting-moffitt-s-developmental-taxonomy-of-antisocial-be.md`
- verified: web (PMC10655648; authors confirmed via Europe PMC authorString "Nedelec JL, DiRienzo F")
- note: Add Health test; harshness and unpredictability distinguish life-course-persistent from adolescence-limited offenders, but other life-history measures do not — "a lack of support for the evolutionary taxonomy" on those measures. Corroborates the harshness/unpredictability channel while curbing the broader fast-LHS story. Cited by DD note 5.5.

### on-not-being-a-buddhist-expanded
- status: barred
- barred: self
- medium: text
- kb: `on-not-being-a-buddhist.expanded.txt`
- verified: unverified
- note: prov = gd_keep_notes, filename explicitly listed in barred:self rule, ends .expanded.txt -- author's own prose.

### pagel-2019-human-tribalism-gifford-lecture
- status: usable
- medium: text
- cite: Mark Pagel, "Human Tribalism: A Curse of Our Evolutionary Past?" Lecture 3 of "Wired for Culture," The Gifford Lectures, University of Glasgow (2019)
- kb: `Mark-Pagel_Human-Tribalism_A-Curse-of-Our-Evolutionary-Past.md`
- verified: web (https://www.youtube.com/watch?v=pBPpiRP8NQw)
- note: Published lecture text on the Gifford Lectures site; a video recording also exists (youtube.com/watch?v=pBPpiRP8NQw)

### parlupi-2005-exploring-baduy-settlements
- status: usable
- medium: text
- cite: "Exploring Baduy settlements in ancient land," The Jakarta Post (12 June 2005)
- kb: `1133276-exploring-baduy-settlements-in-ancient-land.md`
- verified: web (jawawa.id/newsitem/exploring-baduy-settlements-in-ancient-land-1447893297; JP, 2005-06-12); jawawa DB archive
- note: resolved via jawawa DB (embed_data.text path + Source/Date header)

### parthknowsai-2026-lecun-five-problems
- status: usable
- medium: transcript
- cite: Parthknowsai, "Lecun's problem with current AI" (YouTube Short, s2ZHzpwoFnc, 2026)
- kb: `s2ZHzpwoFnc.transcript.txt`
- verified: video-URL (https://www.youtube.com/shorts/s2ZHzpwoFnc)
- note: Secondary/popular source — a creator's paraphrase of Yann LeCun's LLM critiques, NOT LeCun's own words (its chain-of-thought mechanism description is the creator's garbling). Resolve to LeCun primary sources for citation-grade claims. Transcript at appliedanthropology/workshops/transcripts/ (not indexed in the shared DB at query time); summary + assessment note at appliedanthropology/workshops/DD/lecun-five-problems-with-llms.md.

### peoples-duda-marlowe-2016-hg-religion
- status: usable
- medium: text
- cite: Hervey C. Peoples, Pavel Duda & Frank W. Marlowe, "Hunter-gatherers and the origins of religion", *Human Nature* 27 (2016), PMCID PMC4958132
- kb: `PMC4958132-hunter-gatherers-and-the-origins-of-religion.md`
- verified: web (PMC4958132; authors confirmed via Europe PMC authorString "Peoples HC, Duda P, Marlowe FW")
- note: phylogenetic reconstruction of religiosity across a global hunter-gatherer sample using a time-calibrated supertree; animism ancestral; moralising active high gods "absent in early humans". Method-independent corroboration of the moralising-gods-are-late caveat, not reliant on the retracted Seshat analysis. Cited by DD notes 1.2, 2.3.

### pinker-2018-enlightenment-now
- status: usable
- medium: text
- cite: Steven Pinker, *Enlightenment Now: The Case for Reason, Science, Humanism, and Progress* (Viking, 2018)
- kb: `Enlightenment_Now.md`
- verified: web (ISBN 978-0-525-42757-5)
- note: cited in 7.7 [S1] for Pinker's summary of James C. Scott on high-modernist schemes.

### peluso-1992-rich-forests-poor-people
- status: usable
- medium: text
- cite: Nancy Lee Peluso, Rich Forests, Poor People: Resource Control and Resistance in Java (University of California Press, 1992)
- kb: `Nancy-Lee-Peluso_Rich-Forests-Poor-People_Resource-Control-and-Resistance-in-Java_1994.md`
- verified: web (ISBN 9780520089310)
- note: Full filename confirmed via DB path (staging.text/_uncategorized_/...1994.md); filename/gloss say 1994 but publisher records the first (hardcover/paperback) edition as 1992 - used the verified year.

### plummer-2022-10-second-autism-test
- status: usable
- medium: transcript
- cite: Dave Plummer, "The 10 Second Autism Test: What's YOUR Answer?" (YouTube)
- kb: `The-10-Second-Autism-Test-Whats-YOUR-Answer.transcript.txt`
- verified: video-URL (https://www.youtube.com/watch?v=fJ9X5DSnVms)

### polistina-2016-half-the-world-lives-in-cities
- status: usable
- medium: text
- cite: Matthew Polistina, "Half The World Lives In Cities. Did We Get Here Thanks To Religion?" (This View of Life / prosocial.world, 6 May 2016)
- kb: `half-the-world-lives-in-cities-did-we-get-here-thanks-to-religion.md`, `posts_half-the-world-lives-in-cities-did-we-get-here-thanks-to-religion.md`
- verified: web (prosocial.world/posts/half-the-world-lives-in-cities-did-we-get-here-thanks-to-religion; 2016-05-06)
- note: Discusses Norenzayan's "big gods" thesis and Purzycki cross-cultural game data. Cited by DD note 7.4.

### nettlau-history-of-anarchy-early-spring
- status: usable
- medium: text
- cite: Max Nettlau, *History of Anarchy I — The Early Spring of Anarchy: Its Development from the Beginnings to 1864*
- kb: `the-early-spring-of-anarchy.md`
- verified: web (repr. theanarchistlibrary.org; Nettlau's multi-volume history of anarchism)
- note: cited in 7.7 [S5] for the revolutionary cults material.

### price-2014-how-science-can-help-morality
- status: usable
- medium: text
- cite: Michael Price, "How Science Can Help Us Be More Reasonable About Morality" (This View of Life / prosocial.world, 11 February 2014)
- kb: `how-science-can-help-us-be-more-reasonable-about-morality.md`
- verified: web (prosocial.world/posts/how-science-can-help-us-be-more-reasonable-about-morality; 2014-02-11)

### price-2024-punish-the-shirkers
- status: usable
- medium: text
- cite: Michael Price, "Punish the Shirkers! Especially the Low-status Ones" (prosocial.world, 2 February 2013)
- kb: `posts_punish-the-shirkers-especially-the-low-status-ones.md`
- verified: web (prosocial.world/posts/punish-the-shirkers-especially-the-low-status-ones; 2013-02-02)
- note: resolved via prosocial.world.db frontmatter

### price-haidt-profiles-evolutionary-moral-psychology
- status: usable
- medium: text
- cite: Michael Price, "Profiles in Evolutionary Moral Psychology: Jonathan Haidt" (This View of Life / prosocial.world)
- kb: `profiles-in-evolutionary-moral-psychology-jonathan-haidt.md`
- verified: web (prosocial.world/posts/profiles-in-evolutionary-moral-psychology-jonathan-haidt; 29 Oct 2013)

### price-the-world-needs-a-secular-community-revolution
- status: usable
- medium: text
- cite: Michael Price, "The World Needs a Secular Community Revolution" (prosocial.world)
- kb: `posts_the-world-needs-a-secular-community-revolution`
- verified: web (prosocial.world/posts/the-world-needs-a-secular-community-revolution; 2 Jul 2015)
- note: resolved via prosocial.world.db frontmatter

### pollard-s-widjojo-brief-history
- status: usable
- medium: text
- cite: Rashad Pollard, "PT S. Widjojo — A Brief History" (Subud Enterprise Services International)
- kb: —
- verified: web (https://subudenterprise.com/pt-s-widjojo-a-brief-history-by-rashad-pollard/)
- note: external, not in corpus. Insider/movement-affiliated account, used for financial particulars: BSB pre-purchase of $550,000; ~$5.9m raised from member investment against a $6m target; the building completed 1980; loan trouble on a second office building, with several members rescuing and repaying it; rental income to Subud investors suspended to service debt; building sold 2008. ▲ S. Widjojo was rescued and later sold — not a collapse in the Anugraha sense. Cited in 4.5.

### deverneuil-smith-clark-anugraha-inquiry
- status: usable
- medium: text
- cite: Bryan de Verneuil-Smith & Laurence Clark, "The Failure of Anugraha — An Inquiry"
- kb: —
- verified: web (https://invisibleacademy.wordpress.com/the-failure-of-anugraha-an-inquiry/)
- note: external, not in corpus. Inquiry by two authors chosen for having no direct Anugraha involvement. Anugraha established 1979 near Windsor as a Subud International Centre; £500,000 Barclays bridging loan (1987) routed through three syndicate trustees; 76 "Subscribers" undertook repayment shares and 5 guarantor families pledged their homes; Receiver appointed June 1990, leaving subscribers liable for capital plus interest and the guarantors' houses at risk. Cited in 4.5.

### prosocial-dealing-with-psychopaths-internet-age
- status: usable
- medium: text
- cite: Joe Brewer, "Dealing With Psychopaths In The Internet Age" (prosocial.world, 19 Jan 2015)
- kb: `posts_dealing-with-psychopaths-in-the-internet-age.md`
- verified: web (prosocial.world/posts/dealing-with-psychopaths-in-the-internet-age; 19 Jan 2015)
- note: NEEDS-HUMAN: no author byline shown on the page; author not identified via light search.

### prosocial-events-examined-lives-session-42
- status: barred
- barred: ephemera
- medium: text
- kb: `events_examined-lives-mindfulness-session-42.md`
- verified: unverified
- note: prosocial.world events_ listing page (session/event promo), not an attributable essay. P3 (2026-07-02): 5.1 [S3] converted to a plain-text corpus-pointer (self-evidencing claim about the corpus's own mindfulness advocacy); no live [S#] cites this.

### prosocial-evolutionary-power-of-ritual
- status: usable
- medium: text
- cite: Michael Blume, "The Evolutionary Power of Ritual" (prosocial.world / This View of Life, 8 Jun 2013)
- kb: `posts_the-evolutionary-power-of-ritual.md`
- verified: web (prosocial.world/posts/the-evolutionary-power-of-ritual; 8 Jun 2013)
- note: Page confirmed to exist at prosocial.world/posts/the-evolutionary-power-of-ritual; author byline not located via light search. Discusses Sosis & Bressler costly-signalling, Henrich's CREDs, Legare & Souza.

### prosocial-is-there-a-universal-morality
- status: usable
- medium: text
- cite: Massimo Pigliucci, "Is There a Universal Morality?" (This View of Life / prosocial.world, 17 May 2018)
- kb: `is-there-a-universal-morality`
- verified: web (prosocial.world/posts/is-there-a-universal-morality; 17 May 2018)
- note: DB lookup resolved prov=prosocial.world with two candidate files (is-there-a-universal-morality.md and its companion -introduction-and-overview-of-responses.md), part of a multi-author response series likely curated by David Sloan Wilson; specific essay author for the exact stem match not confirmed via light search.

### prosocial-kincentricity-reciprocity-sustainability
- status: usable
- medium: text
- cite: Mitch Distin, "The Indigenous Notions of Kincentricity and Reciprocity: The Keys to Sustainability and Climate Change" (prosocial.world, 26 Jun 2024)
- kb: `the-indigenous-notions-of-kincentricity-and-reciprocity-the-keys-to-sustainability-and-climate-change.md`
- verified: web (prosocial.world/posts/the-indigenous-notions-of-kincentricity-and-reciprocity-the-keys-to-sustainability-and-climate-change; 26 Jun 2024)
- note: NEEDS-HUMAN: no author byline shown on the page; article draws heavily on Robin Wall Kimmerer's work -- consider citing Kimmerer directly (Braiding Sweetgrass) if a stronger primary source is needed.

### prosocial-odd-couple-economic-prosperity-world-religions
- status: usable
- medium: text
- cite: prosocial.world, "An Odd Couple? Did Economic Prosperity Lead to the Emergence of World Religions?" (This View of Life), reporting Baumard, Hyafil, Morris & Boyer, "Increased Affluence Explains the Emergence of Ascetic Wisdoms and Moralizing Religions," Current Biology 25(1) (2015): 10-15, doi:10.1016/j.cub.2014.10.063
- kb: `posts_an-odd-couple-did-economic-prosperity-lead-to-the-emergence-of-world-religions-2.md`
- verified: web (prosocial.world/posts/an-odd-couple-did-economic-prosperity-lead-to-the-emergence-of-world-religions-2; 2 Sep 2015); web (https://doi.org/10.1016/j.cub.2014.10.063)
- note: Not found in shared-corpus DB search (kb=prosocial.world only); byline author for the prosocial.world post itself not confirmed via light search.

### prosocial-templeton-grant-announcement
- status: barred
- barred: ephemera
- medium: text
- kb: `posts_prosocial-world-receives-grant-from-templeton-world-charity-foundation.md`
- verified: unverified
- note: Confirmed news/press-release announcement (page listed under "Category: News", no author byline) about a ProSocial World / Templeton World Charity Foundation grant -- promotional, not substantive analysis. P3 (2026-07-02): 6.2 [S2] re-grounded to external Wilson, *This View of Life* (2019); no live [S#] cites this.

### prosocial-universal-morality-obscured-by-evolved-morality
- status: usable
- medium: text
- cite: Diana Fleischman, "Universal Morality Is Obscured by Evolved Morality" (This View of Life / prosocial.world, 17 May 2018)
- kb: `universal-morality-is-obscured-by-evolved-morality`
- verified: web (prosocial.world/posts/universal-morality-is-obscured-by-evolved-morality; 17 May 2018)
- note: DB confirms prov=prosocial.world (staging.text/prosocial.world/universal-morality-is-obscured-by-evolved-morality.md); author byline not confirmed via light search.

### prosocial-world-ai-chatgpt-quest-for-fire
- status: usable
- medium: text
- cite: Shigeru Miyagawa, "Artificial Intelligence, ChatGPT, and the Quest for Fire" (This View of Life / prosocial.world)
- kb: `posts_artificial-intelligence-chatgpt-and-the-quest-for-fire.md`
- verified: web (prosocial.world/posts/artificial-intelligence-chatgpt-and-the-quest-for-fire)
- note: Miyagawa = linguist, MIT. The fire analogy runs: cooking fire let hominids extract ~100% of nutrients in half the time; we are at a "primitive, pre-fire stage in the information age," so "we need to invent the fire of our times before we let AI loose on our society." ▲ The fire is the *refining* technology we still lack — AI is questioned as a candidate for it, not identified with it. Cited in 8.2 [S6].

### prosocial-world-blurring-the-line-between-others
- status: usable
- medium: text
- cite: Marcel J. Harmon, "Blurring the Line Between 'Others' -- A Practical Application of Cultural Multilevel Selection Theory" (prosocial.world, 10 Sep 2019)
- kb: `posts_blurring-the-line-between-others`
- verified: web (prosocial.world/posts/blurring-the-line-between-others-a-practical-application-of-cultural-multilevel-selection-theory; 10 Sep 2019)
- note: Confirmed via web search: prosocial.world/posts/blurring-the-line-between-others-a-practical-application-of-cultural-multilevel-selection-theory; input filename lacked the full slug/extension

### prosocial-world-bridging-gap-laboratory-field
- status: usable
- medium: text
- cite: Dimitris Xygalatas, "Bridging the Gap Between Laboratory and Field" (This View of Life / prosocial.world)
- kb: `posts_bridging-the-gap-between-laboratory-and-field.md`
- verified: web (prosocial.world/posts/bridging-the-gap-between-laboratory-and-field)
- note: Xygalatas = anthropologist, University of Connecticut. Cited in 5.4 [S4] alongside the registered cognitive-anthropologist companion post. Cited by DD note 5.4.

### prosocial-world-developing-field-site-anthropologists-view
- status: usable
- medium: text
- cite: Harvey Whitehouse, "Developing the Field Site Concept for the Study of Cultural Evolution: An Anthropologist's View" (This View of Life / prosocial.world)
- kb: `posts_developing-the-field-site-concept-for-the-study-of-cultural-evolution-an-anthropologists-view.md`
- verified: web (prosocial.world/posts/developing-the-field-site-concept-for-the-study-of-cultural-evolution-an-anthropologists-view)
- note: Whitehouse = Chair of Social Anthropology, Oxford. Cited in 5.2 [S3]. Distinct from the registered "addressing-the-field-site… cognitive anthropologist's view" post — same series, different author.

### prosocial-world-cooperation-through-cultural-group-selection
- status: usable
- medium: text
- cite: Joe Allen, "Cooperation Through Cultural Group Selection" (prosocial.world, 25 May 2020)
- kb: `posts_cooperation-through-cultural-group-selection.md`
- verified: web (prosocial.world/posts/cooperation-through-cultural-group-selection; 25 May 2020)
- note: Discusses Turkana/Samburu/Borana/Rendille pastoralist study (cf. Mathew et al., Nature Communications 2020)

### prosocial-world-core-design-principles-handout
- status: usable
- medium: text
- cite: "Core Design Principle Handout with Spoke Diagram" (ProSocial World resource page)
- kb: `resources_processes_core-design-principles-handout-spoke-diagram.md`
- verified: web (web.archive.org/web/20250326034739/https://www.prosocial.world/resources/processes/core-design-principles-handout-spoke-diagram; live URL now HTTP 404, snapshot 26 Mar 2025 HTTP 200 via archive.org availability API, 2026-07-19)
- note: ProSocial World's own material — non-independent; registered usable with that caveat by author decision (2026-07-19). Evidences only the programme's self-description (CDPs from Ostrom). Cited in 6.1 [S4]. Cited by DD note 6.1.

### prosocial-world-events-embodiment-workshop
- status: barred
- barred: ephemera
- medium: text
- kb: `events_prosocial-embodiment-workshop.md`
- verified: unverified
- note: prosocial.world events_ page (workshop promo/listing), not an attributable essay. P3 (2026-07-02): alexander-technique [S13] converted to a plain-text corpus-pointer (the note's subject is the corpus's near-absence of Alexander material); no live [S#] cites this.

### prosocial-world-indigenous-kincentricity-reciprocity
- status: usable
- medium: text
- cite: Mitch Distin, "The Indigenous Notions of Kincentricity and Reciprocity: The Keys to Sustainability and Climate Change" (prosocial.world, 26 Jun 2024)
- kb: `posts_the-indigenous-notions-of-kincentricity-and-reciprocity-the-keys-to-sustainability-and-climate-change.md`
- verified: web (prosocial.world/posts/the-indigenous-notions-of-kincentricity-and-reciprocity-the-keys-to-sustainability-and-climate-change; 26 Jun 2024)
- note: Truncated filename resolved via shared corpus DB match: staging.text/prosocial.world/the-indigenous-notions-of-kincentricity-and-reciprocity-the-keys-to-sustainability-and-climate-change.md

### prosocial-world-mainstream-science-of-morality-sam-harris
- status: usable
- medium: text
- cite: "Mainstream Science of Morality Contradicts Sam Harris' Central Claim," prosocial.world
- kb: `posts_mainstream-science-of-morality-contradicts-sam-harris-central-claim.md`
- verified: web (https://www.prosocial.world/posts/mainstream-science-of-morality-contradicts-sam-harris-central-claim)
- note: Confirmed URL: prosocial.world/posts/mainstream-science-of-morality-contradicts-sam-harris-central-claim

### prosocial-world-prosocial-leadership-shared-power
- status: usable
- medium: text
- cite: "Prosocial Leadership: Consciously Evolving Trust and Collaboration Through Shared Power," prosocial.world
- kb: `posts_prosocial-leadership-consciously-evolving-trust-and-collaboration-through-shared-power.md`
- verified: web (https://www.prosocial.world/posts/prosocial-leadership-consciously-evolving-trust-and-collaboration-through-shared-power)
- note: Confirmed present in shared corpus DB under prosocial.world/ (no posts_ prefix, same slug)

### prosocial-world-prosocial-spirituality-active-group-engagement
- status: usable
- medium: text
- cite: "ProSocial Spirituality Active Group Engagement (P-SAGE)," prosocial.world
- kb: `www.prosocial.world_prosocial-spirituality-active-group-engagement.md`
- verified: web (web.archive.org/web/20250118093302/https://www.prosocial.world/prosocial-spirituality-active-group-engagement)
- note: Confirmed URL: prosocial.world/prosocial-spirituality-active-group-engagement; combines Ostrom's Core Design Principles with Teasdale's Interspiritual Elements, funded by John Templeton Foundation. P3-verify (2026-07-02): live URL now returns HTTP 404 (absent from sitemap.xml), but a Wayback Machine snapshot (18 Jan 2025, HTTP 200) exists and is used as the anchor; confirmed via the archive.org availability API. Cited by DD note 6.1.

### prosocial-world-solving-friction-with-fiction-storytelling
- status: usable
- medium: text
- cite: "Solving Friction with Fiction: Cooperation, Co-ordination, and the Evolution of Hunter-Gatherer Storytelling," prosocial.world (summarising Smith, Schlaepfer et al., "Cooperation and the evolution of hunter-gatherer storytelling," Nature Communications 8:1853 (2017), doi:10.1038/s41467-017-02036-8)
- kb: `posts_solving-friction-with-fiction-cooperation-co-ordination-and-the-evolution-of-hunter-gatherer-storytelling.md`
- verified: web (https://www.prosocial.world/posts/solving-friction-with-fiction-cooperation-co-ordination-and-the-evolution-of-hunter-gatherer-storytelling ; doi:10.1038/s41467-017-02036-8)
- note: Confirmed URL: prosocial.world/posts/solving-friction-with-fiction-cooperation-co-ordination-and-the-evolution-of-hunter-gatherer-storytelling

### prosocial-world-spiritual-communities-preliminary-report
- status: usable
- medium: text
- cite: "ProSocial World's Spiritual Communities Initiative Preliminary Research Report" (ProSocial World resource page; John Templeton Foundation-funded initiative)
- kb: `resources_projects_prosocial-worlds-spiritual-communities-initiative-preliminary-research-report.md`
- verified: web (web.archive.org/web/20250402075812/https://www.prosocial.world/resources/projects/prosocial-worlds-spiritual-communities-initiative-preliminary-research-report; live URL now HTTP 404, snapshot 2 Apr 2025 HTTP 200 via archive.org availability API, 2026-07-19)
- note: programme's own promotional/research material — non-independent; registered usable with that caveat by author decision (2026-07-19). Evidences only the programme's self-description. Cited in 6.1 [S4]; cf. entry prosocial-world-prosocial-spirituality-active-group-engagement. Cited by DD note 6.1.

### prosocial-world-tags-ostrom
- status: barred
- barred: ephemera
- medium: text
- kb: `tags_ostrom`
- verified: unverified
- note: prosocial.world tag-listing page, not an attributable essay. P3 (2026-07-02): 8.1 [S2] re-grounded to external Ostrom, *Governing the Commons* (1990) + Wilson, Ostrom & Cox (2013); no live [S#] cites this.

### prosocial-world-why-immigration-drives-innovation
- status: usable
- medium: text
- cite: "Why Immigration Drives Innovation," prosocial.world (drawing on Joseph Henrich's 'collective brain' concept)
- kb: `posts_why-immigration-drives-innovation.md`
- verified: web (https://www.prosocial.world/posts/why-immigration-drives-innovation)
- note: Confirmed URL: prosocial.world/posts/why-immigration-drives-innovation; also syndicated at evonomics.com

### pullman-refaie-lalumiere-krupp-2021-psychopathy-handedness
- status: usable
- medium: text
- cite: Lesleigh E. Pullman, Nabhan Refaie, Martin L. Lalumière & DB Krupp, "Is psychopathy a mental disorder or an adaptation? Evidence from a meta-analysis of the association between psychopathy and handedness", *Evolutionary Psychology* 19 (2021), PMCID PMC10358405
- kb: `PMC10358405-is-psychopathy-a-mental-disorder-or-an-adaptation-evidence-f.md`
- verified: web (PMC10358405; authors confirmed via Europe PMC authorString "Pullman LE, Refaie N, Lalumière ML, Krupp DB")
- note: 16-study meta-analysis; no elevation of non-right-handedness in psychopathy across community, offender and forensic samples; "fail[s] to support the mental disorder model", "partly support[s] the adaptive strategy model", Factor 1 vs Factor 2 divergent. Empirical test of the harmful-dysfunction argument. Cited by DD note 5.5.

### puurtinen-mappes-2009-between-group-competition
- status: usable
- medium: text
- cite: Mikael Puurtinen & Tapio Mappes, "Between-group competition and human cooperation", *Proceedings of the Royal Society B* 276 (2009), PMCID PMC2581672
- kb: `PMC2581672-between-group-competition-and-human-cooperation.md`
- verified: web (PMC2581672; authors confirmed via Europe PMC authorString "Puurtinen M, Mappes T"; ▲ Europe PMC gives year 2009, vol. 276 — some secondary citations give 2008 from the online-first date)
- note: experimental demonstration that between-group competition resolves the public-goods dilemma, raises within-group cooperation, and "intensifies the moral emotions of anger and guilt associated with violations of the cooperative norm". Cited by DD notes 1.2, 2.3.

### quinn-2024-how-the-world-made-the-west
- status: usable
- medium: text
- cite: Josephine Quinn, *How the World Made the West: A 4,000-Year History* (Bloomsbury, 2024)
- kb: `Josephine-Quinn_How-the-World-Made-the-West_a-4000-Year-History.md`
- verified: web (ISBN 978-1-5266-0518-4)

### rebers-koopmans-2012-altruistic-punishment
- status: usable
- medium: text
- cite: Susanne Rebers & Ruud Koopmans, "Altruistic punishment and between-group competition: evidence from n-person prisoner's dilemmas", *Human Nature* 23 (2012), PMCID PMC3387358
- kb: `PMC3387358-altruistic-punishment-and-between-group-competition.md`
- verified: web (PMC3387358; authors and full subtitle confirmed via Europe PMC)
- note: tests two cultural-group-selection predictions about costly punishment under intergroup competition; both confirmed, but the effect is fully explained by conditionality on *expected* punishment levels — a deflationary caveat that belongs in any note leaning on CGS. Cited by DD note 1.2.

### religion-for-breakfast-2019-atheist-churches
- status: usable
- medium: transcript
- cite: Andrew Mark Henry (Religion for Breakfast), "The Rise of Atheist Churches?" (YouTube, 27 August 2019)
- kb: `vqFJEzsffnE.transcript.txt`
- verified: video-URL (https://www.youtube.com/watch?v=vqFJEzsffnE)
- note: not found in current local DB (removed/moved since citation); identified via YouTube id lookup

### religion-through-evolutionary-lens-dominic-johnson-god-is-watching-you
- status: usable
- medium: text
- cite: "Religion through an Evolutionary Lens: A Conversation about Dominic Johnson's God Is Watching You," prosocial.world (21 Jul 2016)
- kb: `posts_religion-through-an-evolutionary-lens-a-conversation-about-dominic-johnsons-god-is-watching-you.md`
- verified: web (prosocial.world/posts/religion-through-an-evolutionary-lens-a-conversation-about-dominic-johnsons-god-is-watching-you)
- note: Discusses Dominic Johnson's book God Is Watching You: How the Fear of God Makes Us Human (Oxford University Press, 2016).

### religionforbreakfast-ancient-greeks-buddhism
- status: usable
- medium: transcript
- cite: ReligionForBreakfast, "The Ancient Greeks Who Converted to Buddhism" (YouTube)
- kb: `aA0wB3d7MgE.transcript.txt`
- verified: video-URL (https://www.youtube.com/watch?v=aA0wB3d7MgE)
- note: Confirmed via oEmbed. Matches gloss (Menander/Milinda, Dharmachakra, Halkias, Gandhāran art). Cited by DD note 7.2.

### religionforbreakfast-christianity-judaism-part-ways
- status: usable
- medium: transcript
- cite: ReligionForBreakfast, "When Did Christianity and Judaism Part Ways?" (YouTube)
- kb: `fDG5U0inNlE.transcript.txt`
- verified: video-URL (https://www.youtube.com/watch?v=fDG5U0inNlE)
- note: Confirmed via oEmbed. Matches gloss (belief-vs-practice framing, ancient religious identity, Paul).

### religionforbreakfast-computer-models-religion-wood
- status: usable
- medium: transcript
- cite: Andrew Mark Henry (ReligionForBreakfast) with Dr. Connor Wood, "Using Computer Models to Study Religion? (feat. Dr. Connor Wood)" (YouTube, video ID uPUFBCtlz_A; 12 Apr 2016)
- kb: `Using-Computer-Models-to-Study-Religion-feat-Dr-Connor-Wood.transcript.txt`
- verified: video-URL (https://www.youtube.com/watch?v=uPUFBCtlz_A)

### religionforbreakfast-intro-to-islam-rashid
- status: usable
- medium: transcript
- cite: Andrew Mark Henry (ReligionForBreakfast) with Dr. Hussein Rashid, "Intro to Islam (feat. Dr. Hussein Rashid)" (YouTube, video ID Qtz4NGzpOco)
- kb: `Qtz4NGzpOco.transcript.txt`
- verified: video-URL (https://www.youtube.com/watch?v=Qtz4NGzpOco)

### religionforbreakfast-mandalorian-real-world-religions
- status: usable
- medium: transcript
- cite: Andrew Mark Henry (ReligionForBreakfast), "What The Mandalorian Gets Right About Real-World Religions" (YouTube, video ID gl0kKXFuHD8)
- kb: `What-The-Mandalorian-Gets-Right-About-Real-World-Religions.md`
- verified: video-URL (https://www.youtube.com/watch?v=gl0kKXFuHD8)
- note: Filename is .md and prov equals the filename (stored outside any topic subdir), but content peek/gloss (Iannaccone 1994; Sosis & Bressler 2003) confirms this is a transcript of the linked video.

### religionforbreakfast-most-painful-religious-rituals
- status: usable
- medium: transcript
- cite: ReligionForBreakfast, "The Most Painful Religious Rituals" (YouTube)
- kb: `Z1tuu5cd6VI.transcript.txt`
- verified: video-URL (https://www.youtube.com/watch?v=Z1tuu5cd6VI)
- note: Confirmed via oEmbed. Covers Xygalatas's extreme-ritual fieldwork (Kavadi, San Pedro Manrique firewalk) per gloss.

### religionforbreakfast-no-true-scotsman-religion
- status: usable
- medium: transcript
- cite: Andrew Mark Henry (ReligionForBreakfast), "Religion and the No True Scotsman Fallacy" (YouTube, video ID _g9pdWyAaDs; 9 Jan 2019)
- kb: `_g9pdWyAaDs.transcript.txt`
- verified: video-URL (https://www.youtube.com/watch?v=_g9pdWyAaDs)

### religionforbreakfast-buddhism-has-a-lot-of-hells
- status: usable
- medium: transcript
- cite: Religion for Breakfast (Andrew Mark Henry), "Buddhism Has a Lot of Hells" (YouTube, video ID xKWmMLlSPsM, 2022)
- kb: `xKWmMLlSPsM.transcript.txt`
- verified: video-URL (https://www.youtube.com/watch?v=xKWmMLlSPsM); also indexed at buddhistuniversity.net (published 2022)
- note: ▲ the transcript misstates that Said "coined" Orientalism and calls him "the philosopher" — note 7.5 [S1] flags this explicitly and does not propagate it. Registered usable for the Orientalism/"positive Orientalism"/*Dharma Bums* material only.

### religionforbreakfast-real-reasons-people-become-atheists
- status: usable
- medium: transcript
- cite: Religion for Breakfast (Andrew Mark Henry), "The Real Reasons Why People Become Atheists" (YouTube)
- kb: `The-Real-Reasons-Why-People-Become-Atheists.transcript.txt`
- verified: video-URL (https://www.youtube.com/watch?v=rX4I_WaxDoU)

### robertson-2019-how-to-think-like-a-roman-emperor
- status: usable
- medium: text
- cite: Donald J. Robertson, How to Think Like a Roman Emperor: The Stoic Philosophy of Marcus Aurelius (St. Martin's Press, 2019)
- kb: `Donald-Robertson_How-to-Think-Like-a-Roman-Emperor.md`
- verified: web (ISBN 9781250196620)

### romano-1995-notes-on-sumarah-meditation-practice
- status: usable
- medium: text
- cite: Laura Romano, "Notes on Sumarah Meditation Practice" (1995)
- kb: `notes-on-sumarah-meditation-practice.md`
- verified: web (https://www.sumarah.net/en/writings/essays/notes-on-sumarah-meditation-practice.html)
- note: Author/year identified from document header ('# Notes on Sumarah meditation practice /. Cited by DD notes 3.5, 3.5.2, 3.5.3, 3.5.4.

### Laura Romano, 1995'). Cited by DD notes 3.5, 3.5.2, 3.5.3, 3.5.4.

### romano-introduction-to-sumarah-meditation
- status: usable
- medium: text
- cite: Laura Romano, "Introduction to Sumarah Meditation"
- kb: `introduction-to-sumarah.md`
- verified: web (https://www.sumarah.net/en/introduction/introduction-to-sumarah.html)
- note: Author identified from document header ('# Introduction to Sumarah Meditation /. Cited by DD notes 0.7, 3.5, 3.5.2, 3.5.4.

### Laura Romano'). Cited by DD notes 0.7, 3.5, 3.5.2, 3.5.4.

### rusch-2013-altruism-asymmetries-intergroup-conflict
- status: usable
- medium: text
- cite: Hannes Rusch, "Asymmetries in altruistic behavior during violent intergroup conflict", *Evolutionary Psychology* 11(5) (2013), PMCID PMC10437105
- kb: `PMC10437105-asymmetries-in-altruistic-behavior-during-violent-intergroup.md`
- verified: web (PMC10437105; author confirmed via Europe PMC authorString "Rusch H")
- note: critiques the symmetric n-person-prisoner's-dilemma model underlying Choi & Bowles parochial-altruism theory; historical 20th-century data show in-group altruism concentrated in defence rather than attack; "calls for a refinement of theories". Cited by DD notes 5.2, 7.1.

### rybanska-addressing-field-site-concept
- status: usable
- medium: text
- cite: Veronika Rybanska, "Addressing the Field Site Concept: A Cognitive Anthropologist's View" (prosocial.world)
- kb: `posts_addressing-the-field-site-concept-a-cognitive-anthropologists-view.md`
- verified: unverified
- note: author + exact title confirmed from the prosocial.world corpus post frontmatter (author: Veronika Rybanska). A genuine companion in the prosocial.world "field site concept" series (siblings live: Harvey Whitehouse, "Developing the Field Site Concept... An Anthropologist's View," 19 Oct 2016; plus a sociologist's and an evolutionary-biologist's view). CORRECTION to an earlier note: this is NOT a misattribution to Whitehouse. Its own standalone URL 404s live and has no Wayback snapshot, so left unverified (no external anchor obtainable); the attribution itself is sound.

### samin-movement-java-overview
- status: barred
- barred: self
- medium: text
- kb: `The-Samin_sonnet.md`
- verified: unverified
- note: LLM-generated (Claude Sonnet) corpus overview of the Samin movement — barred per METHODOLOGY `barred:self` (LLM prose may never carry `[S#]`); adjudicated by author 2026-07-19, resolving the earlier NEEDS-HUMAN caveat. Note 4.1's particulars re-grounded in the translated Indonesian source (`sejarah-dan-tradisi-unik-…blora-jawa-tengah.md`) and Benda & Castles 1969 (doi:10.1163/22134379-90002844, read in full text).

### samin-movement-overview-llm-gpt45
- status: barred
- barred: self
- medium: text
- kb: `The-Samin_gpt45.md`
- verified: unverified
- note: LLM-generated (GPT-4.5) synthesis of the Samin / Sedulur Sikep movement, no citations of its own — barred per METHODOLOGY `barred:self`; adjudicated by author 2026-07-19, resolving the earlier NEEDS-HUMAN caveat. For the subject matter use Benda & Castles 1969 (doi:10.1163/22134379-90002844) and Shiraishi, "Dangir's Testimony," Indonesia 50 (1990), both cited directly in note 4.1.

### samin-surosentiko-blora-history-video-transcript
- status: usable
- medium: transcript
- cite: "Sejarah Dan Tradisi Unik Adat Dan Ajaran Samin Surosentiko di Blora Jawa Tengah" (YouTube video, translated transcript)
- kb: `sejarah-dan-tradisi-unik-adat-dan-ajaran-samin-surosentiko-di-blora-jawa-tengah.md`
- verified: video-URL (https://www.youtube.com/watch?v=-mnKc9NOCyo)
- note: Content opens 'In my video this time, I will discuss...' confirming this is a translated transcript of an Indonesian-language YouTube video, not a written article; uploading channel not confirmed

### sandel-2020-tyranny-of-merit
- status: usable
- medium: text
- cite: Michael J. Sandel, *The Tyranny of Merit: What's Become of the Common Good?* (Farrar, Straus and Giroux, 2020)
- kb: `Tyranny_of_Merit.md`
- verified: web (ISBN 978-0-374-28998-0)

### sapolsky-2010-biological-underpinnings-of-religiosity
- status: usable
- medium: transcript
- cite: Robert Sapolsky, "The Biological Underpinnings of Religiosity" (lecture, Stanford University, c. 2010), https://www.youtube.com/watch?v=4WwAQqWUkpI
- kb: `The_Biological_Underpinnings_of_Religiosity-Robert_Sapolsky.md`
- verified: video-URL (https://www.youtube.com/watch?v=4WwAQqWUkpI)
- note: Peeked content: file header explicitly reads "by Robert Sapolsky / Transcript of a lecture at Stanford University, circa 2010."

### sapolsky-2010-human-behavioral-biology-lec01-intro
- status: usable
- medium: transcript
- cite: Robert Sapolsky, "1. Introduction to Human Behavioral Biology," Human Behavioral Biology (Stanford University, 2010; YouTube Lecture Collection)
- kb: `01-Introduction-to-Human-Behavioral-Biology-2012-by-Robert-Sapolsky-at-Stanford-University.transcript.txt`
- verified: video-URL (https://www.youtube.com/watch?v=NNnIGh9g6fA)
- note: Stanford Psych 150 lecture series, recorded 2010; filename says 2012 (upload/course-year label discrepancy, not re-verified)

### sapolsky-2010-human-behavioral-biology-lec18-aggression-ii
- status: usable
- medium: transcript
- cite: Robert Sapolsky, "18. Aggression II," Human Behavioral Biology (Stanford University, 2010; YouTube Lecture Collection), https://www.youtube.com/watch?v=wLE71i4JJiM
- kb: `18-Aggression-II.transcript.txt`
- verified: video-URL (https://www.youtube.com/watch?v=wLE71i4JJiM)
- note: same Stanford course as lecture 1; individual YouTube id for lecture 18 not re-confirmed

### sapolsky-2023-illusion-of-free-will
- status: usable
- medium: transcript
- cite: Robert Sapolsky, "The Illusion of Free Will" (YouTube, 18 October 2023)
- kb: `Robert-Sapolsky-The-Illusion-of-Free-Will.transcript.txt`
- verified: video-URL (https://www.youtube.com/watch?v=mSWJmzMoTyY)
- note: several Sapolsky talks share near-identical titles; matched on closest exact title, not independently re-verified against transcript content

### sapolsky-aggression-iii-stanford
- status: usable
- medium: transcript
- cite: Robert Sapolsky, "19. Aggression III" (Stanford, Human Behavioral Biology lecture series, YouTube)
- kb: `EtVfoIkVSu8.transcript.txt`
- verified: video-URL (https://www.youtube.com/watch?v=EtVfoIkVSu8)
- note: NEEDS-HUMAN: oEmbed confirms video ID EtVfoIkVSu8 = Stanford's "19. Aggression III" (aggression neurobiology), but the batch gloss describes Kohlberg/Piaget moral-development stages -- a topical mismatch. Verify the transcript-to-video mapping before using this citation.

### sapolsky-aggression-iv-stanford
- status: usable
- medium: transcript
- cite: Robert Sapolsky, "20. Aggression IV" (Stanford, Human Behavioral Biology lecture series, YouTube)
- kb: `20-Aggression-IV.transcript.txt`
- verified: video-URL (https://www.youtube.com/watch?v=BqP4_4kr7-0)
- note: Companion lecture to EtVfoIkVSu8 ("19. Aggression III", confirmed via oEmbed elsewhere in this batch); this file's video ID/URL not given in filename so could not be independently confirmed. Content (Baron-Cohen extreme-male-brain hypothesis via Sapolsky) is consistent with the Stanford course's aggression unit.

### sapolsky-biological-underpinnings-of-religiosity
- status: usable
- medium: transcript
- cite: Robert Sapolsky, "The Biological Underpinnings of Religiosity" (Stanford Human Behavioral Biology lecture; YouTube)
- kb: `Dr-Robert-Sapolskys-lecture-about-Biological-Underpinnings-of-Religiosity.transcript.txt`
- verified: video-URL (https://www.youtube.com/watch?v=4WwAQqWUkpI)

### sapolsky-father-offspring-07-punishment-reward-darting
- status: usable
- medium: transcript
- cite: Robert Sapolsky, "#7: Punishment/reward, darting, the Offsprings," Robert Sapolsky | Father-Offspring Interviews (YouTube)
- kb: `7-Punishment-reward-darting-the-Offsprings-Robert-Sapolsky-Father-Offspring-s-Interviews.transcript.txt`
- verified: video-URL (https://www.youtube.com/watch?v=hlMQculSywE)
- note: Same confirmed YouTube series as the companion transcript; exact video ID not located.

### sapolsky-father-offspring-20-dogs
- status: usable
- medium: transcript
- cite: Robert Sapolsky, "Dogs" (episode 20), Robert Sapolsky Father-Offspring Interviews (YouTube series)
- kb: `20-Dogs-Robert-Sapolsky-Father-Offspring-Interviews.transcript.txt`
- verified: video-URL (https://www.youtube.com/watch?v=HEsfbazTEqE)
- note: Series confirmed via web search (YouTube playlist "Robert Sapolsky Father-Offspring Interviews"); exact video ID for this numbered episode not located.

### sapolsky-father-offspring-ep11-hossenfelder
- status: usable
- medium: transcript
- cite: Robert Sapolsky with Sabine Hossenfelder, "#11: Sabine Hossenfelder, Big Bang, ASD," Robert Sapolsky | Father-Offspring Interviews (YouTube, video ID tXX-0xQ4gNI; 16 May 2024)
- kb: `11-Sabine-Hossenfelder-Big-Bang-ASD-Robert-Sapolsky-Father-Offspring-Interviews.transcript.txt`
- verified: video-URL (https://www.youtube.com/watch?v=tXX-0xQ4gNI)

### sapolsky-father-offspring-ep27-telomeres-autism
- status: usable
- medium: transcript
- cite: Robert Sapolsky, "#27: Telomeres, Meritocracy, Autism Plasticity," Robert Sapolsky | Father-Offspring Interviews (YouTube, video ID Dcx1BTcmmx4; 5 Dec 2024)
- kb: `27-Telomeres-Meritocracy-Autism-Plasticity-Robert-Sapolsky-Father-Offspring-Interviews.transcript.txt`
- verified: video-URL (https://www.youtube.com/watch?v=Dcx1BTcmmx4)

### sapolsky-father-offspring-interviews-dyslexia
- status: usable
- medium: transcript
- cite: Robert Sapolsky, "Dyslexia, Brain Size, Autoimmune Diseases," Sapolsky Father-Offspring Interviews (YouTube)
- kb: `29-Dyslexia-Brain-Size-Autoimmune-Diseases-Robert-Sapolsky-Father-Offspring-Interviews.transcript.txt`
- verified: video-URL (https://www.youtube.com/watch?v=q7P7kOwc8k4)
- note: interview-series transcript distinct from the Stanford lecture course; specific upload not located

### sapolsky-max-yoder-interview
- status: usable
- medium: transcript
- cite: Robert Sapolsky, interviewed by Max Yoder, "Do Better Work" (YouTube)
- kb: `Robert-Sapolsky-discusses-behavior-with-Max-Yoder.transcript.txt`
- verified: unverified
- note: dobetterwork.com corroborates a Sapolsky/Yoder conversation on stress; exact YouTube video ID not located via light search.

### sapolsky-neurophilosophy-determinism-talk
- status: usable
- medium: transcript
- cite: Robert Sapolsky, talk on neurophilosophy/determinism (exact title/venue unconfirmed)
- kb: `V_Neurophilo-Robert_Sapolsky-cleaned.txt`
- verified: unverified
- note: NEEDS-HUMAN: exact talk title/venue not confirmed; DB text opens with a third party's introduction of Sapolsky before his remarks on determinism

### sapolsky-primate-and-human-wars-aggression
- status: usable
- medium: transcript
- cite: Robert Sapolsky, "Primate and Human Wars: What's Behind Our Aggression?" (YouTube)
- kb: `Prof-Robert-Sapolsky-Primate-and-Human-Wars-Whats-Behind-Our-Aggression.transcript.txt`
- verified: video-URL (https://www.youtube.com/watch?v=QX9K5SqZxxw)

### sapolsky-stanford-human-behavioral-biology-lectures
- status: usable
- medium: transcript
- cite: Robert Sapolsky et al., Stanford "Human Behavioral Biology" course lecture transcripts (Stanford University / YouTube)
- kb: `Robert_Sapolsky_Lectures.txt`, `8-Recognizing-Relatives.transcript.txt`
- verified: video-URL (https://www.youtube.com/playlist?list=PL848F2368C90DDC3D)
- note: Peeked content: file is a compilation of VTT-derived lecture transcripts (e.g. header "10-Introduction-to-Neuroscience-I-5031rWXgdYo.vtt"); the first segment shown is delivered by a teaching assistant (Nathan), not Sapolsky himself. Cite the course generally; verify per-claim which segment/speaker underlies a specific citation. Cited by DD notes 0.6, 6.4.

### scott-2009-art-of-not-being-governed
- status: usable
- medium: text
- cite: James C. Scott, The Art of Not Being Governed: An Anarchist History of Upland Southeast Asia (Yale University Press, 2009; ISBN 978-0-300-15228-9)
- kb: `james-c-scott_the-art-of-not-being-governed.md`
- verified: web (ISBN 978-0-300-15228-9)
- note: Well-known monograph; title/publisher/year known with high confidence, ISBN not explicitly re-verified

### shutters-2013-detrimental-side-of-punishment
- status: usable
- medium: text
- cite: Shade T. Shutters, "Collective action and the detrimental side of punishment", *Evolutionary Psychology* 11 (2013), PMCID PMC10481089
- kb: `PMC10481089-collective-action-and-the-detrimental-side-of-punishment.md`
- verified: web (PMC10481089; author confirmed via Europe PMC authorString "Shutters ST")
- note: agent-based simulation; when retaliation against punishers or second-order punishment is permitted, "the cooperative effects of punishment are reduced or eliminated", modulated by network density. ▲ Complicates the "layered punishment sustains cooperation" claim in 5.5 §4. Cited by DD note 5.5.

### silva-mace-2014-northern-ireland-field-experiments
- status: usable
- medium: text
- cite: Antonio S. Silva & Ruth Mace, "Cooperation and conflict: field experiments in Northern Ireland", *Proceedings of the Royal Society B* 281:1792 (2014), art. 20141435, PMCID PMC4150329
- kb: `PMC4150329-cooperation-and-conflict-field-experiments-in-northern-irela.md`
- verified: web (PMC4150329; authors confirmed via Europe PMC authorString "Silva AS, Mace R")
- note: naturalistic field experiments (donations, lost-letter returns) with Catholics and Protestants; conflict reduced out-group but showed "no evidence that it influences in-group cooperation", SES dominant; "a challenge to dominant perspectives on the origins of human cooperation". Counter-evidence to Choi & Bowles, bears on 5.2 and 7.1's "same machinery" thesis. Cited by DD notes 5.2, 7.1.

### singh-henrich-2020-mentawai-taboos
- status: usable
- medium: text
- cite: Manvir Singh & Joseph Henrich, "Why do religious leaders observe costly prohibitions? Examining taboos on Mentawai shamans", *Evolutionary Human Sciences* 2 (2020), PMCID PMC10427447
- kb: `PMC10427447-why-do-religious-leaders-observe-costly-prohibitions-examini.md`
- verified: web (PMC10427447; authors confirmed via Europe PMC authorString "Singh M, Henrich J")
- note: field experiment among Mentawai shamans (Siberut) testing cooperative costly signalling, CREDs and supernatural otherness; all three supported, strongest effect on perceived belief. Non-WEIRD animist/shamanic setting; co-authored by Henrich. Full-text anchor for 5.2's CREDs claim. Cited by DD note 5.2.

### smaldino-2025-similarity-biased-learning
- status: usable
- medium: text
- cite: Paul E. Smaldino & Alejandro Pérez Velilla, "The evolution of similarity-biased social learning", *Evolutionary Human Sciences* (2025), PMCID PMC11859121
- kb: `PMC11859121-the-evolution-of-similarity-biased-social-learning.md`
- verified: web (PMC11859121; authors confirmed via Europe PMC authorString "Smaldino PE, Velilla AP" — the double surname "Pérez Velilla" is indexed under Velilla)
- note: identity-cued (parochial) social learning as an adaptive strategy; grounds the "learn from our kind" mechanism behind sectarian in-group transmission. Cited by DD note 2.4.

### smolla-akcay-2023-pathways-cultural-adaptation
- status: usable
- medium: text
- cite: Marco Smolla & Erol Akçay, "Pathways to cultural adaptation: the coevolution of cumulative culture and social networks", *Evolutionary Human Sciences* (2023), PMCID PMC10565192
- kb: `PMC10565192-pathways-to-cultural-adaptation-the-coevolution-of-cumulativ.md`
- verified: web (PMC10565192; authors confirmed via Europe PMC authorString "Smolla M, Akçay E")
- note: high-proficiency culture requires dense networks, norms suppressing individual innovation, and specialised transmitters — a formal mechanism for scholastic conservatism and for the emergence of teaching lineages. Cited by DD note 2.4.

### sparks-burleigh-barclay-2024-expressed-disapproval
- status: usable
- medium: text
- cite: Adam Sparks, Tyler Burleigh & Pat Barclay, "Expressed disapproval does not sustain long-term cooperation as effectively as costly punishment", *Evolutionary Human Sciences* 6 (2024), PMCID PMC11706683
- kb: `PMC11706683-expressed-disapproval-does-not-sustain-long-term-cooperation.md`
- verified: web (PMC11706683; authors confirmed via Europe PMC authorString "Sparks A, Burleigh T, Barclay P")
- note: 40-round experiment; expressed disapproval raises cooperation initially then decays while tangible punishment holds; disapproval "has no impact on an offender's fitness" unless backed by "physical punishment, monetary fines or fewer cooperative interactions because of ostracism" — the "teeth" argument. Explains why forager gossip works and predicts where it fails at scale. Cited by DD note 2.3.

### spinoza-1677-ethics
- status: usable
- medium: text
- cite: Benedict de Spinoza, Ethics (Ethica Ordine Geometrico Demonstrata), 1677 (Project Gutenberg ebook #3800)
- kb: `The-Ethics-Spinoza.md`
- verified: web (https://www.gutenberg.org/ebooks/3800)
- note: Classic public-domain philosophical work; no ISBN applicable.

### stange-1970-mystical-marxist-dialectics
- status: usable
- medium: text
- cite: Paul Stange, *Javanese Mystical and Marxist Dialectics* (unpublished manuscript, 1970)
- kb: `Paul-Stange_Javanese-Mystical-and-Marxist-Dialectics_1970.md`
- verified: web (https://freotopia.org/people/paulstange/dialectics.pdf)
- note: year from the document's own byline ("Paul Stange, 1970"); full text hosted on the author's freotopia.org CV page.

### stange-1977-wayang-symbolism
- status: usable
- medium: text
- cite: Paul Stange, "Mystical Symbolism in Javanese Wayang Mythology," *The South East Asian Review*, vol. 1 no. 2, 1977, pp. 109-122
- kb: `Paul-Stange_Mystical-Symbolism-in-Javanese-Wayang-Mythology_1977.md`
- verified: web (https://freotopia.org/people/paulstange/wayang.html)
- note: venue/year from the article's own citation line.

### stange-1978-revolutionary-period
- status: usable
- medium: text
- cite: Paul Stange, "Javanese Mysticism in the Revolutionary Period," *Journal of Studies in Mysticism*, vol. 1 no. 2, 1978, pp. 115-130
- kb: `Paul-Stange_Javanese-Mysticism-in-the-Revolutionary-Period_1978.md`
- verified: web (https://freotopia.org/people/paulstange/revolutionary.html)
- note: venue/year from the article's own citation line. Cited by DD notes 3.5, 3.5.1.

### stange-1979-possession-experience
- status: usable
- medium: text
- cite: Paul Stange, "Configurations of Javanese Possession Experience," *Religious Traditions*, vol. 2 no. 2, 1979, pp. 39-54
- kb: `Paul-Stange_Configurations-of-Javanese-Possession-Experience_1979.md`
- verified: web (https://freotopia.org/people/paulstange/configurations.html)
- note: venue/year from the article's own citation line. Cited by DD note 3.5.1.

### stange-1980-evolution-of-sumarah
- status: usable
- medium: text
- cite: Paul Stange, *The Evolution of Sumarah* — revision of the PhD dissertation "The Sumarah Movement in Javanese Mysticism" (University of Wisconsin–Madison, 1980); circulated as *Modern Javanism: Truth in Sumarah Practice*
- kb: `Paul-Stange_The-Evolution-of-Sumarah_1980.md`
- verified: web (https://freotopia.org/people/paulstange/evolution.pdf; sumarah.net/en/writings/books/the-evolution-of-sumarah---paul-stange.html)
- note: Stange's CV links evolution.pdf both as the book *Modern Javanism* and as the thesis *The Evolution of Sumarah* — single file; 1980 (Wisconsin PhD) confirmed via sumarah.net; KB filename year is the manifest's best estimate for this revision. Cited by DD notes 3.5, 3.5.1, 3.5.2, 3.5.3, 3.5.4.

### stange-1986-legitimate-mysticism
- status: usable
- medium: text
- cite: Paul Stange, "'Legitimate' mysticism in Indonesia," *Review of Indonesian and Malaysian Affairs*, vol. 20 no. 2, 1986, pp. 76-117
- kb: `Paul-Stange_Legitimate-mysticism-in-Indonesia_1986.md`
- verified: web (https://freotopia.org/people/paulstange/legitimate.html)
- note: venue/year from the article's own citation line. Cited by DD notes 3.5, 3.5.1, 3.5.4.

### stange-1989-sabdopalon-prophecy
- status: usable
- medium: text
- cite: Paul Stange, "Interpreting Javanist millennial imagery: the Sabdopalon prophecy under Suharto," in *Creating Indonesian Cultures*, ed. Paul Alexander (Oceania Publications, Sydney, 1989), pp. 113-134
- kb: `Paul-Stange_Interpreting-Javanist-millennial-imagery_the-Sabdopalon-prophecy-under-Suharto_1989.md`
- verified: web (https://freotopia.org/people/paulstange/interpreting.html)
- note: venue/year from the article's own citation line.

### stange-1989-sandgropers
- status: usable
- medium: text
- cite: Paul Stange, "Probing the inner life of Sandgropers," *Australian Religion Studies Review*, vol. 2 no. 3, 1989, pp. 5-14
- kb: `Paul-Stange_Probing-the-inner-life-of-Sandgropers_1989.md`
- verified: web (https://freotopia.org/people/paulstange/probing.html)
- note: venue/year from the article's own citation line.

### stange-1990-javanism-text-or-praxis
- status: usable
- medium: text
- cite: Paul Stange, "Javanism as text or praxis," *Anthropological Forum*, vol. 6 no. 2, 1990, pp. 237-255
- kb: `Paul-Stange_Javanism-as-text-or-praxis_1990.md`, `Stange_freotopia-praxis_wayback-20260728.md` (full text, folded into the corpus 2026-08)
- verified: web (https://freotopia.org/people/paulstange/praxis.html)
- note: venue/year from the article's own citation line. Cited by DD notes 3.5.3, 3.5.4.

### stange-1991-collapse-of-lineage
- status: usable
- medium: text
- cite: Paul Stange, "The Collapse of Lineage and Availability of Gnosis" (Charles Strong Trust lecture, Australian Association for the Study of Religions, Adelaide, 1991)
- kb: `Paul-Stange_The-Collapse-of-Lineage-and-Availability-of-Gnosis_1991.md`
- verified: web (https://freotopia.org/people/paulstange/gnosis.html)
- note: venue/year from the document's own citation line ("Charles Strong Trust, AASR, Adelaide, 1991"). Cited by DD note 3.5.2.

### stange-1991-deconstruction-disempowerment
- status: usable
- medium: text
- cite: Paul Stange, "Deconstruction as disempowerment: new orientalisms of Java," *Bulletin of Concerned Asian Scholars*, vol. 23 no. 3, 1991, pp. 51-71
- kb: `Paul-Stange_Deconstruction-as-disempowerment_new-orientalisms-of-Java_1991.md`
- verified: web (https://freotopia.org/people/paulstange/deconstruction.html)
- note: venue/year from the article's own citation line. Cited by DD notes 3.5, 3.5.3.

### stange-1992-religious-change-sea
- status: usable
- medium: text
- cite: Paul Stange, "Religious Change in Contemporary Southeast Asia," in *The Cambridge History of Southeast Asia*, vol. 2, ed. Nicholas Tarling (Cambridge University Press, 1992), pp. 529-584
- kb: `Paul-Stange_Religious-Change-in-Contemporary-Southeast-Asia_1992.md`
- verified: web (https://freotopia.org/people/paulstange/religious.html)
- note: venue/year from the article's own citation line. Cited by DD note 3.5.4.

### stange-1993-inner-dimensions-revolution
- status: usable
- medium: text
- cite: Paul Stange, "Inner dimensions of the Indonesian Revolution," in *Autonomous Histories, Particular Truths: Essays in Honor of John Smail*, ed. Laurie J. Sears (CSEAS, University of Wisconsin, Madison, 1993), pp. 219-243
- kb: `Paul-Stange_Inner-dimensions-of-the-Indonesian-Revolution_1993.md`, `Stange_freotopia-inner_wayback-20260728.md` (full text, folded into the corpus 2026-08)
- verified: web (https://freotopia.org/people/paulstange/inner.html)
- note: venue/year from the article's own citation line. Cited by DD notes 3.5.1, 3.5.3.

### stange-1994-silences-solonese-dance
- status: usable
- medium: text
- cite: Paul Stange, "Silences in Solonese Dance Production," *Journal of Southeast Asian Social Science*, vol. 22 (1994), pp. 210-229
- kb: `Paul-Stange_Silences-in-Solonese-Dance-Production_1994.md`
- verified: web (https://freotopia.org/people/paulstange/silences.pdf)
- note: venue/year from the document's own header line. Cited by DD note 3.5.3.

### stange-1995-exploring-modern-asian-mysticisms
- status: usable
- medium: text
- cite: Paul Stange, *Exploring Modern Asian Mysticisms* (a.k.a. *Asian Mystical Religions*, unpublished book manuscript, c. 1995)
- kb: `Paul-Stange_Exploring-Modern-Asian-Mysticisms_1995.md`
- verified: web (https://freotopia.org/people/paulstange/exploring.pdf)
- note: full text hosted on the author's freotopia.org CV page; document titles itself "Asian Mystical Religions". Cited by DD notes 3.5, 3.5.3.

### stange-2002-javanism
- status: usable
- medium: text
- cite: Paul Stange, "Javanism," in *Religions of the World: A Comprehensive Encyclopedia of Beliefs and Practices*, ed. J. Gordon Melton & Martin Baumann (ABC-CLIO, Santa Barbara, 2002)
- kb: `Paul-Stange_Javanism_2002.md`
- verified: web (https://freotopia.org/people/paulstange/javanism.html)
- note: encyclopedia entry; venue from the document's own citation line, year from the encyclopedia's 1st edition (2002).

### stange-2002-pangestu
- status: usable
- medium: text
- cite: Paul Stange, "Pangestu," in *Religions of the World: A Comprehensive Encyclopedia of Beliefs and Practices*, ed. J. Gordon Melton & Martin Baumann (ABC-CLIO, Santa Barbara, 2002)
- kb: `Paul-Stange_Pangestu_2002.md`
- verified: web (https://freotopia.org/people/paulstange/pangestu.html)
- note: encyclopedia entry; venue from the document's own citation line, year from the encyclopedia's 1st edition (2002).

### stange-2002-sapta-darma
- status: usable
- medium: text
- cite: Paul Stange, "Sapta Darma," in *Religions of the World: A Comprehensive Encyclopedia of Beliefs and Practices*, ed. J. Gordon Melton & Martin Baumann (ABC-CLIO, Santa Barbara, 2002)
- kb: `Paul-Stange_Sapta-Darma_2002.md`
- verified: web (https://freotopia.org/people/paulstange/saptadarma.html)
- note: encyclopedia entry; venue from the document's own citation line, year from the encyclopedia's 1st edition (2002).

### stange-2004-folk-religion
- status: usable
- medium: text
- cite: Paul Stange, "Folk religion," in *Southeast Asia: A Historical Encyclopedia from Angkor Wat to East Timor*, ed. Ooi Keat Gin (ABC-CLIO, Santa Barbara, 2004)
- kb: `Paul-Stange_Folk-religion_2004.md`
- verified: web (https://freotopia.org/people/paulstange/folk.html)
- note: encyclopedia entry; the document's citation line reads "Cambridge UP, Santa Barbara, 2004" but the encyclopedia was published by ABC-CLIO (Santa Barbara).

### stange-2004-kebatinan-movements
- status: usable
- medium: text
- cite: Paul Stange, "Kebatinan movements," in *Southeast Asia: A Historical Encyclopedia from Angkor Wat to East Timor*, ed. Ooi Keat Gin (ABC-CLIO, Santa Barbara, 2004)
- kb: `Paul-Stange_Kebatinan-movements_2004.md`
- verified: web (https://freotopia.org/people/paulstange/kebatinan.html)
- note: encyclopedia entry; the document's citation line reads "Cambridge UP, Santa Barbara, 2004" but the encyclopedia was published by ABC-CLIO (Santa Barbara). Cited by DD note 3.5.3.

### stange-2007-politik-perhatian
- status: usable
- medium: text
- cite: Paul Stange, *Politik Perhatian: Rasa dalam Kebudayaan Jawa*, ed. Hairus Salim HS (LKiS, Yogyakarta, 1998; 2nd printing 2009)
- kb: `Paul-Stange_Politik-Perhatian_Rasa-dalam-Kebudayaan-Jawa_2007.md`, `Paul-Stange_Politik-Perhatian_Rasa-dalam-Kebudayaan-Jawa_2007.en.md`
- verified: web (https://freotopia.org/people/paulstange/politikperhatian.pdf; kubuku.id/detail/politik-perhatian---rasa-dalam-kebudayaan-jawa/37989)
- note: publisher/years confirmed via LKiS catalogue and Jakarta library records; the KB filename year (2007) is the manifest's best estimate. The `.en.md` file is a 2026 LLM English translation of the Indonesian KB text (*The Politics of Attention: Rasa in Javanese Culture*). Cited by DD notes 3.5, 3.5.1, 3.5.2, 3.5.3, 3.5.4.

### stange-2008-kejawen-modern
- status: usable
- medium: text
- cite: Paul Stange, *Kejawen Modern: Hakikat dalam Penghayatan Sumarah*, trans. Chandra Utama, ed. Khudori (LKiS, Yogyakarta, 2009)
- kb: `Paul-Stange_Kejawen-Modern_Hakikat-dalam-Penghayatan-Sumarah_2008.md`
- verified: web (https://freotopia.org/people/paulstange/kejawenmodern.pdf; ISBN 979-978-53-8-3)
- note: Indonesian translation of Stange's Sumarah work; publisher/year/ISBN confirmed via LKiS catalogue records; the KB filename year (2008) is the manifest's best estimate. Cited by DD notes 3.5, 3.5.1, 3.5.2, 3.5.4.

### stange-2009-ancestral-voices
- status: usable
- medium: text
- cite: Paul Stange, *Ancestral Voices in Island Asia* (unpublished book manuscript, c. 2009); Indonesian version *Suara nenek moyang Nusantara*
- kb: `Paul-Stange_Ancestral-Voices-in-Island-Asia_2009.md`, `Paul-Stange_Suara-nenek-moyang-Nusantara_2009.md`
- verified: web (https://freotopia.org/people/paulstange/ancestralvoices.pdf; https://freotopia.org/people/paulstange/suara.pdf)
- note: full texts hosted on the author's freotopia.org CV page; year is the manifest's best estimate for both files. Cited by DD note 3.5.3.

### stange-logic-of-rasa-in-java
- status: usable
- medium: text
- cite: Paul Stange, "The Logic of Rasa in Java," Indonesia, no. 38 (October 1984), pp. 113-134
- kb: `the-logic-of-rasa--stange.md`, `Paul-Stange_The-Logic-of-Rasa-in-Java_1984.md`, `Stange_The-Logic-of-Rasa-in-Java_Indonesia-1984_CornellOA.md` (full text, folded into the corpus 2026-08)
- verified: web (https://www.jstor.org/stable/3350848)

### stange-relaxed-meditation-sumarah-teachings
- status: usable
- medium: text
- cite: Paul Stange (trans., ed. and intro.), Relaxed Meditation: Selected Sumarah Teachings (orig. pub. as Selected Sumarah Teachings, Dept. of Asian Studies, WAIT, Perth, 1977)
- kb: `relaxed-mediation-sumarah-stange.md`, `Paul-Stange_Relaxed-Meditation_Selected-Sumarah-Teachings_2001.md`
- verified: web (https://freotopia.org/people/paulstange/relaxedmeditation.html)

### stoelhorst-2024-moral-sentiments
- status: usable
- medium: text
- cite: J.W. Stoelhorst, "Moral Sentiments" (prosocial.world, 2024)
- kb: `posts_moral-sentiments.md`
- verified: web (https://www.prosocial.world/posts/moral-sentiments)
- note: resolved via prosocial.world.db frontmatter

### sumarah-temp-txt
- status: barred
- barred: ephemera
- medium: text
- kb: `temp.txt`
- verified: unverified
- note: near-duplicate of introduction-to-sumarah.md

### suzuki-1970-zen-mind-beginners-mind
- status: usable
- medium: text
- cite: Shunryu Suzuki, *Zen Mind, Beginner's Mind: Informal Talks on Zen Meditation and Practice* (Weatherhill, 1970)
- kb: `Zen-Mind-Beginners-Mind_Shunryu-Suzuki.md`
- verified: web (ISBN 978-0-8348-0079-3)

### tags-artificial-intelligence
- status: barred
- barred: ephemera
- medium: text
- kb: `tags_artificial-intelligence`
- verified: unverified
- note: prosocial.world tag-index page, not attributable essay content. P3 (2026-07-02): 8.2 [S6] converted to a plain-text corpus-pointer (the note describes the corpus's own AI framing); no live [S#] cites this.

### the-dharama-has-many-frames-from-which-it-can-be-discerned
- status: barred
- barred: self
- medium: text
- kb: `the-dharama-has-many-frames-from-which-it-can-be-discerned`
- verified: unverified
- note: prov=gd_keep_notes, filename ends .expanded.txt; DB match confirms .../gd_keep_notes/docs/the-dharama-has-many-frames-from-which-it-can-be-discerned.expanded.txt

### the-genies-are-out-of-the-bottle
- status: barred
- barred: self
- medium: text
- kb: `the-genies-are-out-of-the-bottle-and-there-s-no-putting-them-back`
- verified: unverified
- note: DB lookup found this at staging.text/AI/ (two model variants, o3-mini and sonnet-3.7) -- machine-generated dharma essay per the gloss's own description ("machine-generated dharma essays"), same family as dharma-research/faqs/gd_keep_notes AI-essay buckets.

### thompson-2015-waking-dreaming-being
- status: usable
- medium: text
- cite: Evan Thompson, Waking, Dreaming, Being: Self and Consciousness in Neuroscience, Meditation, and Philosophy (Columbia University Press, 2015)
- kb: `Evan-Thompson_Waking-Dreaming-Being_2015.md` (full text; earlier `Evan-Thompson_Waking-Dreaming-Being…` filenames are no longer in the corpus)
- verified: web (ISBN 9780231136952)

### van-der-kolk-2014-body-keeps-the-score
- status: usable
- medium: text
- cite: Bessel van der Kolk, *The Body Keeps the Score: Brain, Mind, and Body in the Healing of Trauma* (Viking, 2014)
- kb: `The-Body-Keeps-the-Score_Bessel-van-Der-Kolk.md`
- verified: web (ISBN 9780670785933)

### van-vugt-mismatch-interview
- status: usable
- medium: text
- cite: Mark van Vugt, interviewed by Gareth Craze, "Mismatch: An Interview with Mark van Vugt," prosocial.world, 26 July 2018. Discusses Ronald Giphart and Mark van Vugt, Mismatch: How Our Stone Age Brain Deceives Us Every Day (And What We Can Do About It) (London: Robinson, 2018), ISBN 9781472139702.
- kb: `posts_mismatch-an-interview-with-mark-van-vugt.md`
- verified: web (https://www.prosocial.world/posts/mismatch-an-interview-with-mark-van-vugt)

### vinicius-2025-social-ratcheting
- status: usable
- medium: text
- cite: Lucio Vinicius, Leonardo Rizzo, Federico Battiston & Andrea Bamberg Migliano, "Cultural evolution, social ratcheting and the evolution of human division of labour", *Philosophical Transactions of the Royal Society B* (2025), PMCID PMC11969390
- kb: `PMC11969390-cultural-evolution-social-ratcheting-and-the-evolution-of-hu.md`
- verified: web (PMC11969390; authors confirmed via Europe PMC authorString "Vinicius L, Rizzo L, Battiston F, Migliano AB")
- note: social ratcheting — irreversible interdependence among cultural specialists; individual memory limits force distribution of a repertoire across a corporate body. Cited by DD note 2.4.

### von-rueden-large-scale-societies-outliers-moral-judgment
- status: usable
- medium: text
- cite: Chris von Rueden, "Are Large-Scale Societies Outliers When It Comes to Core Elements of Moral Judgment?" prosocial.world
- kb: `posts_are-large-scale-societies-outliers-when-it-comes-to-core-elements-of-moral-judgment.md`
- verified: web (prosocial.world - part of the "Is There a Universal Morality?" series)

### vpro-the-cost-of-ai
- status: usable
- medium: transcript
- cite: VPRO Documentary (Backlight), "The Cost of A.I." (YouTube)
- kb: `The-cost-of-A-I-VPRO-Documentary.transcript.txt`
- verified: video-URL (https://www.youtube.com/watch?v=bVnpH3DE-MY)
- note: Features Vladan Joler, Abeba Birhane, Tamay Besiroglu, Milagros Miceli; covers outsourced/underpaid AI data-labour (content moderation, RLHF labelling).

### wallach-allen-2009-moral-machines
- status: usable
- medium: text
- cite: Wendell Wallach and Colin Allen, Moral Machines: Teaching Robots Right from Wrong (Oxford University Press, 2009)
- kb: `Wendell-Wallach_Moral-Machines`
- verified: web (ISBN 9780195374049)
- note: Full path confirmed via DB (staging.text/AI/Wendell-Wallach_Moral-Machines.md).

### wallach-allen-2009-moral-machines-2
- status: usable
- medium: text
- cite: Wendell Wallach and Colin Allen, *Moral Machines: Teaching Robots Right from Wrong* (Oxford University Press, 2009)
- kb: `Wendell-Wallach_Moral-Machines.md`
- verified: web (ISBN 978-0-19-537404-9)

### wayang-net-tinta-owl-tribal-ink
- status: usable
- medium: text
- cite: "Tribal Ink: Writing Stories on Human Skin," Wayang.net, 19 August 2018. No individual author credited (posted by site admin); "Tinta the Owl" (Iriene Natalia) is the article's subject, not its byline.
- kb: `tinta-the-owl-and-her-tribal-tattoo.md`
- verified: web (https://www.wayang.net/tinta-the-owl-and-her-tribal-tattoo/)
- note: Confirmed URL: wayang.net/tinta-the-owl-and-her-tribal-tattoo/; on Mentawai Arat Sabulungan custodial practice and 1954 assimilation policy

### what-can-we-learn-ubuntu-philosophy
- status: usable
- medium: text
- cite: Tyson Simmons, "What We Can Learn From the African Philosophy of Ubuntu," Kaizen Culture blog (22 March 2022)
- kb: `what-can-we-learn-from-the-african-philosophy-of-ubuntu.md`
- verified: web (web.archive.org/web/20230329064246/https://kaizenculture.blog/2022/03/22/what-we-can-learn-from-the-african-philosophy-of-ubuntu/)
- note: prov=Ubuntu (explicit usable-topic dir). P3-verify (2026-07-02): the live Kaizen Culture blog is dead (404), but a Wayback Machine snapshot (29 Mar 2023, HTTP 200) exists and is used as the anchor (confirmed via the archive.org availability API). Author "Tyson Simmons" and the 22 Mar 2022 date are from web search; the archived page could not be re-fetched directly to reconfirm the byline, so treat authorship as medium-confidence.

### what-is-dharma-md-llm-query-transcript
- status: barred
- barred: self
- medium: text
- kb: `what-is-dharma.md`
- verified: unverified
- note: Peeked content: the file opens with "> define 'dharma'" followed by an assistant's yatti-KB query and synthesis - a Claude/LLM query-and-answer transcript defining dharma, not an external citable source. Same character as the gd_keep_notes/definition-style self-authored material even though its prov string ("what-is-dharma.md", i.e. it sits directly under staging.text/) is not literally in rule 1's listed prov set.

### why-are-dharmas-necessary
- status: barred
- barred: self
- medium: text
- kb: `why-are-dharmas-necessary.md`
- verified: unverified
- note: NEEDS-HUMAN: prov=anthropology is not in the literal rule-1 barred-dir list, but the text ('The Necessity of Dharmas in Human Societies', generic numbered-section essay with no citations or named author) reads as LLM-generated prose matching the barred:self pattern; flagging for confirmation

### why-is-the-concept-of-dharma-important-analytical
- status: barred
- barred: self
- medium: text
- kb: `why-is-the-concept-of-dharma-important_analytical.md`
- verified: unverified
- note: prov = dharma-research -- DD/AA in-house research prose, no [S#] sourcing.

### why-is-the-concept-of-dharma-important-conversational-md
- status: barred
- barred: self
- medium: text
- kb: `why-is-the-concept-of-dharma-important_conversational.md`
- verified: unverified
- note: prov=dharma-research

### why-is-the-concept-of-dharma-important-technical
- status: barred
- barred: self
- medium: text
- kb: `why-is-the-concept-of-dharma-important_technical.md`
- verified: unverified
- note: prov=dharma-research, explicit barred:self bucket.

### wikipedia-evolutionary-psychology
- status: usable
- medium: text
- cite: Wikipedia contributors, "Evolutionary Psychology," Wikipedia (accessed 2026)
- kb: `evolutionary-psychology-culture.md`
- verified: web (https://en.wikipedia.org/wiki/Evolutionary_psychology)
- note: KB text is a Wikipedia mirror (confirmed via db peek: page opens with a reference tag pointing to en.wikipedia.org/wiki/Evolutionary_psychology); treat as tertiary source and trace claims to Wikipedia's own citations for primary sourcing.

### wilber-1996-brief-history-of-everything
- status: usable
- medium: text
- cite: Ken Wilber, A Brief History of Everything (Boston: Shambhala, 1996), ISBN 9781570621871.
- kb: `Ken-Wilber_A-Brief-History-of-Everything_1996.md`
- verified: web (ISBN 9781570621871)

### williamson-eberstadt-unemployed-men
- status: usable
- medium: transcript
- cite: Chris Williamson interviewing Nicholas Eberstadt, "How Are 7 Million Unemployed Men Actually Surviving? - Nicholas Eberstadt" (Modern Wisdom, YouTube, video ID vknKvG3yrYM)
- kb: `vknKvG3yrYM.transcript.txt`
- verified: video-URL (https://www.youtube.com/watch?v=vknKvG3yrYM)
- note: Content matches gloss (pandemic transfers as UBI "dress rehearsal"); Eberstadt is a labour-economics/demography scholar (AEI). Cited by DD note 8.2.

### wilson-2013-is-religion-useful
- status: usable
- medium: text
- cite: David Sloan Wilson, "Is Religion Useful? A Test Involving Common Pool Resource Groups" (This View of Life / prosocial.world, 18 March 2013)
- kb: `is-religion-useful-a-test-involving-common-pool-resource-groups.md`
- verified: web (https://www.prosocial.world/posts/is-religion-useful-a-test-involving-common-pool-resource-groups)
- note: DB text byline truncated to 'David' in first 400 chars; This View of Life site attributes this piece to David Sloan Wilson

### wilson-2017-reaching-new-plateau-multilevel-selection
- status: usable
- medium: text
- cite: David Sloan Wilson, "Reaching a New Plateau for the Acceptance of Multilevel Selection" (This View of Life / prosocial.world, 2017)
- kb: `posts_reaching-a-new-plateau-for-the-acceptance-of-multilevel-selection.md`
- verified: web
- note: Reports Fehr & Gächter, "Altruistic Punishment in Humans" (Nature, 2002) per gloss.

### wilson-aktipis-cheating-cell-interview
- status: usable
- medium: text
- cite: Athena Aktipis, interviewed by Alan Honick, "The Cheating Cell: An Interview with Athena Aktipis," prosocial.world, 15 June 2020 (byline Alan Honick, not David Sloan Wilson). Discusses Athena Aktipis, The Cheating Cell: How Evolution Helps Us Understand and Treat Cancer (Princeton University Press, 2020), ISBN 9780691163840.
- kb: `posts_the-cheating-cell-an-interview-with-athena-aktipis`
- verified: web (https://www.prosocial.world/posts/the-cheating-cell-an-interview-with-athena-aktipis)

### wilson-evolution-coming-interspiritual-age
- status: usable
- medium: text
- cite: David Sloan Wilson, "Evolution And The Coming Interspiritual Age: A Conversation With Kurt Johnson," prosocial.world, 21 May 2015.
- kb: `posts_evolution-and-the-coming-interspiritual-age`
- verified: web (https://www.prosocial.world/posts/evolution-and-the-coming-interspiritual-age-a-conversation-with-kurt-johnson)
- note: resolved via prosocial.world.db frontmatter

### wilson-moral-universals-tinbergen
- status: usable
- medium: text
- cite: David Sloan Wilson, "Moral Universals, Moral Particulars, and Tinbergen's Four Questions" (This View of Life / prosocial.world)
- kb: `posts_moral-universals-moral-particulars-and-tinbergens-four-questions.md`
- verified: web

### wilson-mulgan-big-mind-conversation
- status: usable
- medium: text
- cite: David Sloan Wilson (prosocial.world), "Thinking Clearly About Collective Intelligence: A Conversation with Geoff Mulgan about His New Book Big Mind" (This View of Life)
- kb: `posts_thinking-clearly-about-collective-intelligence-a-conversation-with-geoff-mulgan-about-his-new-book-big-mind.md`
- verified: web
- note: Page confirmed; interviewer's identity inferred (prosocial.world founder/editor) rather than directly confirmed.

### wilson-new-atheism-stealth-religion-five-years-later
- status: usable
- medium: text
- cite: David Sloan Wilson, "The New Atheism as a Stealth Religion, Five Years Later" (This View of Life / prosocial.world)
- kb: `posts_the-new-atheism-as-a-stealth-religion-five-years-later.md`
- verified: web
- note: DB confirms prov=prosocial.world (staging.text/prosocial.world/the-new-atheism-as-a-stealth-religion-five-years-later.md). Follows Wilson's earlier "Atheism as a Stealth Religion" essay series; Ayn Rand's Objectivism as exhibit A per gloss.

### wilson-ostrom-cox-2013-generalizing-core-design-principles
- status: usable
- medium: text
- cite: David Sloan Wilson, Elinor Ostrom and Michael E. Cox, "Generalizing the Core Design Principles for the Efficacy of Groups," Journal of Economic Behavior & Organization 90S (2013): S21-S32; reposted as "Generalizing the Core Design Principles for the Efficacy of Groups," prosocial.world
- kb: `posts_generalizing-the-core-design-principles-for-the-efficacy-of-groups.md`
- verified: web (prosocial.world/posts/generalizing-the-core-design-principles-for-the-efficacy-of-groups; repost dated 4 Jul 2013)
- note: Truncated batch filename resolved via web search. Merged 2026-07-24 with a duplicate entry keyed `prosocial-world-generalizing-core-design-principles`, which pointed at the same corpus file but credited the piece to Michael E. Cox alone (the prosocial.world repost byline). This entry's fuller attribution — Wilson, Ostrom & Cox, the JEBO 2013 paper — is the correct one and matches how note 3.1 cites it at [S3]. Neither key was referenced via [src:].

### wilson-sloan-price-is-there-a-universal-morality-overview
- status: usable
- medium: text
- cite: David Sloan Wilson, Mark Sloan, and Michael Price, "Is There a Universal Morality? Introduction and Overview of Responses" (prosocial.world)
- kb: `posts_is-there-a-universal-morality-introduction-and-overview-of-responses.md`
- verified: web (https://www.prosocial.world/posts/is-there-a-universal-morality-introduction-and-overview-of-responses)
- note: resolved via prosocial.world.db frontmatter

### wilson-styles-atkins-2024-conscious-multilevel-cultural-evolution
- status: usable
- medium: text
- cite: David Sloan Wilson, Robert Styles & Paul W. B. Atkins, "Conscious Multilevel Cultural Evolution: Theory, Practice, and Two Case Studies" (This View of Life / prosocial.world, 2024)
- kb: `posts_conscious-multilevel-cultural-evolution-theory-practice-and-two-case-studies`
- verified: web
- note: Confirmed at prosocial.world/posts/conscious-multilevel-cultural-evolution-theory-practice-and-two-case-studies and davidsloanwilson.world.

### wilson-styles-atkins-2024-conscious-multilevel-cultural-evolution-2
- status: usable
- medium: text
- cite: David Sloan Wilson, Robert Styles and Paul Atkins, "Conscious Multilevel Cultural Evolution: Theory, Practice, and Two Case Studies" (2024), prosocial.world
- kb: `posts_conscious-multilevel-cultural-evolution-theory-practice-and-two-case-studies.md`
- verified: web (prosocial.world/posts/conscious-multilevel-cultural-evolution-theory-practice-and-two-case-studies)

### wilson-truth-reconciliation-group-selection-10
- status: usable
- medium: text
- cite: David Sloan Wilson, "Truth and Reconciliation for Group Selection: 10. Naive Gene Selectionism" (This View of Life / prosocial.world)
- kb: `truth-and-reconciliation-for-group-selection-10-naive-gene-selectionism.md`
- verified: web (https://www.prosocial.world/posts/truth-and-reconciliation-for-group-selection-10-naive-gene-selectionism)

### wilson-truth-reconciliation-group-selection-16-major-transitions
- status: usable
- medium: text
- cite: David Sloan Wilson, "Truth and Reconciliation for Group Selection: 16. Individualism Is Dead: Long Live Major Transitions," prosocial.world
- kb: `posts_truth-and-reconciliation-for-group-selection-16-individualism-is-dead-long-live-major-transitions.md`
- verified: web (prosocial.world/posts/truth-and-reconciliation-for-group-selection-16-individualism-is-dead-long-live-major-transitions)

### wilson-tvol-is-there-a-universal-morality
- status: usable
- medium: text
- cite: David Sloan Wilson, Mark Sloan and Michael Price, "Is There a Universal Morality? Introduction and Overview of Responses" (This View of Life / prosocial.world, 23 May 2018); this DS_Wilson-directory copy (tvol_morality.md) is the series-introduction section
- kb: `tvol_morality.md`
- verified: web (https://www.prosocial.world/posts/is-there-a-universal-morality-introduction-and-overview-of-responses; 23 May 2018)
- note: DUPLICATE of key wilson-sloan-price-is-there-a-universal-morality-overview -- tvol_morality.md (DS_Wilson dir) is the series-introduction section of that same Wilson/Sloan/Price essay; its opening ("Our moral sense makes involuntary... Eating shrimp... Leviticus") matches the overview page verbatim. NOT a separate Wilson-solo article (Wilson's own distinct lead piece in the series is "Moral Universals, Moral Particulars and Tinbergen's Four Questions," 17 May 2018). Cited by DD note 8.2.

### would-abandoning-moral-foundations-better-society
- status: usable
- medium: text
- cite: "Would Abandoning Moral Foundations Make for a Better Society?" prosocial.world (discussing Jonathan Haidt's moral foundations theory vs Steven Pinker's Better Angels argument)
- kb: `would-abandoning-moral-foundations-make-for-a-better-society.md`
- verified: web (prosocial.world/posts/would-abandoning-moral-foundations-make-for-a-better-society)

### wrangham-2019-goodness-paradox
- status: usable
- medium: text
- cite: Richard Wrangham, *The Goodness Paradox: The Strange Relationship Between Virtue and Violence in Human Evolution* (Pantheon Books, 2019)
- kb: `the-goodness-paradox-the-strange-relationship-between-virtue-and-violence-in-human-evolution-2018028837-9781101870907-9781101870914_compress.md`
- verified: web (ISBN 978-1-101-87090-7)
- note: Filename resolved via DB path (staging.text/Wrangham/...9781101870907-9781101870914_compress.md), which itself embeds the ISBNs. Merged 2026-07-24 with a duplicate entry keyed `wrangham-2019-the-goodness-paradox`; both described the same work and the same corpus file, which double-counted it in the `kb:` delta index. Neither key was referenced by any note.

### yt-aliran-kepercayaan-paguyuban-sumarah
- status: usable
- medium: transcript
- cite: "Aliran Kepercayaan dan Kebatinan Paguyuban Sumarah" (YouTube, Indonesian-language explainer on Paguyuban Sumarah)
- kb: `Aliran-Kepercayaan-dan-Kebatinan-Paguyuban-Sumarah.transcript.txt`
- verified: unverified
- note: transcript carries no channel/URL metadata and the video was not resolvable via web search; treat factual claims as low-weight popular-source corroboration only. Cited by DD notes 3.5.1, 3.5.4.

### yt-cara-meditasi-sumarah-kakang-cahyo
- status: usable
- medium: transcript
- cite: Kakang Cahyo, "Cara Meditasi sumarah membangkitkan daya Nur Allah" (YouTube, SANTRI NJOWO channel)
- kb: `Cara-Meditasi-sumarah-membangkitkan-daya-Nur-Allah-Kakang-Cahyo.transcript.txt`
- verified: unverified
- note: speaker/channel from the transcript's own title line; video URL not resolvable via web search; practitioner how-to talk, low-weight popular source.

### yt-sekilas-paguyuban-sumarah-yogyakarta
- status: usable
- medium: transcript
- cite: "Sekilas tentang Paguyuban Sumarah Yogyakarta" (YouTube, Indonesian-language overview of the Yogyakarta Paguyuban Sumarah)
- kb: `SEKILAS-TENTANG-PAGUYUBAN-SUMARAH-YOGYAKARTA.transcript.txt`
- verified: unverified
- note: transcript carries no channel/URL metadata and the video was not resolvable via web search; treat factual claims as low-weight popular-source corroboration only. Cited by DD notes 3.5.1, 3.5.4.

### zerzan-1991-catastrophe-of-postmodernism
- status: usable
- medium: text
- cite: John Zerzan, "The Catastrophe of Postmodernism" (1991; repr. The Anarchist Library)
- kb: `john-zerzan_the-catastrophe-of-postmodernism.md`
- verified: web (https://theanarchistlibrary.org/library/john-zerzan-the-catastrophe-of-postmodernism)

---

### zuboff-2019-age-of-surveillance-capitalism
- status: usable
- medium: text
- cite: Shoshana Zuboff, *The Age of Surveillance Capitalism: The Fight for a Human Future at the New Frontier of Power* (New York: PublicAffairs, 2019)
- kb: `Zuboff_The-Age-of-Surveillance-Capitalism_2019.md`
- verified: file (eight-part definition at seg 0; "Discovery of Behavioral Surplus" chapter at segs 60–73; born-digital body, tesseract header covers front matter only)
- note: The economic account of the attention adversary — behavioral surplus, prediction products, behavioral futures markets, instrumentarian power.

### zuckerman-2009-atheism-secularity-and-well-being
- status: usable
- medium: text
- cite: Phil Zuckerman, "Atheism, Secularity, and Well-Being: How the Findings of Social Science Counter Negative Stereotypes and Assumptions," *Sociology Compass* 3:6 (2009), 949–971
- kb: `Zuckerman_Atheism-Secularity-and-Well-Being_SociologyCompass-2009.md`
- verified: file (title, author, abstract at seg 0; criminality review at seg 13; volume/pages from the published record, not re-checked online)
- note: Review of the social-science record on atheists and secular societies; the "atheists are more immoral" claim "long disproven."

## Not used (assessed and excluded)
- `Glenn-Roberts_CH-19-FINAL-draft.md` — marked "DRAFT IN DEVELOPMENT – NOT FOR CIRCULATION"; barred per BRIEF.
- `Glenn-Roberts_A-day-in-the-life-of-Archie-Roberts.md`, `Glenn-Roberts_Dog-Dharma-Notes.md` — personal notes/letters, barred:ephemera per BRIEF.
- `Anna-Ronan_Anarchism-as-a-Spiritual-Practice_2019.md`, `Anna-Prouty_An-Anarcho-Taoist-Manifesto_2017.md` — reverse-direction translation specimens; deliberately left to note 8.3 (another agent's assignment) to avoid duplication.
