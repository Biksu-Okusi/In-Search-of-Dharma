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

### alan-barnard-1993-kropotkin-visits-the-bushmen
- status: usable
- medium: text
- cite: Alan Barnard, "Primitive Communism and Mutual Aid: Kropotkin Visits the Bushmen," in C. M. Hann (ed.), *Socialism: Ideals, Ideologies, and Local Practice* (ASA Monographs 31; London: Routledge, 1993), pp. 27–42
- kb: `Alan-Barnard_Primitive-Communism-and-Mutual-Aid_Kropotkin-Visits-the-Bushmen_1992.md`
- verified: web (Taylor & Francis chapter page for *Socialism: Ideals, Ideologies and Local Practice*, ASA Monographs 31, ch. 10, DOI 10.4324/9780203392676; Namibia Scientific Society library catalogue record 51105 gives pp. 27–42, Routledge 1993)
- note: Kalahari specialist auditing Kropotkin's mutual-aid reading against San ethnography — confirms the sharing pattern, qualifies it as theory-laden, bounded to the band cluster, and partly envy-management. The corpus's most nearly neutral check on the cooperative-forager picture. ▲ The KB filename year (1992) is the Anarchist Library posting date; the published chapter is 1993 — cite 1993. Cited by DD notes 2.3, 4.3.

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
- note: second fusion specimen — anarchist consent theory fused with *wu wei* and a needs/feelings psychology; explicitly touches Buddhism ("freeing yourself from desire, in a full Buddhist sense"). Same SPECIMEN-GRADE caveat as the Ronan entry.

### anna-ronan-2019-anarchism-as-a-spiritual-practice
- status: usable
- medium: text
- cite: Anna Ronan, "Anarchism as a Spiritual Practice," DSA Libertarian Socialist Caucus Pamphlet Program, 23 May 2019 (repr. The Anarchist Library)
- kb: `Anna-Ronan_Anarchism-as-a-Spiritual-Practice_2019.md`
- verified: web (dsa-lsc.org 2019-05-24 posting; theanarchistlibrary.org/library/anna-ronan-anarchism-as-a-spiritual-practice). The caucus's own disclaimer marks it as the author's opinion, not caucus consensus.
- note: primary specimen of a live anarchist–contemplative fusion ("Anarchism is my religion"; Taoism via *The Tao of Pooh*). SPECIMEN-GRADE ONLY: a self-published movement pamphlet with no scholarly or institutional standing — citable as evidence the fusion is being attempted and for how it assembles, never as authority on whether it works. Cited by DD notes 2.5, 8.3.

### aquinas-summa-treatise-on-law
- status: usable
- medium: text
- cite: Thomas Aquinas, *Summa Theologiae* I-II, qq. 90–97 ("Treatise on Law"), trans. Fathers of the English Dominican Province (2nd rev. ed., 1920)
- kb: `cicero-aquinas_natural-law-primary-texts.md` (attributed summary, staged at workshops/DD/sources/ — not yet folded into corpus)
- verified: web (newadvent.org/summa, qq. 90–97 saved to DD archive 2026-07-28)
- note: attributed summary note with verified page anchors, shared with the Cicero entry. Natural law defined as the rational creature's participation in eternal law, knowable by 'the light of natural reason' (q. 91 a. 2) — the reason-accessible lower storey that weakens Part 1's 'cannot be secularised' contrast. Anchored edition-independently by q./a. Public domain.

### asad-1993-genealogies-of-religion
- status: usable
- medium: text-ocr
- cite: Talal Asad, *Genealogies of Religion: Discipline and Reasons of Power in Christianity and Islam* (Baltimore: Johns Hopkins University Press, 1993)
- kb: `talal-asad_genealogies-of-religion_1993.md` (attributed summary, staged at workshops/DD/sources/ — not yet folded into corpus)
- verified: web (ISBN 978-0-8018-4632-8); central quotation confirmed verbatim at p. 29 of the full text
- note: attributed summary note with verified page anchors of ch. 1, 'The Construction of Religion as an Anthropological Category' (pp. 27–54) — the strongest published opponent of DD's central move, previously cited at blurb level. Full text in DD local archive (scratch/sources/part1/, gitignored); community upload, reading copy only. Cited by DD note 1.3 (S18) and Part 1.

### bakunin-1882-god-and-the-state
- status: usable
- medium: text
- cite: Mikhail Bakunin, *God and the State* (written 1871; pub. posthumously 1882, ed. Carlo Cafiero & Élisée Reclus)
- kb: `michail-bakunin_god-and-the-state.md` (under ``; pre-existing corpus file, not part of the 2026-07-27 fold)
- verified: web (composition 1871, publication 1882 by Cafiero & Reclus — Wikipedia, The Anarchist Library, marxists.org; early editions contain Cafiero/Reclus rewrites)
- note: primary text for "If God is, man is a slave", "the abdication of human reason and justice", "a master… remains none the less always a master", "if God really existed, it would be necessary to abolish him" — all four verified verbatim in the KB file (lines 140–162). Prefer this over the secondary treatments for any Bakunin quotation.

### batchelor-2012-a-secular-buddhism-jgb
- status: usable
- medium: text
- cite: Stephen Batchelor, "A Secular Buddhism," *Journal of Global Buddhism* 13 (2012): 87–107
- kb: `batchelor-higgins_a-secular-buddhism-and-its-analysis_2012-2017.md` (attributed summary, staged at workshops/DD/sources/ — not yet folded into corpus)
- verified: web (globalbuddhism.org, diamond OA)
- note: attributed summary note with verified page anchors, shared with the Higgins entry. The programmatic founding document of 'secular dharma': three senses of 'secular'; Four Noble Truths recast as four tasks; 'Buddhism 2.0' coined here with a 'touch of irony' (p. 91). ▲ Partisan witness the project is personally close to — flag per bias policy. Distinct work from the KB's Batchelor lecture transcripts.

### boehm-1999-hierarchy
- status: usable
- medium: text
- cite: Christopher Boehm, *Hierarchy in the Forest: The Evolution of Egalitarian Behavior* (Harvard University Press, 1999)
- kb: `Christopher-Boehm_Hierarchy-in-the-Forest_The-Evolution-of-Egalitarian-Behavior_HarvardUP-1999.md`, `04-chapter.md`
- verified: web (ISBN 978-0-674-39031-7)
- note: reverse dominance hierarchy; foragers as moral communities.

### bookchin-1997-reader
- status: usable
- medium: text
- cite: Murray Bookchin, *The Murray Bookchin Reader*, ed. Janet Biehl (Cassell, 1997)
- kb: `Murray-Bookchin_The-Murray-Bookchin-Reader_1999.md`
- verified: web (ISBN 978-0-304-33874-0 pbk / 978-0-304-33873-3 hbk; Cassell, London 1997 — Blackwell's, AbeBooks, WorldCat)
- note: hierarchy precedes class; gerontocracy/patriarchy/priestly guilds as first hierarchies; domination of nature projected from domination of human by human. ▲ Mixed authorship — Biehl's editorial synopses frame excerpts of Bookchin's own texts; any quotation must be attributed to the right voice (note 7.3 marks this in-text). KB filename says 1999 (Black Rose reprint); first edition Cassell 1997.

### bookchin-brecher-1973-post-affluence-anarchy
- status: usable
- medium: text
- cite: Murray Bookchin & Jeremy Brecher, "Post-Affluence Anarchy: A Dialogue" (1973) — Brecher's review of *Post-Scarcity Anarchism* (Ramparts Press, 1971), Bookchin's reply, and Brecher's rejoinder
- kb: `Murray-Bookchin+Jeremy-Brecher_Post-Affluence-Anarchy-a-Dialogue_1973.md`
- verified: partial (Ramparts Press 1971 for the book under review is stated in-file; the 1973 dialogue's venue is inferred from in-file internal evidence pointing to *Root & Branch* — Bookchin addresses "the *Root and Branch* people" directly; venue not independently web-confirmed)
- note: the post-scarcity thesis carried inside its own strongest rebuttal — Brecher: projections are "science fiction," and the youth post-scarcity lifestyle ran "on the basis of parental subsidy, educational advantage, personal connections, and other forms of privilege" ("simulate 'post-scarcity'"). ▲ The thesis-statement quoted in note 6.3 is Brecher's paraphrase of Bookchin, and Bookchin protests "selective quoting" in his reply — cite as dialogue, not as Bookchin's own text. A future pass should check against `Murray-Bookchin_The-Murray-Bookchin-Reader_1999.md` (in-corpus) for Bookchin's own wording. Quotations verified verbatim against the staging.text file (segs 1, 7, 22, 26, 36).

### bookchin-foreman-1991-defending-the-earth
- status: usable
- medium: text
- cite: Murray Bookchin & Dave Foreman, *Defending the Earth: A Dialogue Between Murray Bookchin and Dave Foreman*, ed. Steve Chase (Boston: South End Press, 1991), 147 pp. — transcript of the Learning Alliance public dialogue, New York, November 1989
- kb: `Murray-Bookchin+Dave-Foreman_Defending-the-Earth-a-Debate_1991.md`
- verified: web (South End Press 1991, ed. Steve Chase, ISBN 0-89608-383-7 / 0-89608-382-9, 147 pp. — confirmed via the *Bulletin of Science, Technology & Society* review record at https://journals.sagepub.com/doi/abs/10.1177/027046769301300212 and the Internet Archive scan https://archive.org/details/DefendingTheEarth_201809; full text also at https://theanarchistlibrary.org/library/murray-bookchin-and-dave-foreman-defending-the-earth-a-debate. All quotations additionally checked against staging.text.)
- note: the primary text for the social-ecology vs deep-ecology grounding dispute — whether the ecological crisis follows from human hierarchy or from human numbers and presence as such. Both principals speak at length in their own words; the KB file carries Foreman's own chapter ("Second Thoughts of an Eco-Warrior") including his retraction of the 1986 Ethiopia and immigration remarks, so the deep-ecology side can be quoted *from* rather than only quoted *against*. ▲ Framing caution: the volume is edited by a social ecologist (Steve Chase) and published by a left press; Chase's 30-page introduction argues the social-ecology case before either principal speaks. Treat the deep-ecology position here as reconstructed inside its opponent's book — Naess, Sessions, Devall and Fox are absent from the corpus. Cited in 8.1 [S20].

### brian-morris-1998-anthropology-and-anarchism
- status: usable
- medium: text
- cite: Brian Morris, "Anthropology and Anarchism: Learning from Stateless Societies," *Anarchy: A Journal of Desire Armed* #45, Vol. 16 No. 1 (Spring/Summer 1998); repr. in *Anthropology, Ecology, and Anarchism: A Brian Morris Reader* (PM Press, 2015)
- kb: `Brian-Morris_Anthropology-and-Anarchism_Learning-from-Stateless-Societies_1998.md`
- verified: web (Anarchist Library; PM Press reader contents)
- note: the "elective affinity" of anthropology and anarchism; used in 4.3 solely for the internal anarchist critique of primitivist projection (Zerzan's "illusory images of Green primitivism," via Bookchin and Ellen). Cited by DD notes 2.3, 4.3.

### brian-morris-2007-people-without-government
- status: usable
- medium: text
- cite: Brian Morris, "People Without Government," *Anarchy: A Journal of Desire Armed* #63 (Spring/Summer 2007); repr. in *Anthropology, Ecology, and Anarchism: A Brian Morris Reader* (Oakland: PM Press, 2015)
- kb: `Brian-Morris_People-Without-Government_2007.md`
- verified: web (Anarchist Library; PM Press reader contents list "People without Government (2007)")
- note: anarchist synthesis of Clastres, Silberbauer, Harris, Overing on stateless societies; procedural machinery of unwritten orders (consensus, chief-without-coercion, own-kill taboo); also corrects romanticism (!Kung not "peaceful paragons"; critique of ecofeminist matriarchy myth). Secondary synthesis of others' fieldwork. Cited by DD notes 2.3, 4.3.

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
- note: the named failure mode of a green ethic absorbed by the system it was meant to constrain — corporations "leapt aboard the green bandwagon"; "sustainable development" as sustaining capitalist growth; responsibility relocated onto individual consumers; "global management" and eco-technocracy; Sachs's line that "saving" the planet licenses "a new wave of state interventions." Short piece (4 segments), polemical register, no citations of its own beyond Bookchin, Kovel and Sachs. Cited in 8.1 [S21]. Cited by DD notes 6.3, 8.1.

### cicero-de-re-publica-de-legibus-barham
- status: usable
- medium: text
- cite: Marcus Tullius Cicero, *De Re Publica* (Book 3 'true law' fragment, via Lactantius) and *De Legibus* (Book 1), trans. Francis Barham, *The Political Works of M. T. Cicero* (London: Edmund Spettigue, 1841–42; Online Library of Liberty edition)
- kb: `cicero-aquinas_natural-law-primary-texts.md` (attributed summary, staged at workshops/DD/sources/ — not yet folded into corpus)
- verified: web (oll.libertyfund.org; public domain)
- note: attributed summary note with verified page anchors, shared with the Aquinas entry. ▲ Barham's rendering differs from the modern textbook wording ('There is a true law, a right reason, conformable to nature…') and interpolates 'our own conscience' absent from the Latin — quote Barham as Barham. Full text in DD local archive (scratch/sources/part1/, gitignored).

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
- note: the "seed beneath the snow" thesis — anarchy as "a description of a mode of human organisation, rooted in the experience of everyday life," discovered and extended rather than designed; also the negative evidence (defeat everywhere, "anarchism finally died when Franco's troops entered Barcelona in 1939"; Quail epigraph on growth/decline with popular self-activity). Ward himself concedes the book is open to the charge of "a selective gathering of anecdotal evidence" — advocacy, flagged as such. Cited by DD notes 2.4, 3.1, 8.3.

### crawford-2018-tan-malaka
- status: usable
- medium: text
- cite: Oliver Crawford, *The Political Thought of Tan Malaka* (PhD dissertation, Trinity College, University of Cambridge, 2018)
- kb: `Oliver-Crawford_The-Political-Thought-of-Tan-Malaka_2018.md`
- verified: web (University of Cambridge Apollo repository)
- note: scholarship *about* Tan Malaka, cited by note 7.7 as [S11] — *Madilog* (1943) as a mentality-reconstruction programme, its spread as circulated manuscript rather than by decree, the countermanding of the 1926–27 insurrection and the 1948 Madiun condemnation, plus the honesty items (the racialised *bangsa* theory, "Aslia" expansionism, the prophetic self-image). ▲ Crawford's characterisations are not Tan Malaka's own words. Entry added 2026-07-27 to close a gap left by the 2026-07-24 pass, which cited the file without registering it.

### emma-goldman-1897-marriage
- status: usable
- medium: text
- cite: Emma Goldman, "Marriage," *The Firebrand* (Portland, OR), 18 July 1897
- kb: `Emma-Goldman_Marriage_1897.md`
- verified: web (marxists.org Goldman archive; jwa.org — her first published writing on marriage)
- note: "If we want to accomplish Anarchy, we must first have free women" — women's freedom as precondition, not dividend, of the revolution.

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
- note: tells the suffrage movement of "the inadequacy of mere external gain as a means of freeing their sex" — her critique of the emancipation movement itself.

### emma-goldman-1914-marriage-and-love
- status: usable
- medium: text
- cite: Emma Goldman, "Marriage and Love," in *Anarchism and Other Essays* (Mother Earth Publishing Association, New York; 1st edn 1910, 2nd rev. edn 1911; corpus text dated 1914)
- kb: `Emma-Goldman_Marriage-and-Love_1914.md`
- verified: web (Wikipedia "Anarchism and Other Essays"; theanarchistlibrary.org full text)
- note: marriage as "an economic arrangement, an insurance pact"; sardonic critique of emancipation-as-wage-labour. Polemic — cite as her position.

### emma-goldman-1916-jealousy
- status: usable
- medium: text
- cite: Emma Goldman, "Jealousy: Causes and a Possible Cure" (lecture text, c. 1915–16; widely reprinted from the Emma Goldman Papers)
- kb: `Emma-Goldman_Jealousy-Causes-and-a-Possible-Cure.md`
- verified: unverified (first-publication venue not pinned down; internal evidence — "as I shall discuss variety and monogamy two weeks from tonight" — confirms a lecture script)
- note: grounds the anti-jealousy ethic in Morgan/Reclus "primitive" sexual-communism anthropology — dated science doing the work of scripture; attribute, never launder.

### emma-goldman-1923-louise-michel-hirschfeld
- status: usable
- medium: text
- cite: Emma Goldman, "Louise Michel" — refutation of Karl von Levetzow addressed to Dr. Magnus Hirschfeld, *Jahrbuch für sexuelle Zwischenstufen* 23 (1923), 70–92 (German title "Offener Brief an den Herausgeber der Jahrbücher über Louise Michel")
- kb: `Emma-Goldman_Louise-Michel_Letter-to-Magnus-Hirschfeld_1923.md`
- verified: web (magnus-hirschfeld.de Gedenken pages for Michel and Goldman; archive.org "emmagoldman1923"; theanarchistlibrary.org)
- note: ▲ read in period terms (Urning/Uranian, sexual "intermediates"). Explicit 1923 defence of homosexual rights AND refutation of the "masculine woman = invert" premise; her counter-case leans on re-certifying Michel's femininity — do not project modern categories, do not sanitise.

### emma-goldman-1923-my-disillusionment
- status: usable
- medium: text
- cite: Emma Goldman, *My Disillusionment in Russia* (Garden City, NY: Doubleday, Page & Co., 1923)
- kb: `Emma-Goldman_My-Disillusionment-in-Russia_1923.md`
- verified: web — Wikipedia and marxists.org Goldman archive confirm publisher, year, and the publisher's unauthorised truncation (last twelve chapters and Afterword cut; title changed from "My Two Years in Russia")
- note: primary supporter-turned-critic witness to the Soviet case; the prefaces carry the arc (defence tours 1917–18, Kronstadt as "the final wrench", departure December 1921) and the publication history in Goldman's own words. Cited in 7.7 as [S13]. Cited by DD notes 7.6, 7.7.

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
- note: deliberate counter-archive of women revolutionaries (Taratuta, Fanya Baron, Ratner, Kakhovskaia, Izmailovitch, Spiridonova); secular twin of the Therīgāthā's archival function. Also an anti-Bolshevik polemic — her framing throughout.

### emma-goldman-1931-living-my-life
- status: usable
- medium: text
- cite: Emma Goldman, *Living My Life* (Alfred A. Knopf, New York, 1931)
- kb: `Emma-Goldman_Living-My-Life_1931.md`
- verified: web (standard bibliography; theanarchistlibrary.org full text)
- note: autobiography, 1303 KB segments. Self-documented internal contradiction: the movement policing her dancing and her sex-question lectures (dance rebuke; Los Angeles comrades; Kropotkin exchange). Memoir written four decades after some events — treat dialogue as her reconstruction. Cited by DD notes 2.5, 6.4.

### emma-goldman-1933-has-my-life-been-worth-while
- status: usable
- medium: text
- cite: Emma Goldman, "Has My Life Been Worth While?", 30 January 1933
- kb: `Emma-Goldman_Has-My-Life-Been-Worth-While_1933.md`
- verified: unverified
- note: end-of-life retrospective in a frankly religious register — anarchism as "my inspiration and my highest goal", its "light... diminished".

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
- note: pre-Michels prediction of movement bureaucratisation: syndicalism "cannot remain stationary" — either towards its ideal or into "a bureaucratic character… a factor in social conservation"; the "self-satisfied bureaucracy which will absorb the most intelligent and active elements among the proletariat." Cited in 7.1 [S14].

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
- note: the clean principles-under-war-pressure case: rejects "revise our formulas" in favour of "forgotten and betrayed"; deeper national feeling is "one more reason for intensifying, not abandoning" the principle. Pairs with kropotkin-1916-manifesto-of-the-sixteen as the two sides of the split. Cited in 7.1 [S15].

### errico-malatesta-1919-fabbri-letter
- status: usable
- medium: text
- cite: Errico Malatesta, "On the Dictatorship of the Proletariat: A Prophetic Letter to Luigi Fabbri" (letter, London, 30 July 1919; English trans. pub. 2005)
- kb: `Errico-Malatesta_On-the-Dictatorship-of-the-Proletariat_A-Prophetic-Letter-to-Luigi-Fabbri_2005.md`
- verified: web — full text at The Anarchist Library and marxists.org (Malatesta archive), both dating the letter London, 30 July 1919
- note: contemporaneous anarchist *prediction* of the Bolshevik dictatorship's outcome, made while explicitly declining to judge the news from Russia — evidence of foreseeability from design, not hindsight. ▲ The corpus also holds the same letter in an earlier English translation (`Errico-Malatesta_The-Dictatorship-of-the-Proletariat-and-Anarchy_1919.md`): one witness, two translations — do not register or count as an independent source. Cited in 7.7 as [S12]. Cited by DD notes 7.6, 7.7.

### errico-malatesta-1920-an-anarchist-programme
- status: usable
- medium: text
- cite: Errico Malatesta (draft), "An Anarchist Programme", adopted by the Unione Anarchica Italiana, Bologna congress, 1920
- kb: `Errico-Malatesta_An-Anarchist-Programme_1920.md`
- verified: web (The Anarchist Library / marxists.org confirm the 1920 UAI Bologna congress adoption)
- note: "equal liberty of everybody" as the sole limit on freedom; ideal achievable only "with the free consent of all". Used in 3.1 as [S12]. Cited by DD notes 2.4, 3.1.

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

### friedrich-nietzsche-1882-the-gay-science
- status: usable
- medium: text
- cite: Friedrich Nietzsche, *The Gay Science* (1882; Book V added 1887). Unattributed English translation; internal evidence (editorial note naming Petre/Cohn for the verse only, "Joyful Wisdom" framing) suggests the Oscar Levy *Complete Works* edition (Thomas Common, 1910), unverified.
- kb: `Friedrich-Nietzsche_The-Gay-Science_1882.md`
- verified: unverified
- note: translator unnamed in file — cite by § only, paraphrase only, no translation-sensitive word choices. Used in 3.4 for §116 (herd-instinct, community-relative moralities), §143 (polytheism as prototype of plural norms), §345 (both consensus→universalism and disagreement→relativism inferences dismissed). ▲ §345 also used by note 3.3 for the grounding question — same section, different claims. Cited by DD notes 3.3, 3.4.

### friedrich-nietzsche-1883-thus-spoke-zarathustra
- status: usable
- medium: text
- cite: Friedrich Nietzsche, *Thus Spoke Zarathustra: A Book for All and None* (1883–1891). Unattributed English translation; archaising register ("hangeth", "valueth") matches the Levy-series Thomas Common rendering, unverified.
- kb: `Friedrich-Nietzsche_Thus-Spoke-Zarathustra_A-Book-for-All-and-None_1883.md`
- verified: unverified
- note: translator unnamed in file — cite by part and chapter title, paraphrase only. Used in 3.4 for Part I, "The Thousand and One Goals" (plural created tables of value; humanity's one goal still lacking). File contains the chapter twice (lines ~1212 and ~7824 — apparent duplicate text block within the file).

### friedrich-nietzsche-1886-beyond-good-and-evil
- status: usable
- medium: text
- cite: Friedrich Nietzsche, *Beyond Good and Evil: Prelude to a Philosophy of the Future* [*Jenseits von Gut und Böse*] (1886)
- kb: `Friedrich-Nietzsche_Beyond-Good-and-Evil_Prelude-to-a-Philosophy-of-the-Future_1886.md`
- verified: unverified
- note: translator unnamed; full-capital emphasis matches Helen Zimmern (Levy edition, Project Gutenberg circulation) — indication, not verification. Cited by § only (§186: the foundation-hunt takes morality as "given"; "the problem of morality itself has been omitted"). Cited by DD notes 3.3, 3.4.

### friedrich-nietzsche-1887-genealogy-of-morals
- status: usable
- medium: text
- cite: Friedrich Nietzsche, *The Genealogy of Morals: A Polemic* (1887). Unattributed English translation; register consistent with the Levy-series Horace B. Samuel rendering (1913), unverified.
- kb: `Friedrich-Nietzsche_The-Genealogy-of-Morals_A-Polemic_1887.md`
- verified: unverified
- note: translator unnamed in file — cite by essay and § only, paraphrase only. Used in 3.4 for Preface §6 (critique of the value of moral values; power-and-splendour-of-the-type standard) and the First Essay's concluding note (rank-order of values as the philosopher's task; majority-good denied intrinsic superiority). ▲ Preface §6 also used by note 3.3 — same section, different claims. Cited by DD notes 3.3, 3.4.

### friedrich-nietzsche-1888-twilight-of-the-idols
- status: usable
- medium: text
- cite: Friedrich Nietzsche, *Twilight of the Idols* [*Götzen-Dämmerung*] (written 1888, pub. 1889)
- kb: `Friedrich-Nietzsche_Twilight-of-the-Idols_1895.md`
- verified: unverified
- note: KB filename misdates the work (1895); frontmatter `year: 1888` is correct — do not reproduce 1895 in citations. Translator unnamed; section titles and phrasing ("Skirmishes of an Untimely Man", "prankishness", the "History of an Error" subtitle) match Walter Kaufmann's 1954 *Portable Nietzsche* rendering rather than the Levy edition (Ludovici's chapter is titled "Skirmishes in a War with the Age") — unverified, and a possible rights question worth the coordinator's attention. Cited by section number only ("Skirmishes" §5, §37; "How the 'True World' Finally Became a Fable"). Cited by DD notes 3.3, 3.4.

### gallie-1956-essentially-contested-concepts
- status: usable
- medium: text-ocr
- cite: W. B. Gallie, "Essentially Contested Concepts," *Proceedings of the Aristotelian Society* 56 (1956): 167–198
- kb: `wb-gallie_essentially-contested-concepts_1956.md` (attributed summary, staged at workshops/DD/sources/ — not yet folded into corpus)
- verified: web (JSTOR 4544562; read in full from Columbia Law-hosted scan)
- note: attributed summary note with verified page anchors. Replaces the abstract-page citation in notes 1.3 (S16) and 3.4 (S8). ▲ Conditions VI–VII (common exemplar; competition develops its achievement) are what separate essential contestedness from radical confusion — DD currently invokes only I–V, and plural dharmas may fail VI. Full text in DD local archive (scratch/sources/part1/, gitignored).

### geertz-1973-religion-as-a-cultural-system
- status: usable
- medium: text-ocr
- cite: Clifford Geertz, "Religion as a Cultural System," in *The Interpretation of Cultures* (New York: Basic Books, 1973), 87–125
- kb: `clifford-geertz_religion-as-a-cultural-system_1973.md` (attributed summary, staged at workshops/DD/sources/ — not yet folded into corpus)
- verified: web (ISBN 978-0-465-09719-7); quotations verified against the full book scan
- note: attributed summary note with verified page anchors. The definition Asad attacks, and the position DD's four-feature test structurally occupies. Geertz himself disclaims essence-hunting ('it is notorious that definitions establish nothing,' p. 90). Distinct work from the KB's *Religion of Java*. Full text in DD local archive (scratch/sources/part1/, gitignored); community upload, reading copy only.

### gellner-curry-cook-alfano-venkatesan-2020-gdat-debate
- status: usable
- medium: text
- cite: David N. Gellner (ed.), Oliver Scott Curry, Joanna Cook, Mark Alfano & Soumhya Venkatesan, "Debate: Morality is fundamentally an evolved solution to problems of social co-operation," *Journal of the Royal Anthropological Institute* 26:2 (2020): 415–427
- kb: `gellner-curry-cook-alfano-venkatesan_gdat-debate-morality-as-cooperation_2020.md` (attributed summary, staged at workshops/DD/sources/ — not yet folded into corpus)
- verified: web (Oxford ORA deposit, CC BY-NC)
- note: attributed summary note with verified page anchors. The formal GDAT motion: Curry proposes, Alfano seconds (needs/capabilities grounding), Cook and Venkatesan oppose. Attribute by speaker — the methodological objections DD needs are Venkatesan's (p. 422). Vote swing 13–6 → 4–24, unreliable per the chair (p. 415). Curry Templeton-funded (TWCF0164, p. 426).

### gethin-2004-he-who-sees-dhamma
- status: usable
- medium: text-ocr
- cite: Rupert Gethin, "He Who Sees Dhamma Sees Dhammas: Dhamma in Early Buddhism," *Journal of Indian Philosophy* 32 (2004): 513–542; repr. in Olivelle (ed.), *Dharma* (Delhi: MLBD, 2009), 91–120
- kb: `rupert-gethin_he-who-sees-dhamma-sees-dhammas_2004.md` (attributed summary, staged at workshops/DD/sources/ — not yet folded into corpus)
- verified: web (DOI 10.1007/s10781-004-8633-6 for the JIP original; read from the MLBD reprint scan)
- note: attributed summary note with verified page anchors (MLBD pagination; +422 for JIP). Argues the senses of dhamma cohere genealogically around 'support/maintain' — against homonymy, cutting against Part 1's rope-not-thread rhetoric for the Buddhist case while vindicating 'that which holds'. ▲ Same incomplete, poor-OCR volume scan as the Olivelle entry; unreliable for verbatim transliterated Pali.

### glenn-roberts-2020-the-dharma-of-dog
- status: usable
- medium: text
- cite: Glenn Roberts, "Dog Dharma: The Dharma of Dog," talk for the final study retreat of the Secular Dharma Course 2018–19, Bodhi College (delivered Nov 2019; finalised Feb 2020)
- kb: `Glenn-Roberts_The-Dharma-of-Dog.md` (duplicate content: `Glenn-Roberts_Bodhi-Talk-2020-02-08.md`)
- verified: file (unpublished; no external record to check)
- note: practitioner itinerary (post-Christian → Triratna → MBSR → Bodhi College); the "3 jewels" of dog training (trainer, instruction, "comradely community of other dog owners") as spontaneous secular restatement of the practice–ethics–community bundle; "intriguing parallels with what I've previously known as the Path to Recovery". Same course/community milieu as the item above — weaker form of the same circularity caveat; specimen evidence only. The two KB files are the same talk; cite once.

### glenn-roberts-2023-on-the-dharma-of-dharmas
- status: usable
- medium: text
- cite: Glenn Roberts, "On the Dharma of Dharmas," talk for John's group, 20 November 2023
- kb: `Glenn-Roberts_On-the-dharma-of-dharmas.md`
- verified: file (unpublished; no external record to check)
- note: the presentist strategy in practice — dharmas (plural) as the mind's maps/models; "dark dharmas"; "the Dharmic value of a dharma teaching" defined as "it's helpfulness in living our lives" (the testimony success-criterion note 6.1 flags as insufficient). Same milieu caveat; specimen evidence only.

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
- note: ▲ CIRCULAR with respect to this project — it is a direct response to the project author's own presentation. May be cited ONLY as a primary specimen of how the secular-dharma community uses and disputes the word (vocabulary dispute, -ism cost analysis, "healthful wisdom" naturalisation proposal), NEVER as independent support for the author's thesis. Note 6.1 states the circularity in Findings and Tensions wherever it is used.

### glenn-roberts-dog-dharma-notes
- status: barred
- barred: ephemera
- medium: text
- kb: `Glenn-Roberts_Dog-Dharma-Notes.md`
- verified: unverified
- note: private working notes in letter form ("Dear Stephen"); superseded by the finished talk in `Glenn-Roberts_The-Dharma-of-Dog.md` and `Glenn-Roberts_Bodhi-Talk-2020-02-08.md`. Cite the finished piece, not the notes.

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

### graeber-wengrow-2021-dawn
- status: usable
- medium: text
- cite: David Graeber & David Wengrow, *The Dawn of Everything: A New History of Humanity* (Farrar, Straus and Giroux, 2021)
- kb: `Dawn_of_Everything-David_Graeber.md`, `Dawn-of-Everything.md`
- verified: web (ISBN 978-0-374-15735-7)
- note: disputes a single "original condition"; egalitarian-forager baseline not uniform.

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
- note: the dérive as attention-environment practice: "drop their relations, their work and leisure activities, and all their other usual motives for movement and action." Cited in 6.2 as a structural ancestor of digital-declutter / re-grounded-attention practices — comparison marked [A], no influence claim.

### guy-debord-1957-report-on-the-construction-of-situations
- status: usable
- medium: text
- cite: Guy Debord, "Report on the Construction of Situations and on the International Situationist Tendency's Conditions of Organization and Action" (July 1957); English trans. in Ken Knabb (ed.), *Situationist International Anthology* (Bureau of Public Secrets)
- kb: `Guy-Debord_Report-on-the-Construction-of-Situations_And-on-the-International-Situationist-Tendencys-Conditions-of-Organization-and-Action_1957.md`
- verified: unverified (translation provenance inferred from house style and the Knabb footnote apparatus in the companion 1956 files; not web-checked)
- note: founding SI manifesto. Source for the recuperation mechanism ("trivialized and sterilized... safely spectacularized"), the "battle of leisure" / "televised imbecilities" passage, and constructed situations (spectators → "livers").

### guy-debord-1967-society-of-the-spectacle
- status: usable
- medium: text
- cite: Guy Debord, *The Society of the Spectacle* (Paris: Buchet-Chastel, 1967); English trans. Ken Knabb (2002; book edn London: Rebel Press, 2005)
- kb: `guy-debord_the-society-of-the-spectacle.md`
- verified: file (translator identified from the file's own translator's note (Ken Knabb, dated Feb 2002, noting the Rebel Press 2005 edition and the prior Nicholson-Smith/Zone 1994 and Perlman-Supak/Black & Red 1977 translations); Knabb's translation is hosted at bopsecrets.org (Bureau of Public Secrets). ISBN not web-checked.)
- note: primary polemical text, 221 numbered theses. Cite by thesis number. Theses used in 6.2: 1, 4, 6, 12, 59. Establishes that the "external industrial adversary" of the attention economy was diagnosed in 1967 — pre-web, pre-smartphone.

### guy-debord-1988-comments-on-the-society-of-the-spectacle
- status: usable
- medium: text
- cite: Guy Debord, *Commentaires sur la société du spectacle* (Paris: Éditions Gérard Lebovici, 1988); standard English trans. Malcolm Imrie (London: Verso, 1990, ISBN 9780860915201) — but the KB file carries a DIFFERENT, unattributed translation
- kb: `Guy-Debord_Comments-on-the-Society-of-the-Spectacle_1988.md`
- verified: web (Verso publisher page and AbeBooks confirm Imrie/Verso 1990, ISBN 9780860915201). The KB file names no translator; its phrasing ("the integrated spectacular", "forgeries without reply") does not match Imrie, so quotations from the file cannot be attributed to any published translation.
- note: Debord's twenty-year self-audit — the "integrated spectacle", the five features, the three-days rule, the death of the agora, the image-flow that leaves no time for reflection. Cite by section number (§I–§XXXIII), prefer paraphrase over quotation because the translation is unattributed; flagged in the note's Tensions.

### guy-debord-gil-wolman-1956-users-guide-to-detournement
- status: usable
- medium: text
- cite: Guy Debord and Gil J. Wolman, "A User's Guide to Détournement" (*Les Lèvres Nues* #8, May 1956); English trans. Ken Knabb, *Situationist International Anthology*
- kb: `Guy-Debord+Gil-J-Wolman_A-Users-Guide-to-Détournement_1956.md`
- verified: file (footnote 1 is Knabb's translator note on anglicising "détournement"); edition not web-checked
- note: manifesto for the partisan re-use of the dominant culture's material against it; ancestor of culture jamming. Also contains the laws of détournement.

### halbfass-1988-india-and-europe-ch17
- status: usable
- medium: text-ocr
- cite: Wilhelm Halbfass, "Dharma in the Self-Understanding of Traditional Hinduism," ch. 17 of *India and Europe: An Essay in Understanding* (Albany: SUNY Press, 1988), 310–333
- kb: `wilhelm-halbfass_dharma-in-the-self-understanding-of-traditional-hinduism_1988.md` (attributed summary, staged at workshops/DD/sources/ — not yet folded into corpus)
- verified: web (SUNY ISBN 978-0-88706-795-8; scan is the MLBD Indian ed., Delhi 1990, ISBN 81-208-0736-7, preserving SUNY pagination)
- note: attributed summary note with verified page anchors. ▲ Two load-bearing findings: ṛta→dharma linkages 'casual and rare' (pp. 314–15; close-connection claims a Neo-Hindu postulate), and classical dharma emphatically particularist — Indocentric, Veda-indexed, birth-restricted; universalist dharma is the modern reinterpretation (ch. 18). Presses directly on Part 1's two-storey design. Full text in DD local archive (scratch/sources/part1/, gitignored); community upload, reading copy only.

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

### james-russell-lowell-1865-thoreau
- status: usable
- medium: text
- cite: James Russell Lowell, "Thoreau," *North American Review* (October 1865); repr. in *My Study Windows* (Boston: James R. Osgood, 1871)
- kb: — (external; no KB file)
- verified: web (Walden Woods Project Lowell page carries the "state's evidence" passage, sourcing it to the 1871 *My Study Windows* reprint; the October 1865 *North American Review* first publication is attested by secondary accounts of the Lowell–Thoreau feud — the American Periodicals literature dates the "vitriolic analysis" to 1865)
- note: the founding scholarly critique of Walden's dependence — "He squatted on another man's land; he borrows an axe; his boards… all turn state's evidence against him as an accomplice in the sin of that artificial civilization." The scholarly ancestor of the popular "he took his laundry home" jibe; use this, not the jibe.

### karunadasa-1996-dhamma-theory
- status: usable
- medium: text
- cite: Y. Karunadasa, *The Dhamma Theory: Philosophical Cornerstone of the Abhidhamma*, Wheel Publication 412/413 (Kandy: Buddhist Publication Society, 1996)
- kb: `y-karunadasa_the-dhamma-theory_1996.md` (attributed summary, staged at workshops/DD/sources/ — not yet folded into corpus)
- verified: web (bps.lk; explicit free-distribution licence)
- note: attributed summary note with verified page anchors. ▲ Part 1's 'atoms of mind and matter' does not survive: the discrete-entity reading is 'certainly not admissible' (p. 14); dhammas 'cannot be separated from one another like particles of sand' (p. 32) — events, not substances; the tradition legislated against reification. 'Momentary flickers' survives. PDF safe to archive.

### kropotkin-1916-manifesto-of-the-sixteen
- status: usable
- medium: text
- cite: "The Manifesto of the Sixteen" (28 February 1916), signed Jean Grave, Pierre Kropotkine et al. (fifteen initial signatories despite the name)
- kb: `Pëtr-Kropotkin_The-Manifesto-of-the-Sixteen_1916.md`
- verified: web (https://www.marxists.org/reference/archive/kropotkin-peter/1916/sixteen.htm — date, "ranged on the side of the resistance" and signatory list incl. Grave and Kropotkine confirmed)
- note: the pro-war minority's own declaration — the other side of the Malatesta 1914 dispute, in its own words. Cited in 7.1 [S16].

### lichtheim-1992-maat-in-egyptian-autobiographies
- status: usable
- medium: text-ocr
- cite: Miriam Lichtheim, *Maat in Egyptian Autobiographies and Related Studies*, Orbis Biblicus et Orientalis 120 (Fribourg: Universitätsverlag / Göttingen: Vandenhoeck & Ruprecht, 1992)
- kb: `miriam-lichtheim_maat-in-egyptian-autobiographies_1992.md` (attributed summary, staged at workshops/DD/sources/ — not yet folded into corpus)
- verified: web (official OA deposit, Zurich Open Repository; ISBN 3-7278-0846-0)
- note: attributed summary note with verified page anchors. Maat as lived practice-defined ethic (veracity, fairness, beneficence) — cosmic in principle but bottom-weighted ('the Pyramid Texts supply the heavenly dimension of Maat, but just barely,' p. 16); explicitly rejects Assmann's theologised top-down fusion, and her Assmann quotations are DD's only window into that unobtainable book. Replaces the EBSCO starter in note 1.4.

### malatesta-makhno-1927-about-the-platform
- status: usable
- medium: text
- cite: Errico Malatesta & Nestor Makhno, "About the Platform" — exchange over the *Organisational Platform of the General Union of Anarchists*: Malatesta critique (*Il Risveglio*, Geneva, Oct 1927), Makhno letter (1928), Malatesta reply (*Il Risveglio*, Dec 1929), Makhno second letter (*Le Libertaire*, 9 Aug 1930; trans. Nestor McNab)
- kb: `Errico-Malatesta+Nestor-Makhno_About-the-Platform_1927.md`
- verified: web (Malatesta's 1927 component at https://theanarchistlibrary.org/library/errico-malatesta-a-project-of-anarchist-organisation — venue and both load-bearing quotations confirmed; the combined-exchange URL guesses 404'd, so the three later letters rest on the kb file)
- note: the ossification debate in real time, both sides arguing: "a government and a church" / "better that it should die" (Malatesta) vs without permanent organisation the movement "gets weaker" (Makhno). The documented instance for the form-capture failure mode. Cited in 7.1 [S17]. Cited by DD notes 2.4, 7.1, 7.6.

### mckinnon-2002-sociological-definitions
- status: usable
- medium: text
- cite: Andrew M. McKinnon, "Sociological Definitions, Language Games and the ‘Essence’ of Religion," *Method and Theory in the Study of Religion* 14:1 (2002): 61–83
- kb: `andrew-mckinnon_sociological-definitions-language-games-essence-of-religion_2002.md` (attributed summary, staged at workshops/DD/sources/ — not yet folded into corpus)
- verified: web (DOI 10.1163/157006802760198776; green-OA author manuscript, Aberdeen AURA)
- note: attributed summary note with verified page anchors (▲ anchored to manuscript pages — convert to journal pagination when citing). Concedes the genealogy, keeps the category via Wittgenstein §68 and the usefulness criterion. ▲ His defence requires the term to circulate in ordinary language — 'religion' does, DD's expanded 'dharma' does not; DD must either restrict the strong claim or argue the usage is spreading.

### michels-1911-political-parties
- status: usable
- medium: text
- cite: Robert Michels, *Political Parties: A Sociological Study of the Oligarchical Tendencies of Modern Democracy* (1911; English trans. Eden & Cedar Paul, 1915)
- kb: —
- verified: unverified (standard reference; note links https://en.wikipedia.org/wiki/Iron_law_of_oligarchy; no direct quotation used)
- note: external, not in corpus. The "iron law of oligarchy" — canonical scholarly statement of the mode Malatesta 1909 predicted; cited by paraphrase only. Cited in 7.1 [S19].

### morris-1993-bakunin-historical-materialism
- status: usable
- medium: text
- cite: Brian Morris, "Bakunin, Historical Materialism, and Social Philosophy" (1993; associated with Morris's *Bakunin: The Philosophy of Freedom*, Black Rose Books, 1993)
- kb: `Brian-Morris_Bakunin-Historical-Materialism-and-Social-Philosophy_1993.md`
- verified: unverified (1993 date from file frontmatter; Black Rose monograph link plausible but not confirmed this pass)
- note: secondary treatment used for Bakunin's *ambivalence* on religion ("the first gleam of human truth", a possible "historic necessity", not an "absolute evil"; church-as-pub consolation) — the nuance the slogans omit. Morris's "no refutation has ever been forthcoming" aside is partisan, flagged in 7.3's Tensions.

### morris-tolstoy-and-anarchism
- status: usable
- medium: text
- cite: Brian Morris, "Tolstoy and Anarchism" (essay/review of the Green Classics reissue of *What Then Must We Do?*; undated, early 1990s)
- kb: `Brian-Morris_Tolstoy-and-Anarchism.md`
- verified: unverified (original venue not established this pass — likely *Freedom* or an anthologised Morris essay; Morris's Tolstoy essays are collected in his PM Press reader)
- note: documentary source for Tolstoy's religious anarchism — *The Kingdom of God Is Within You* (1894), the *Government is Violence* anthology (ed. Stephens, 1991), the "our caste"/"get off their backs" argument of *What Then Must We Do?*, and Tolstoy's pre-1917 prediction that Jacobin revolution leads to new oppression. ▲ Advocacy essay (closes: "there really is no alternative to the kind of anarchism he espoused"); use documentarily.

### murray-bookchin-1969-anarchy-and-organization
- status: usable
- medium: text
- cite: Murray Bookchin, "Anarchy and Organization: A Letter to the Left" (1969), written in reply to Huey Newton, "In Defense of Self Defense", *The Black Panther*, 16 November 1968
- kb: `Murray-Bookchin_Anarchy-and-Organization-a-Letter-to-the-Left_1969.md`
- verified: partial (the Newton reply provenance is stated in the kb file's own headnote; not independently checked in this pass — the 7.1 agent also used this file)
- note: ▲ already used by note 7.1. 2.4 quotes a different clause of the same sentence: the self-dissolution design criterion, that a revolutionary organisation must be "structured to dissolve into the popular forms created by the revolution once its function as a catalyst is completed", otherwise it "becomes a vehicle for carrying the forms of the past into the revolution". Cited by DD notes 2.4, 7.1.

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
- note: "the germ of treachery existed in them from birth"; Bolshevik centralisation as "a counterrevolution of its own against the very social forces it professed to represent"; "the forms replaced the content… means replaced ends." ▲ Partisan historiography of the Russian Revolution (Kronstadt, factory committees) — cite as the movement's self-diagnosis, not as settled history. Cited in 7.1 [S13].

### murray-bookchin-1978-utopia-not-futurism
- status: usable
- medium: text
- cite: Murray Bookchin, "Utopia, Not Futurism: Why Doing the Impossible is the Most Rational Thing We Can Do," lecture at the Toward Tomorrow Fair, Amherst MA, 24 August 1978; transcript published by Uneven Earth, October 2019, by permission of the Bookchin Trust
- kb: `Murray-Bookchin_Utopia-Not-Futurism_Why-Doing-the-Impossible-is-the-Most-Rational-Thing-We-Can-Do_2019.md`
- verified: web (unevenearth.org/2019/10/bookchin_doing_the_impossible; mirrored at The Anarchist Library and anarchistfederation.net). Note the transcript is "edited lightly for flow, brevity, and grammar" per the publisher.
- note: the designed pole of the discover/design question ("Be practical, do the impossible"); the 1978 atomisation diagnosis anticipating the loneliness literature; "People change unconsciously before they change consciously."

### murray-bookchin-2008-free-cities
- status: usable
- medium: text
- cite: Murray Bookchin, *Free Cities: Communalism and the Left*, ed. Eirik Eiglad (Pluto Press, ISBN 978-0-7453-2818-8; editor's preface dated 2008, trade publication 2011)
- kb: `Murray-Bookchin_Free-Cities_Communalism-and-the-Left_2008.md`
- verified: web (ISBN 9780745328188 via AbeBooks/Amazon; manuscript held at NYU Tamiment, finding aid TAM 538)
- note: libertarian municipalism as deliberate institution-building; documents Bookchin's late break with anarchism ("defending anarchism against anarchists") and his founding of communalism. CAVEAT: posthumous anthology assembled by the editor from "letters, lectures, unfinished drafts, and manuscripts," with acknowledged consolidation and revision — quotations carry the editor's hand and should be flagged as editorially mediated.

### murray-bookchin-2015-the-next-revolution
- status: usable
- medium: text
- cite: Murray Bookchin, *The Next Revolution: Popular Assemblies and the Promise of Direct Democracy*, ed. Debbie Bookchin & Blair Taylor, foreword by Ursula K. Le Guin (London: Verso, 2015)
- kb: `Murray-Bookchin_The-Next-Revolution_Popular-Assemblies-and-the-Promise-of-Direct-Democracy_2015.md`
- verified: web (Verso 2015, ISBN 978-1-78168-581-5, editors and Le Guin foreword confirmed at https://www.versobooks.com/products/34-the-next-revolution and https://openlibrary.org/books/OL31035172M/The_next_revolution)
- note: posthumous collection of the libertarian-municipalism / communalism essays. Used in 8.1 for confederalism as an explicitly anti-parochial coordination architecture: confederation "counteract[s] the tendency of decentralized communities to drift toward exclusivity and parochialism"; policymaking reserved to face-to-face assemblies while confederal councils are administrative with mandated, recallable delegates. ▲ Programmatic advocacy, not evidence — no case is made here that the design has been tested above municipal scale. Cited in 8.1 [S22]. Cited by DD notes 3.1, 7.3, 8.1.

### new-inquiry-distracted-by-attention-citton-review
- status: usable
- medium: text
- cite: "Distracted by Attention" (review of Yves Citton, *The Ecology of Attention*), *The New Inquiry*. https://thenewinquiry.com/distracted-by-attention/
- kb: (none — external web source, folded into the [S10] gloss)
- verified: web (search-result excerpt confirms the review discusses Citton's engagement with Debord's motto of the spectacle; full text not fetched)
- note: supports the single lineage claim that Citton's attention-ecology takes up Debord's thesis-12 motto ("What appears is good; what is good appears"). Author name not confirmed, so cited by title only.

### olivelle-2004-semantic-history-of-dharma
- status: usable
- medium: text-ocr
- cite: Patrick Olivelle, "The Semantic History of Dharma: The Middle and Late Vedic Periods," *Journal of Indian Philosophy* 32 (2004): 491–511; repr. in Olivelle (ed.), *Dharma: Studies in its Semantic, Cultural and Religious History* (Delhi: MLBD, 2009), 69–89
- kb: `patrick-olivelle_the-semantic-history-of-dharma_2004.md` (attributed summary, staged at workshops/DD/sources/ — not yet folded into corpus)
- verified: web (DOI 10.1007/s10781-004-8629-2 for the JIP original; read from the MLBD reprint scan, which is incomplete — Horsch and Brereton absent)
- note: attributed summary note with verified page anchors (MLBD pagination; +422 for JIP). ▲ Breaks Part 1's smooth-broadening narrative: dharma marginal and *narrowing* (royal/juridical, Varuṇa and the king) across middle/late Vedic corpora; centrality arrives via Buddhist appropriation and Aśoka, with Dharmaśāstra as Brahmanical response (hypothesis, marked as such). ▲ Scan OCR is poor — dehyphenate before quote-checking; see note's OCR-hazard section.

### parker-1993-basic-bakunin
- status: usable
- medium: text
- cite: Colin Parker, *Basic Bakunin* (Anarchist Communist Federation, 1993; South African ed. Zabalaza Books, 2004, intro. Lucien van der Walt; 2nd SA ed. 2019)
- kb: `Colin-Parker_Basic-Bakunin_1993.md`
- verified: web (The Anarchist Library; zabalazabooks.net; van der Walt's 2004 SA introduction confirmed at lucienvanderwalt.com)
- note: movement primer, partisan register — use only for Bakunin's documented arguments/predictions ("a new class of experts, scientists and professional politicians" legitimated by "the claim to acting in accordance with scientific laws"), never for its own verdicts. Cited by DD notes 7.3, 7.6.

### pokorny-lrc-pie-dher-to-hold-support
- status: usable
- medium: text
- cite: Linguistics Research Center (UT Austin), *Indo-European Lexicon*, s.v. Pokorny etymon *2. dher-, dherə-* 'to hold, support' (master entry 0399), adapting Julius Pokorny, *Indogermanisches etymologisches Wörterbuch* (Bern: Francke, 1959)
- kb: `pokorny-lrc_pie-dher-to-hold-support.md` (attributed summary, staged at workshops/DD/sources/ — not yet folded into corpus)
- verified: web (https://lrc.la.utexas.edu/lex/master/0399)
- note: attributed summary note with verified page anchors. Replaces Wiktionary for the √dhṛ → PIE → *firmus* → *firm* spine in note 1.1 (S7); adds *throne* (Gk. *thronos*) and *Darius* ('upholding the good') as English-visible cognates. ▲ Adjacent entry 0398 is the homophonous '1. dher-' 'dirt, dregs' — do not confuse. Cite for root and reflexes only, never for the meaning of *dharma*; Mayrhofer EWAia remains the citation of record.

### queloz-cueni-2019-genealogical-debunking
- status: usable
- medium: text
- cite: Matthieu Queloz & Damian Cueni, "Nietzsche as a Critic of Genealogical Debunking: Making Room for Naturalism without Subversion," *The Monist* 102:3 (2019), 277–297. doi:10.1093/monist/onz010
- kb: (none — external)
- verified: web (Oxford Academic listing and DOI confirmed 2026-07-27; philarchive preprint exists)
- note: the scholarly anchor for the genetic-fallacy counter-argument — genealogical origins subvert only in conjunction with a further evaluative premise; engages GS §345 directly. Cited via abstract and public preprint, not full journal text (abstract-only access level).

### riesebrodt-2010-promise-of-salvation
- status: usable
- medium: text
- cite: Martin Riesebrodt, *The Promise of Salvation: A Theory of Religion*, trans. Steven Rendall (Chicago: University of Chicago Press, 2010)
- kb: `martin-riesebrodt_the-promise-of-salvation_2010.md` (attributed summary, staged at workshops/DD/sources/ — not yet folded into corpus)
- verified: web (ISBN 978-0-226-71391-5)
- note: attributed summary note with verified page anchors. The closest structural precedent for DD: answers the constructionist objection, then defines religion substantively (interventionist practices toward superhuman powers). ▲ The fork this creates for DD: his universality is empirical and falsifiable *because* the definition is substantive — and the same criterion ejects secular frameworks ('morality does not require religion,' pp. 183–84). DD cannot borrow the universality while keeping non-privileging. Full text in DD local archive (scratch/sources/part1/, gitignored); community upload.

### roberts-wolfson-2004-rediscovery-of-recovery
- status: usable
- medium: text
- cite: Glenn Roberts & Paul Wolfson, "The rediscovery of recovery: open to all," *Advances in Psychiatric Treatment* (2004) 10:37–49
- kb: `Glenn-Roberts_APT-Article.md`
- verified: web (Cambridge Core article page for *Advances in Psychiatric Treatment* vol. 10, "The rediscovery of recovery: open to all", Roberts & Wolfson; reported as the journal's most frequently cited article)
- note: the one milieu-independent Roberts document — predates his secular-dharma involvement and contains zero Buddhist/dharmic/mindfulness vocabulary (grep-checked). Documents psychiatry's redefinition of "recovery" from cure to living well with enduring symptoms (Anthony 1993; Deegan), and the testimony-vs-operationalisation dispute (Liberman & Kopelowicz) — an independent convergence on the dharma-shaped form, and a precedent for 7.4's measurement problem.

### rosch-mervis-1975-family-resemblances
- status: usable
- medium: text-ocr
- cite: Eleanor Rosch & Carolyn B. Mervis, "Family Resemblances: Studies in the Internal Structure of Categories," *Cognitive Psychology* 7 (1975): 573–605
- kb: `rosch-mervis_family-resemblances_1975.md` (attributed summary, staged at workshops/DD/sources/ — not yet folded into corpus)
- verified: web (DOI 10.1016/0010-0285(75)90024-9)
- note: attributed summary note with verified page anchors. Family-resemblance score predicts prototypicality at ρ = .84–.94 across six categories — a measurable 'textbook case vs blurry rim' for the four-feature test. ▲ *Bird* was not among the tested categories (the robin/penguin norms are Rosch 1975a); object categories, ~1,076 US undergraduates — extension to normative categories is DD's own wager. Full text in DD local archive (scratch/sources/part1/, gitignored).

### san-code-of-research-ethics-2017
- status: usable
- medium: text
- cite: South African San Institute, *San Code of Research Ethics* (Kimberley: SASI / South African San Council, under the EU TRUST project, 2017)
- kb: — (external web source; candidate for harvesting into `` as an attributed summary note)
- verified: web (verified against the published booklet PDF (trust-project.eu; images read directly): four values (respect, honesty, justice and fairness, care) plus process; genomics-research grievances; "come through the door, not the window" (Andries Steenkamp). <https://trust-project.eu/wp-content/uploads/2017/03/San-Code-of-RESEARCH-Ethics-Booklet-final.pdf>)
- note: first research-ethics code issued by an African indigenous people; the indigenous-authored counterweight to the note's otherwise entirely outsider Kalahari sourcing. Access-level: full-text (image PDF, quotations transcribed from page images).

### sapolsky-behave-2017
- status: usable
- medium: text
- cite: Robert M. Sapolsky, *Behave: The Biology of Humans at Our Best and Worst* (Penguin Press, 2017)
- kb: `Behave_the-biology-of-humans-at-our-best-and-worst.md`
- verified: web (ISBN 978-1-59420-507-1)
- note: neurobiology of behaviour; frontal cortex, amygdala, gene-effect-size caveats.

### dharma-sangha-reunion-2020
- status: barred
- barred: ephemera
- medium: text
- kb: `dharma-sangha-reunion-2020.md`
- verified: unverified
- note: secular-Buddhist community event notice; no evidential weight.

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

### schilbrack-2022-concept-of-religion-sep
- status: usable
- medium: text
- cite: Kevin Schilbrack, "The Concept of Religion," *Stanford Encyclopedia of Philosophy* (first published 28 March 2022)
- kb: `kevin-schilbrack_the-concept-of-religion_sep-2022.md` (attributed summary, staged at workshops/DD/sources/ — not yet folded into corpus)
- verified: web (https://plato.stanford.edu/entries/concept-religion/)
- note: attributed summary note with verified page anchors (section-anchored). The standard reply to Asad — realism about social structures plus map-against-territory testability. ▲ Does NOT license 'disclosed authorship' as a defence; holds polythetic framings 'equally ethnocentric'; and warns that functionally defined universality 'is not a discovery but a product of one's definition' — the sharpest published pressure on Part 1's 'every society grows one'. Open access.

### schlerath-skjaervo-1987-asa-iranica
- status: usable
- medium: text
- cite: B. Schlerath & P. O. Skjærvø, "AŠA," *Encyclopædia Iranica* II/7 (1987): 694–696 (online ed.)
- kb: `schlerath-skjaervo_asa_encyclopaedia-iranica.md` (attributed summary, staged at workshops/DD/sources/ — not yet folded into corpus)
- verified: web (iranicaonline.org/articles/asa-means-truth-in-avestan; consulted via Wayback snapshot 2023-11-17)
- note: attributed summary note with verified page anchors. Confirms *asha*/*ṛta* as the same Indo-Iranian word (Part 1's 'same word in different mouths' now on bedrock); reconstructs \**ṛtām dhar-* 'to uphold the truth' among the oldest shared formulas (~2000 BCE) — dharma's root formulaically paired with ṛta. ▲ With Lüders and Halbfass, argues the rendering is 'truth', not bare 'cosmic order'. Replaces zoroastrian.org / hinduwebsite.com in note 1.4 (S8).

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
- note: pseudonymous author; publication by Elephant Editions/Active Distribution stated in the file itself. Cited in 3.4 only as reception evidence (anarchist reappropriation of Nietzsche), never as Nietzsche interpretation.

### slingerland-2000-effortless-action
- status: usable
- medium: text-ocr
- cite: Edward Slingerland, "Effortless Action: The Chinese Spiritual Ideal of Wu-wei," *Journal of the American Academy of Religion* 68:2 (2000): 293–328
- kb: `edward-slingerland_effortless-action-wu-wei_2000.md` (attributed summary, staged at workshops/DD/sources/ — not yet folded into corpus)
- verified: web (DOI 10.1093/jaarel/68.2.293; author-self-archived PDF)
- note: attributed summary note with verified page anchors. Wu-wei as pan-Chinese ideal, not Daoist-specific — documented from the *Odes* through Confucius, Mencius, Xunzi, Laozi, Zhuangzi ('counter a common perception of wu-wei as an exclusively Daoist ideal,' p. 297). Upgrades note 1.4 (S10); the paradox of wu-wei cross-links to note 3.1. ▲ ABBYY OCR artifacts in scan; key quotes checked against page images.

### slingerland-etal-2020-coding-culture
- status: usable
- medium: text
- cite: Edward Slingerland, Quentin D. Atkinson, Carol R. Ember, Oliver Sheehan, Michael Muthukrishna, Joseph Bulbulia & Russell D. Gray, "Coding culture: challenges and recommendations for comparative cultural databases," *Evolutionary Human Sciences* 2 (2020): e29
- kb: `slingerland-et-al_coding-culture_2020.md` (attributed summary, staged at workshops/DD/sources/ — not yet folded into corpus)
- verified: web (DOI 10.1017/ehs.2020.30; CC BY 4.0)
- note: attributed summary note with verified page anchors. The eHRAF coding-validity critique by database insiders (Ember is HRAF; authors declare involvement in DRH, eHRAF, Pulotu, D-PLACE). A methods paper, not a debunking — seven recommendations. Bears on every 'coded across N societies' claim behind note 1.2. Safe to archive.

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

### taves-2009-religious-experience-reconsidered
- status: usable
- medium: text
- cite: Ann Taves, *Religious Experience Reconsidered: A Building-Block Approach to the Study of Religion and Other Special Things* (Princeton: Princeton University Press, 2009)
- kb: `ann-taves_religious-experience-reconsidered_2009.md` (attributed summary, staged at workshops/DD/sources/ — not yet folded into corpus)
- verified: web (ISBN 978-0-691-14087-2, from the copyright page)
- note: attributed summary note with verified page anchors. The methodological middle way: composites ('religions') are scholars' aggregates, but comparison rebuilds from smaller units — ascriptions of specialness, 'a deeply rooted human characteristic' (p. 34) offered as a testable hypothesis, not a fiat universal. Her mārga-derived 'special path' is the closest published analogue to dharma-as-path. Model for recasting 'every society grows one'. Full text in DD local archive (scratch/sources/part1/, gitignored); community upload.

### teeter-1997-presentation-of-maat
- status: usable
- medium: text-ocr
- cite: Emily Teeter, *The Presentation of Maat: Ritual and Legitimacy in Ancient Egypt*, Studies in Ancient Oriental Civilization 57 (Chicago: Oriental Institute, 1997)
- kb: `emily-teeter_the-presentation-of-maat_1997.md` (attributed summary, staged at workshops/DD/sources/ — not yet folded into corpus)
- verified: web (official OI/ISAC open-access edition, isac.uchicago.edu; ISBN 1-885923-05-1)
- note: attributed summary note with verified page anchors. 205 catalogued scenes, Thutmose III to Aspelta: presenting maat was a royal monopoly bound to legitimacy — the king upholds a primordial order he never makes. ▲ Structural echo of Olivelle's royal-vocabulary dharma — both orders begin as king-maintained legitimacy machinery. Iconographic study: do not cite for ethical content (that is Lichtheim). Safe to archive.

### waismann-1945-verifiability
- status: usable
- medium: text-ocr
- cite: Friedrich Waismann, "Verifiability," *Proceedings of the Aristotelian Society*, Supp. Vol. 19 (1945): 119–150
- kb: `friedrich-waismann_verifiability_1945.md` (attributed summary, staged at workshops/DD/sources/ — not yet folded into corpus)
- verified: web (JSTOR 4106433; symposium with MacKinnon and Kneale)
- note: attributed summary note with verified page anchors. Replaces the Wikipedia citation in note 1.3 (S15). Open texture ('Porosität der Begriffe', Kneale's translation, p. 121 n.): the impossibility of forestalling unforeseen cases, distinct from remediable vagueness. ▲ Waismann confines it to empirical description — the legal extension is Hart's, the dharma extension is DD's own; 1.3's borderline cases are closer to vagueness than open texture. Full text in DD local archive (scratch/sources/part1/, gitignored).

### wikipedia-walden
- status: usable
- medium: text
- cite: "Walden," Wikipedia (accessed 2026-07-27); scholarly context Laura Dassow Walls, *Henry David Thoreau: A Life* (University of Chicago Press, 2017), ISBN 978-0-226-34469-0
- kb: — (external; no KB file)
- verified: web (article fetched 2026-07-27: Emerson's ownership, work-exchange arrangement, 4 July 1845 – 6 September 1847, several-times-weekly Concord trips, in-kind support; Walls 2017 confirmed via University of Chicago Press catalogue)
- note: the documented facts behind the Lowell critique, used in 6.3 to keep the Thoreau strand honest. Walls is the standing scholarly biography if a deeper treatment is later needed; her text was not itself consulted.

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
- note: File located at appliedanthropology/workshops/transcripts/ (not indexed in the shared DB at query time); content peeked directly to identify speaker/host/title.

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
- note: Item is a Google Books metadata/blurb page archived under staging.text/websearch_data/, not a bare-domain ephemera page - it documents a real, citable book.

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
- note: prov=Bodhi (general Buddhism-topic dir, not necessarily Bhikkhu Bodhi). `NiqN03KBSME.transcript.txt` is the video transcript of the same interview (YouTube id NiqN03KBSME; same participants and content) — one work, two corpus forms.

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
- note: experimental test of punishment-as-costly-signal; no partner-choice escalation; punishment "a more ambiguous signal of cooperative intent compared to help". ▲ Partly falsifies 5.5's peacock's-tail claim.

### baum-richerson-2025-lab-cultural-evolution-punishing
- status: usable
- medium: text
- cite: William M. Baum & Peter J. Richerson, "Cultural evolution in the laboratory: evolution of cooperative altruistic punishing", *Evolutionary Human Sciences* 7 (2025), PMCID PMC12645323
- kb: `PMC12645323-cultural-evolution-in-the-laboratory-evolution-of-cooperativ.md`
- verified: web (PMC12645323; authors confirmed via Europe PMC authorString "Baum WM, Richerson PJ")
- note: multi-generation public-goods experiments; cooperative altruistic punishing evolves only when punishment is cheap; "canny defectors achieved the highest payoffs, always by a small margin". Live-human anchor for the "exploiter held down, never eliminated" claim, replacing a Behave gloss.

### ben-oren-2023-specialization-double-edged
- status: usable
- medium: text
- cite: Yotam Ben-Oren, Oren Kolodny & Nicole Creanza, "Cultural specialization as a double-edged sword: division into specialized guilds might promote cultural complexity at the cost of higher susceptibility to cultural loss", *Philosophical Transactions of the Royal Society B* (2023), PMCID PMC9869445
- kb: `PMC9869445-cultural-specialization-as-a-double-edged-sword-division-int.md`
- verified: web (PMC9869445; authors confirmed via Europe PMC authorString "Ben-Oren Y, Kolodny O, Creanza N")
- note: specialist custodianship raises attainable cultural complexity but concentrates knowledge, amplifying loss under demographic/environmental shock — the transmission-theoretic form of note 2.4's institutionalisation paradox, independent of Batchelor.

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
- note: transmission-chain experiment; prestige bias real but the *smallest* measured effect (+15% recall); content biases (social, survival, negative-emotional, counterintuitive) dominate. ▲ Qualifies rather than supports the standard prestige-led account.

### bettera-2024-secondo-natura
- status: usable
- medium: text
- cite: Stefano Davide Bettera, Secondo natura: Critica dell'ideologia liberal progressista (Solferino, 2024)
- kb: `Secondo_Natura`, `Secondo_Natura.it.md`
- verified: web (ISBN 9788828215592)
- note: truncated filename; corpus holds 4 variant files (it, gpt-4o-latest.en, chatgpt-4o-latest.en, gpt-4o-mini.en) -- machine-translated/summarized renderings of this Italian book; verify which variant was actually cited against the original

### bettera-2024-secondo-natura-2
- status: usable
- medium: text
- cite: Stefano Davide Bettera, *Secondo natura: Critica dell'ideologia liberal progressista* (Solferino, 2024)
- kb: `Secondo_Natura.*.md`
- verified: web (ISBN 9788828215592)
- note: NEEDS-HUMAN: input filename is literally "Secondo_Natura.\*.md" (unexpanded glob, not a real file). DB has four variants under staging.text/Stefano_Bettera/ (chatgpt-4o-latest.en, gpt-4o-latest.en, gpt-4o-mini.en, it) -- confirm which specific file/language was actually cited; the .en variants are LLM translations/summaries of the Italian original.

### bhagavad-gita-oevortex
- status: usable
- medium: text
- cite: *Bhagavad Gītā*, chs. 1–18, anonymous English rendering — corpus copy extracted (700 verses → 18 chapter files) from the HuggingFace dataset `OEvortex/Bhagavad_Gita` (MIT licence); underlying scripture public domain. Cite **by chapter.verse**, never by page.
- kb: `bhagavad-gita-ch01.md`, `bhagavad-gita-ch02.md`, `bhagavad-gita-ch03.md`, `bhagavad-gita-ch04.md`, `bhagavad-gita-ch05.md`, `bhagavad-gita-ch06.md`, `bhagavad-gita-ch07.md`, `bhagavad-gita-ch08.md`, `bhagavad-gita-ch09.md`, `bhagavad-gita-ch10.md`, `bhagavad-gita-ch11.md`, `bhagavad-gita-ch12.md`, `bhagavad-gita-ch13.md`, `bhagavad-gita-ch14.md`, `bhagavad-gita-ch15.md`, `bhagavad-gita-ch16.md`, `bhagavad-gita-ch17.md`, `bhagavad-gita-ch18.md`
- verified: unverified
- note: ▲ TRANSLATOR/EDITION UNRESOLVED. Chapter-file headers state only "Source: OEvortex/Bhagavad_Gita (MIT). English translation." — no translator, publisher, year or base edition (confirmed in `$VECTORDBS/appliedanthropology/workshops/hf/bhagavad-gita/README.md`). The English is a loose, expansive paraphrase with typos and interpolated glosses; it renders the key term inconsistently (3.35 "one's own duty (Dharma)"; 18.47 "one's own tasks") and at 18.66 renders *sarva-dharmān parityajya* ("abandoning all dharmas") as "Detach yourself from all worldly things" — the word *dharma* vanishes; 3.35 also carries an uncorrected typo ("filles with menace"). **Usable only for citing the STRUCTURE of the text's argument, by chapter.verse; NOT usable for word-level or philological claims, and no wording may be quoted as authoritative, until cross-checked against a named scholarly edition (van Buitenen, Zaehner, Miller, or public-domain Telang/SBE vol. 8).** Chapter-file frontmatter categories are `myth-religion-culture` / `philosophy-ethics` (not `secular-dharma`), consistent with the dataset README's "traditional, not secular-dharma canon". Enters notes per the non-privileging stance as one tradition's self-theorisation to be tested against the checklist, never as an authority over it. Reconciles three keys three review agents proposed independently (`bhagavad-gita-hf-oevortex`, `bhagavad-gita-primary-text`, `bhagavad-gita-oevortex`). Note 3.1 additionally cites the Gita's *argument* via secondary web commentary (wisdomlib/TIJER) at its own [S6]; that secondary citation stands separately and is not this entry.

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
- note: anchor source of note 8.5 — the 1965–66 'Ata shipwreck ("real Lord of the Flies") and the Robbers Cave / Middle Grove correction (via Gina Perry's archive work). Reviewers have criticised Bregman's use of sources; weigh popular-synthesis claims accordingly.

### bretl-goering-2022-moral-intuitions
- status: usable
- medium: text
- cite: Brandon L. Bretl & Marlon Goering, "Age- and sex-based differences in the moral intuitions of American early adolescents", *Evolutionary Human Sciences* 4 (2022), PMCID PMC10426028
- kb: `PMC10426028-age-and-sex-based-differences-in-the-moral-intuitions-of-ame.md`
- verified: web (PMC10426028; authors confirmed via Europe PMC authorString "Bretl BL, Goering M")
- note: within-population (age/sex) variation in autonomy, loyalty and empathy/animal-harm intuitions among US American early adolescents, with a pubertal-onset hypothesis; also states the is/ought guard explicitly — evolutionary functional fitness "does not necessarily have anything to say about how beneficial these… mechanisms are in the contexts of modern-day societies". Descriptive psychology only — must not license any normative "better/worse" claim.

### bryant-smaldino-2025-distortion-music
- status: usable
- medium: text
- cite: Gregory A. Bryant & Paul E. Smaldino, "The cultural evolution of distortion in music (and other norms of mixed appeal)", *Philosophical Transactions of the Royal Society B* 380(1923):20240014 (2025), PMCID PMC11966159
- kb: `PMC11966159-the-cultural-evolution-of-distortion-in-music-and-other-norm.md`
- verified: web (PMC11966159; authors confirmed via Europe PMC authorString "Bryant GA, Smaldino PE" and UCLA faculty page)
- note: norms of mixed appeal driven by intra-group cohesion and inter-group differentiation; general account of subgroup-differentiating markers. ▲ The corpus file's `authors:` frontmatter field is EMPTY — author attribution comes from Europe PMC, not the corpus.

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
- note: institutions as "socially created and culturally inherited proscriptions on behaviour that define roles and set expectations about social interactions"; institutions-as-rules vs as-equilibria; institutions may be "designed by a minority for a minority" and enforce socially detrimental behaviour.

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
- kb: `posts_the-seven-moral-rules-found-all-around-the-world.md`
- verified: web (https://doi.org/10.1086/701478)
- note: Attributed summary with verified page anchors staged as `curry-mullins-whitehouse_is-it-good-to-cooperate_2019.md` (workshops/DD/sources/), covering the full typeset article INCLUDING the four published Comments (Bloom; Gintis; Smith & Kurzban, 'Morality Is Not Always Good'; Wong) and the authors' Reply — the Oxford ORA deposit of the published version, plus supplement, in the DD local archive. Key figures: 961/962 coded valence observations positive (p. 54); fairness observed in 9/60 societies; coverage confound r = 0.43 (p. 55); fairness κ = 0.14. ▲ 'None was found' is the honest gloss, not 'there are none'; the codebook's rule five has no 'legitimate' qualifier. Prefer this entry over curry-2019-seven-moral-rules (blog gloss) for any [S#] carrying weight.

### dalai-lama-simple-religion-quote
- status: usable
- medium: text
- cite: Dalai Lama XIV, "This is my simple religion. There is no need for temples; no need for complicated philosophy. Our own brain, our own heart is our temple; the philosophy is kindness." (widely attributed; The Dalai Lama: A Policy of Kindness: An Anthology of Writings By and About the Dalai Lama, ed. Sidney Piburn, Snow Lion Publications, 1990, p. 52)
- kb: `simple-religion-need-temples-need-complicated-philosophy-brain-heart-ou_gpt-4o-mini.md`
- verified: web (ISBN 9781559390224; A Policy of Kindness, ed. Piburn, 1990, p. 52 per multiple quote-reference sites)
- note: truncated filename resolved via DB LIKE match to zenquotes/discourse.md/simple-religion-need-temples-need-complicated-philosophy-brain-heart-ou_gpt-4o-mini.mdgpt-4o-mini.md; KB text is an LLM (gpt-4o-mini) discourse elaborating this Dalai Lama quote -- verify against original

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
- note: ten-day experience-sampling study (N = 309; 5,284 gossip events) showing everyday gossip concerns targets' cooperativeness and drives reputation updating, partner selection and indirect reciprocity. Field evidence replacing Brown-via-Wikipedia for the gossip universal.

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
- note: review of frequency-dependent and life-history models of psychopathy; dimensional not categorical; adaptiveness mediated by cultural norms (whether people "tolerate, ostracise or are easily deceived by psychopaths"). Now corpus-internal (was an external PMC link in note 5.5).

### espin-branas-garza-2022-group-functional-punishment
- status: usable
- medium: text
- cite: Antonio M. Espín, Pablo Brañas-Garza, Juan F. Gamella, Benedikt Herrmann & Jesús Martín, "Culture and group-functional punishment behaviour", *Evolutionary Human Sciences* 4 (2022), PMCID PMC10426100
- kb: `PMC10426100-culture-and-group-functional-punishment-behaviour.md`
- verified: web (PMC10426100; authors confirmed via Europe PMC authorString "Espín AM, Brañas-Garza P, Gamella JF, Herrmann B, Martín J")
- note: altruistic punishers "condemned to a lower evolutionary success within their group"; the sanctioning system as a "second-order social dilemma"; cultural group selection picks which norms proliferate, but punishment stabilises any norm, adaptive or maladaptive. Primary-literature anchor for the third-party-punishment claim previously on a prosocial.world post.

### etymology-origins-of-dharma-md
- status: barred
- barred: self
- medium: text
- kb: `etymology-origins-of-dharma.md`
- verified: unverified
- note: prov=faqs; AI-authored corpus FAQ note per rule 1 (gloss itself flags '*AI-authored co[ntent]*')

### evan-thompson-waking-dreaming-being
- status: usable
- medium: text
- cite: Evan Thompson, *Waking Dreaming Being_Self and Consciousness*
- kb: `Evan-Thompson_Waking-Dreaming-Being_Self-and-Consciousness.md`
- verified: web (ISBN 978-0-231-13709-6)
- note: NEEDS-HUMAN: was under _unprocessed_ staging dir; genuine third-party work reclassified usable — confirm bibliographic details

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
- note: preregistered Bayesian meta-analysis of evolutionary cooperation mechanisms in real-world joint-liability microfinance (73 effect estimates, largely non-WEIRD); only punishment robustly positive, kin selection weakly negative (65% posterior more-related groups repay less), high heterogeneity and reproducibility concerns. Quantitative backing for 5.2's adaptationism hedge.

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
- medium: text
- cite: Clifford Geertz, The Religion of Java (The Free Press, 1960; repr. 1976)
- kb: `clifford-geertz_the-religion-of-java_1976.md`
- verified: web (per Cambridge/UChicago Press catalogue entries)
- note: NEEDS-HUMAN: prov=_unprocessed_ literally matches the barred:self heuristic (rule 1), but sqlite peek confirms this is the genuine OCR'd text of Geertz's 1960 book (1976 reprint per filename/Monoskop copy), not project-author prose -- reclassified usable by content override; recommend confirming and re-filing out of _unprocessed_

### gintis-vanschaik-boehm-2015-zoon-politikon
- status: usable
- medium: text
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
- note: the 2009 essay preceding the 2011 Melville House book of the same title — this entry cites the essay, which is what the corpus holds.

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
- note: —

### graeber-stern-weiner-2011-debt-slavery-freedom
- status: usable
- medium: text
- cite: David Graeber, interviewed by Jamie Stern-Weiner, "Debt, Slavery and our Idea of Freedom" (two-part interview, 29 August & 1 September 2011)
- kb: `david-graeber+jamie-stern-weiner_debt-slavery-and-our-idea-of-freedom.md`
- verified: web (https://davidgraeber.org/interviews/debt-slavery-and-our-idea-of-freedom/; repr. The Anarchist Library, ZNetwork)
- note: conducted on UK publication of *Debt: The First 5000 Years*.

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
- note: not found in current local DB (removed/moved since citation); identified via YouTube id lookup

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
- verified: acquired (diamond OA; full text at `scratch/sources/part4/1-ubuntu/`, 28 pp.)
- note: The standard analytic statement of ubuntu as a *moral theory* rather than a slogan, by the philosopher who has done most to formalise it, and the natural first citation for Part 4's Ubuntu cluster. Also treats *S v Makwanyane*, so it covers both the ethics and the constitutional-law strand in one text. Cited by DD note 4.2.

### gade-2011-written-discourses-on-ubuntu
- status: usable
- medium: text
- cite: Christian B. N. Gade, "The historical development of the written discourses on ubuntu," *South African Journal of Philosophy* 30(3) (2011): 303–329
- verified: acquired (OA via Aarhus PURE; full text at `scratch/sources/part4/1-ubuntu/`, 27 pp.)
- note: Traces when ubuntu was actually written about and what it was taken to mean at each stage. The load-bearing finding for Part 4: Gade advances as an explicit **hypothesis** — his word, not a demonstration — that it was "between 1993 and 1995" that ubuntu "was defined for the first time as something connected to the proverb '*umuntu ngumuntu ngabantu*'," i.e. contemporaneous with the Interim Constitution's Epilogue and the founding of the TRC, so that "the term 'ubuntu' and the proverb became intimately connected within the space of just a few years." ▲ Cite it as a dated hypothesis about the *written* discourse, not as proof about oral tradition — the distinction matters for Part 4's "a village proverb became a principle of constitutional law" sentence. Cited by DD note 4.2.

### menkiti-1984-person-and-community
- status: usable
- medium: text
- cite: Ifeanyi A. Menkiti, "Person and Community in African Traditional Thought," in Richard A. Wright (ed.), *African Philosophy: An Introduction*, 3rd edn (University Press of America, 1984), 171–181
- verified: acquired (full text at `scratch/sources/part4/1-ubuntu/`, 6 pp.)
- note: The foundational statement of relational personhood — that personhood is acquired within community rather than possessed at birth — and the text the whole "I am because we are" literature argues with. Short, primary, and the correct anchor for Part 4's contrast between relational and individualist accounts of the self. Cited by DD note 4.2.

### makwanyane-1995-constitutional-court
- status: usable
- medium: text
- cite: *S v Makwanyane and Another* (CCT3/94) [1995] ZACC 3, Constitutional Court of South Africa, 6 June 1995
- verified: acquired (via Metz 2011, which quotes and analyses the ubuntu passages; primary judgment on SAFLII is `browser`-only)
- note: The judgment abolishing the death penalty in South Africa, and the case in which *ubuntu* enters constitutional jurisprudence — the documentary basis for the claim that ubuntu became a principle of law. ▲ Read here through Metz's treatment rather than in the primary; SAFLII refuses scripted fetches, so one manual download is outstanding. Cited by DD note 4.2.

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
- note: Specific byline not surfaced in search results.

### ishungisa-2025-prestige-gender-ideology
- status: usable
- medium: text
- cite: Alexander M. Ishungisa, Joseph A. Kilgallen, Elisha Mabula, Charlotte O. Brand, Mark Urassa & David W. Lawson, "Prestige and gender role ideology: a study of young Tanzanian men", *Evolutionary Human Sciences* (2025), PMCID PMC11949630
- kb: `PMC11949630-prestige-and-gender-role-ideology-a-study-of-young-tanzanian.md`
- verified: web (PMC11949630; authors confirmed via Europe PMC authorString "Ishungisa AM, Kilgallen JA, Mabula E, Brand CO, Urassa M, Lawson DW")
- note: field evidence for model-based social learning of *norms*; elders prestigious as "preservers and teachers of societal norms"; prestige empirically hard to separate from dominance.

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
- note: US/Singapore/Poland samples; the fast Dark-Triad strategy carries familial, romantic and platonic psychosocial costs. Cross-national ballast against overstating adaptiveness of the fast strategy.

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
- note: anonymous AI-news channel narrating Bill Gates's 2024 AI-agent predictions — second-hand commentary, not Gates verbatim. Registered usable by author decision (2026-07-19); weight accordingly. Cited in 8.2 [S4] alongside the Harris/Bartlett transcript.

### kalkhoff-serpe-pollock-2020-video-chat-proxy
- status: usable
- medium: text
- cite: Will Kalkhoff, Richard T. Serpe & Josh Pollock, "Is Video Chat a Sufficient Proxy for Face-to-Face Interaction? Biosociological Reflections on Life during the COVID-19 Pandemic" (This View of Life, 28 Jul 2020)
- kb: `posts_is-video-chat-a-sufficient-proxy-for-face-to-face-interaction-biosociological-reflections-on-life-during-the-covid-19-pandemic.md`
- verified: web
- note: Cites Turkle, *Alone Together* (2011) per gloss; full title truncated with "..." in the input filename.

### khan-2026-institutionalised-commitment
- status: usable
- medium: text
- cite: Saira Khan, "Institutionalised commitment and its origins", *Human Nature* 37 (2026), PMCID PMC13079463
- kb: `PMC13079463-institutionalised-commitment-and-its-origins.md`
- verified: web (PMC13079463; author confirmed via Europe PMC authorString "Khan S")
- note: transition from reputationally- to institutionally-enforced commitment, dated to Neolithic sedentism/agriculture/hierarchy; institutional third-party punishment enables cooperation with strangers absent reputational information. Author flags it as a narrative hypothesis. Converts an [A] in note 2.3 to a citable [S#].

### kido-takezawa-2024-norm-psychology
- status: usable
- medium: text
- cite: Yuta Kido & Masanori Takezawa, "Coevolution of norm psychology and cooperation through exapted conformity", *Evolutionary Human Sciences* 6 (2024), PMCID PMC11503932
- kb: `PMC11503932-coevolution-of-norm-psychology-and-cooperation-through-exapt.md`
- verified: web (PMC11503932; authors confirmed via Europe PMC authorString "Kido Y, Takezawa M")
- note: gene-culture coevolutionary model of norm psychology; injunctive vs descriptive norms; internalisation evidenced by early norm acquisition in children and reward-circuit activation making "norm compliance a goal rather than a burden".

### kish-bar-on-lamm-2023-norm-psychology-identity
- status: usable
- medium: text
- cite: Kati Kish Bar-On & Ehud Lamm, "The interplay of social identity and norm psychology in the evolution of human groups", *Philosophical Transactions of the Royal Society B* 378 (2023), PMCID PMC9869443
- kb: `PMC9869443-the-interplay-of-social-identity-and-norm-psychology-in-the-.md`
- verified: web (PMC9869443; authors confirmed via Europe PMC authorString "Kish Bar-On K, Lamm E" — surname is the compound "Kish Bar-On")
- note: canonical definition of norm psychology as "the suite of psychological adaptations involved in humans' capacity to establish and enforce social norms"; argues norm psychology and social identity must be integrated.

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
- note: preregistered Thaipusam Kavadi study (N = 369; Tamil Hindu in-group vs Christian out-group). ▲ In-group estimated physical costs lower but *material* costs higher; concludes "differential estimation of ritual benefits, not costs, are key to the persistence of extreme rituals" — refines rather than confirms Sosis's differential-cost-estimation account. Replaces the YouTube-transcript source for 5.2's Thaipusam claim.

### lightner-2021-ethnoscientific-expertise
- status: usable
- medium: text
- cite: Aaron D. Lightner, Cynthiann Heckelsmiller & Edward H. Hagen, "Ethnoscientific expertise and knowledge specialisation in 55 traditional cultures", *Evolutionary Human Sciences* (2021), PMCID PMC10427309
- kb: `PMC10427309-ethnoscientific-expertise-and-knowledge-specialisation-in-55.md`
- verified: web (PMC10427309; authors confirmed via Europe PMC authorString "Lightner AD, Heckelsmiller C, Hagen EH")
- note: cross-cultural coding of knowledge specialists; religious/spiritual leaders are ethnoscientific experts in 19% of records; competing cultural-transmission vs proprietary-knowledge (secretive, gatekept) models of expertise.

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
- note: conformist transmission alone cannot stabilise traditions; punishment/reward-based norm reinforcement can; generates historical contingency, multi-generational adaptive lag, and boundary-driven divergence between culturally similar neighbouring groups.

### manson-2020-narcissism-lhs-instrument
- status: usable
- medium: text
- cite: Joseph H. Manson, "Is narcissism a slow life history strategy indicator?: the answer depends on the LHS instrument", *Evolutionary Psychology* 18 (2020), PMCID PMC10358412
- kb: `PMC10358412-is-narcissism-a-slow-life-history-strategy-indicator-the-ans.md`
- verified: web (PMC10358412; author confirmed via Europe PMC authorString "Manson JH")
- note: N = 929; callousness and secondary psychopathy are fast-LHS indicators across two psychometric LHS instruments, while narcissism's status is instrument-dependent. Measurement-robustness reinforcement for the psychopathy/fast-LHS mapping.

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
- note: filename is the bare YouTube video ID; not present in local corpus DB (path empty) but resolved via web search

### melton-baumann-2010-religions-of-the-world-sumarah
- status: usable
- medium: text
- cite: J. Gordon Melton & Martin Baumann (eds.), "Sumarah" entry in *Religions of the World: A Comprehensive Encyclopedia of Beliefs and Practices* (ABC-CLIO, 2nd ed., 2010)
- kb: `sumarah-religions-of-the-world.md`, `Paul-Stange_Sumarah_2002.md`
- verified: web
- note: prov=sumarah (explicit usable-topic dir).

### mesoudi-thornton-2018-what-is-cce
- status: usable
- medium: text
- cite: Alex Mesoudi & Alex Thornton, "What is cumulative cultural evolution?", *Proceedings of the Royal Society B* (2018), PMCID PMC6015846
- kb: `PMC6015846-what-is-cumulative-cultural-evolution.md`
- verified: web (PMC6015846; authors confirmed via Europe PMC authorString "Mesoudi A, Thornton A")
- note: core vs extended criteria for cumulative cultural evolution; the standard definitional reference for transmission fidelity and trait retention.

### migliano-vinicius-2022-foraging-niche
- status: usable
- medium: text
- cite: Andrea Bamberg Migliano & Lucio Vinicius, "The origins of human cumulative culture: from the foraging niche to collective intelligence", *Philosophical Transactions of the Royal Society B* (2022), PMCID PMC8666907
- kb: `PMC8666907-the-origins-of-human-cumulative-culture-from-the-foraging-ni.md`
- verified: web (PMC8666907; authors confirmed via Europe PMC authorString "Migliano AB, Vinicius L")
- note: transmission fidelity, teaching, specialisation, recombination and ratcheting as adaptations of the forager niche. ▲ Argues *reduced* hierarchy raised transmission fidelity — cuts against note 2.4's hierarchical paradigm carriers.

### milinski-2016-reputation-universal-currency
- status: usable
- medium: text
- cite: Manfred Milinski, "Reputation, a universal currency for human social interactions", *Philosophical Transactions of the Royal Society B* 371 (2016), PMCID PMC4760200
- kb: `PMC4760200-reputation-a-universal-currency-for-human-social-interaction.md`
- verified: web (PMC4760200; author confirmed via Europe PMC authorString "Milinski M")
- note: direct vs indirect reciprocity; reputation as a socially maintained score updated by observation and gossip, functioning "like money that can be used whenever the person needs help", attracting help from strangers and out-group members.

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
- note: Add Health test; harshness and unpredictability distinguish life-course-persistent from adolescence-limited offenders, but other life-history measures do not — "a lack of support for the evolutionary taxonomy" on those measures. Corroborates the harshness/unpredictability channel while curbing the broader fast-LHS story.

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
- note: phylogenetic reconstruction of religiosity across a global hunter-gatherer sample using a time-calibrated supertree; animism ancestral; moralising active high gods "absent in early humans". Method-independent corroboration of the moralising-gods-are-late caveat, not reliant on the retracted Seshat analysis.

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
- note: Discusses Norenzayan's "big gods" thesis and Purzycki cross-cultural game data.

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
- note: Xygalatas = anthropologist, University of Connecticut. Cited in 5.4 [S4] alongside the registered cognitive-anthropologist companion post.

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
- note: ProSocial World's own material — non-independent; registered usable with that caveat by author decision (2026-07-19). Evidences only the programme's self-description (CDPs from Ostrom). Cited in 6.1 [S4].

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
- note: Confirmed URL: prosocial.world/prosocial-spirituality-active-group-engagement; combines Ostrom's Core Design Principles with Teasdale's Interspiritual Elements, funded by John Templeton Foundation. P3-verify (2026-07-02): live URL now returns HTTP 404 (absent from sitemap.xml), but a Wayback Machine snapshot (18 Jan 2025, HTTP 200) exists and is used as the anchor; confirmed via the archive.org availability API.

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
- note: programme's own promotional/research material — non-independent; registered usable with that caveat by author decision (2026-07-19). Evidences only the programme's self-description. Cited in 6.1 [S4]; cf. entry prosocial-world-prosocial-spirituality-active-group-engagement.

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
- note: 16-study meta-analysis; no elevation of non-right-handedness in psychopathy across community, offender and forensic samples; "fail[s] to support the mental disorder model", "partly support[s] the adaptive strategy model", Factor 1 vs Factor 2 divergent. Empirical test of the harmful-dysfunction argument.

### puurtinen-mappes-2009-between-group-competition
- status: usable
- medium: text
- cite: Mikael Puurtinen & Tapio Mappes, "Between-group competition and human cooperation", *Proceedings of the Royal Society B* 276 (2009), PMCID PMC2581672
- kb: `PMC2581672-between-group-competition-and-human-cooperation.md`
- verified: web (PMC2581672; authors confirmed via Europe PMC authorString "Puurtinen M, Mappes T"; ▲ Europe PMC gives year 2009, vol. 276 — some secondary citations give 2008 from the online-first date)
- note: experimental demonstration that between-group competition resolves the public-goods dilemma, raises within-group cooperation, and "intensifies the moral emotions of anger and guilt associated with violations of the cooperative norm".

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
- note: tests two cultural-group-selection predictions about costly punishment under intergroup competition; both confirmed, but the effect is fully explained by conditionality on *expected* punishment levels — a deflationary caveat that belongs in any note leaning on CGS.

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
- note: Confirmed via oEmbed. Matches gloss (Menander/Milinda, Dharmachakra, Halkias, Gandhāran art).

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
- note: Author/year identified from document header ('# Notes on Sumarah meditation practice / ### Laura Romano, 1995')

### romano-introduction-to-sumarah-meditation
- status: usable
- medium: text
- cite: Laura Romano, "Introduction to Sumarah Meditation"
- kb: `introduction-to-sumarah.md`
- verified: web (https://www.sumarah.net/en/introduction/introduction-to-sumarah.html)
- note: Author identified from document header ('# Introduction to Sumarah Meditation / ### Laura Romano')

### rusch-2013-altruism-asymmetries-intergroup-conflict
- status: usable
- medium: text
- cite: Hannes Rusch, "Asymmetries in altruistic behavior during violent intergroup conflict", *Evolutionary Psychology* 11(5) (2013), PMCID PMC10437105
- kb: `PMC10437105-asymmetries-in-altruistic-behavior-during-violent-intergroup.md`
- verified: web (PMC10437105; author confirmed via Europe PMC authorString "Rusch H")
- note: critiques the symmetric n-person-prisoner's-dilemma model underlying Choi & Bowles parochial-altruism theory; historical 20th-century data show in-group altruism concentrated in defence rather than attack; "calls for a refinement of theories".

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
- note: Peeked content: file is a compilation of VTT-derived lecture transcripts (e.g. header "10-Introduction-to-Neuroscience-I-5031rWXgdYo.vtt"); the first segment shown is delivered by a teaching assistant (Nathan), not Sapolsky himself. Cite the course generally; verify per-claim which segment/speaker underlies a specific citation.

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
- note: agent-based simulation; when retaliation against punishers or second-order punishment is permitted, "the cooperative effects of punishment are reduced or eliminated", modulated by network density. ▲ Complicates the "layered punishment sustains cooperation" claim in 5.5 §4.

### silva-mace-2014-northern-ireland-field-experiments
- status: usable
- medium: text
- cite: Antonio S. Silva & Ruth Mace, "Cooperation and conflict: field experiments in Northern Ireland", *Proceedings of the Royal Society B* 281:1792 (2014), art. 20141435, PMCID PMC4150329
- kb: `PMC4150329-cooperation-and-conflict-field-experiments-in-northern-irela.md`
- verified: web (PMC4150329; authors confirmed via Europe PMC authorString "Silva AS, Mace R")
- note: naturalistic field experiments (donations, lost-letter returns) with Catholics and Protestants; conflict reduced out-group but showed "no evidence that it influences in-group cooperation", SES dominant; "a challenge to dominant perspectives on the origins of human cooperation". Counter-evidence to Choi & Bowles, bears on 5.2 and 7.1's "same machinery" thesis.

### singh-henrich-2020-mentawai-taboos
- status: usable
- medium: text
- cite: Manvir Singh & Joseph Henrich, "Why do religious leaders observe costly prohibitions? Examining taboos on Mentawai shamans", *Evolutionary Human Sciences* 2 (2020), PMCID PMC10427447
- kb: `PMC10427447-why-do-religious-leaders-observe-costly-prohibitions-examini.md`
- verified: web (PMC10427447; authors confirmed via Europe PMC authorString "Singh M, Henrich J")
- note: field experiment among Mentawai shamans (Siberut) testing cooperative costly signalling, CREDs and supernatural otherness; all three supported, strongest effect on perceived belief. Non-WEIRD animist/shamanic setting; co-authored by Henrich. Full-text anchor for 5.2's CREDs claim.

### smaldino-2025-similarity-biased-learning
- status: usable
- medium: text
- cite: Paul E. Smaldino & Alejandro Pérez Velilla, "The evolution of similarity-biased social learning", *Evolutionary Human Sciences* (2025), PMCID PMC11859121
- kb: `PMC11859121-the-evolution-of-similarity-biased-social-learning.md`
- verified: web (PMC11859121; authors confirmed via Europe PMC authorString "Smaldino PE, Velilla AP" — the double surname "Pérez Velilla" is indexed under Velilla)
- note: identity-cued (parochial) social learning as an adaptive strategy; grounds the "learn from our kind" mechanism behind sectarian in-group transmission.

### smolla-akcay-2023-pathways-cultural-adaptation
- status: usable
- medium: text
- cite: Marco Smolla & Erol Akçay, "Pathways to cultural adaptation: the coevolution of cumulative culture and social networks", *Evolutionary Human Sciences* (2023), PMCID PMC10565192
- kb: `PMC10565192-pathways-to-cultural-adaptation-the-coevolution-of-cumulativ.md`
- verified: web (PMC10565192; authors confirmed via Europe PMC authorString "Smolla M, Akçay E")
- note: high-proficiency culture requires dense networks, norms suppressing individual innovation, and specialised transmitters — a formal mechanism for scholastic conservatism and for the emergence of teaching lineages.

### sparks-burleigh-barclay-2024-expressed-disapproval
- status: usable
- medium: text
- cite: Adam Sparks, Tyler Burleigh & Pat Barclay, "Expressed disapproval does not sustain long-term cooperation as effectively as costly punishment", *Evolutionary Human Sciences* 6 (2024), PMCID PMC11706683
- kb: `PMC11706683-expressed-disapproval-does-not-sustain-long-term-cooperation.md`
- verified: web (PMC11706683; authors confirmed via Europe PMC authorString "Sparks A, Burleigh T, Barclay P")
- note: 40-round experiment; expressed disapproval raises cooperation initially then decays while tangible punishment holds; disapproval "has no impact on an offender's fitness" unless backed by "physical punishment, monetary fines or fewer cooperative interactions because of ostracism" — the "teeth" argument. Explains why forager gossip works and predicts where it fails at scale.

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
- note: venue/year from the article's own citation line.

### stange-1979-possession-experience
- status: usable
- medium: text
- cite: Paul Stange, "Configurations of Javanese Possession Experience," *Religious Traditions*, vol. 2 no. 2, 1979, pp. 39-54
- kb: `Paul-Stange_Configurations-of-Javanese-Possession-Experience_1979.md`
- verified: web (https://freotopia.org/people/paulstange/configurations.html)
- note: venue/year from the article's own citation line.

### stange-1980-evolution-of-sumarah
- status: usable
- medium: text
- cite: Paul Stange, *The Evolution of Sumarah* — revision of the PhD dissertation "The Sumarah Movement in Javanese Mysticism" (University of Wisconsin–Madison, 1980); circulated as *Modern Javanism: Truth in Sumarah Practice*
- kb: `Paul-Stange_The-Evolution-of-Sumarah_1980.md`
- verified: web (https://freotopia.org/people/paulstange/evolution.pdf; sumarah.net/en/writings/books/the-evolution-of-sumarah---paul-stange.html)
- note: Stange's CV links evolution.pdf both as the book *Modern Javanism* and as the thesis *The Evolution of Sumarah* — single file; 1980 (Wisconsin PhD) confirmed via sumarah.net; KB filename year is the manifest's best estimate for this revision.

### stange-1986-legitimate-mysticism
- status: usable
- medium: text
- cite: Paul Stange, "'Legitimate' mysticism in Indonesia," *Review of Indonesian and Malaysian Affairs*, vol. 20 no. 2, 1986, pp. 76-117
- kb: `Paul-Stange_Legitimate-mysticism-in-Indonesia_1986.md`
- verified: web (https://freotopia.org/people/paulstange/legitimate.html)
- note: venue/year from the article's own citation line.

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
- kb: `Paul-Stange_Javanism-as-text-or-praxis_1990.md`
- verified: web (https://freotopia.org/people/paulstange/praxis.html)
- note: venue/year from the article's own citation line.

### stange-1991-collapse-of-lineage
- status: usable
- medium: text
- cite: Paul Stange, "The Collapse of Lineage and Availability of Gnosis" (Charles Strong Trust lecture, Australian Association for the Study of Religions, Adelaide, 1991)
- kb: `Paul-Stange_The-Collapse-of-Lineage-and-Availability-of-Gnosis_1991.md`
- verified: web (https://freotopia.org/people/paulstange/gnosis.html)
- note: venue/year from the document's own citation line ("Charles Strong Trust, AASR, Adelaide, 1991").

### stange-1991-deconstruction-disempowerment
- status: usable
- medium: text
- cite: Paul Stange, "Deconstruction as disempowerment: new orientalisms of Java," *Bulletin of Concerned Asian Scholars*, vol. 23 no. 3, 1991, pp. 51-71
- kb: `Paul-Stange_Deconstruction-as-disempowerment_new-orientalisms-of-Java_1991.md`
- verified: web (https://freotopia.org/people/paulstange/deconstruction.html)
- note: venue/year from the article's own citation line.

### stange-1992-religious-change-sea
- status: usable
- medium: text
- cite: Paul Stange, "Religious Change in Contemporary Southeast Asia," in *The Cambridge History of Southeast Asia*, vol. 2, ed. Nicholas Tarling (Cambridge University Press, 1992), pp. 529-584
- kb: `Paul-Stange_Religious-Change-in-Contemporary-Southeast-Asia_1992.md`
- verified: web (https://freotopia.org/people/paulstange/religious.html)
- note: venue/year from the article's own citation line.

### stange-1993-inner-dimensions-revolution
- status: usable
- medium: text
- cite: Paul Stange, "Inner dimensions of the Indonesian Revolution," in *Autonomous Histories, Particular Truths: Essays in Honor of John Smail*, ed. Laurie J. Sears (CSEAS, University of Wisconsin, Madison, 1993), pp. 219-243
- kb: `Paul-Stange_Inner-dimensions-of-the-Indonesian-Revolution_1993.md`
- verified: web (https://freotopia.org/people/paulstange/inner.html)
- note: venue/year from the article's own citation line.

### stange-1994-silences-solonese-dance
- status: usable
- medium: text
- cite: Paul Stange, "Silences in Solonese Dance Production," *Journal of Southeast Asian Social Science*, vol. 22 (1994), pp. 210-229
- kb: `Paul-Stange_Silences-in-Solonese-Dance-Production_1994.md`
- verified: web (https://freotopia.org/people/paulstange/silences.pdf)
- note: venue/year from the document's own header line.

### stange-1995-exploring-modern-asian-mysticisms
- status: usable
- medium: text
- cite: Paul Stange, *Exploring Modern Asian Mysticisms* (a.k.a. *Asian Mystical Religions*, unpublished book manuscript, c. 1995)
- kb: `Paul-Stange_Exploring-Modern-Asian-Mysticisms_1995.md`
- verified: web (https://freotopia.org/people/paulstange/exploring.pdf)
- note: full text hosted on the author's freotopia.org CV page; document titles itself "Asian Mystical Religions".

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
- note: encyclopedia entry; the document's citation line reads "Cambridge UP, Santa Barbara, 2004" but the encyclopedia was published by ABC-CLIO (Santa Barbara).

### stange-2007-politik-perhatian
- status: usable
- medium: text
- cite: Paul Stange, *Politik Perhatian: Rasa dalam Kebudayaan Jawa*, ed. Hairus Salim HS (LKiS, Yogyakarta, 1998; 2nd printing 2009)
- kb: `Paul-Stange_Politik-Perhatian_Rasa-dalam-Kebudayaan-Jawa_2007.md`, `Paul-Stange_Politik-Perhatian_Rasa-dalam-Kebudayaan-Jawa_2007.en.md`
- verified: web (https://freotopia.org/people/paulstange/politikperhatian.pdf; kubuku.id/detail/politik-perhatian---rasa-dalam-kebudayaan-jawa/37989)
- note: publisher/years confirmed via LKiS catalogue and Jakarta library records; the KB filename year (2007) is the manifest's best estimate. The `.en.md` file is a 2026 LLM English translation of the Indonesian KB text (*The Politics of Attention: Rasa in Javanese Culture*).

### stange-2008-kejawen-modern
- status: usable
- medium: text
- cite: Paul Stange, *Kejawen Modern: Hakikat dalam Penghayatan Sumarah*, trans. Chandra Utama, ed. Khudori (LKiS, Yogyakarta, 2009)
- kb: `Paul-Stange_Kejawen-Modern_Hakikat-dalam-Penghayatan-Sumarah_2008.md`
- verified: web (https://freotopia.org/people/paulstange/kejawenmodern.pdf; ISBN 979-978-53-8-3)
- note: Indonesian translation of Stange's Sumarah work; publisher/year/ISBN confirmed via LKiS catalogue records; the KB filename year (2008) is the manifest's best estimate.

### stange-2009-ancestral-voices
- status: usable
- medium: text
- cite: Paul Stange, *Ancestral Voices in Island Asia* (unpublished book manuscript, c. 2009); Indonesian version *Suara nenek moyang Nusantara*
- kb: `Paul-Stange_Ancestral-Voices-in-Island-Asia_2009.md`, `Paul-Stange_Suara-nenek-moyang-Nusantara_2009.md`
- verified: web (https://freotopia.org/people/paulstange/ancestralvoices.pdf; https://freotopia.org/people/paulstange/suara.pdf)
- note: full texts hosted on the author's freotopia.org CV page; year is the manifest's best estimate for both files.

### stange-logic-of-rasa-in-java
- status: usable
- medium: text
- cite: Paul Stange, "The Logic of Rasa in Java," Indonesia, no. 38 (October 1984), pp. 113-134
- kb: `the-logic-of-rasa--stange.md`, `Paul-Stange_The-Logic-of-Rasa-in-Java_1984.md`
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
- kb: `Evan-Thompson_Waking-Dreaming-Being-Self-and-Consciousness.md`
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
- note: social ratcheting — irreversible interdependence among cultural specialists; individual memory limits force distribution of a repertoire across a corporate body.

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
- note: Content matches gloss (pandemic transfers as UBI "dress rehearsal"); Eberstadt is a labour-economics/demography scholar (AEI).

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
- kb: `the-new-atheism-as-a-stealth-religion-five-years-later`
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
- note: DUPLICATE of key wilson-sloan-price-is-there-a-universal-morality-overview -- tvol_morality.md (DS_Wilson dir) is the series-introduction section of that same Wilson/Sloan/Price essay; its opening ("Our moral sense makes involuntary... Eating shrimp... Leviticus") matches the overview page verbatim. NOT a separate Wilson-solo article (Wilson's own distinct lead piece in the series is "Moral Universals, Moral Particulars and Tinbergen's Four Questions," 17 May 2018).

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
- note: transcript carries no channel/URL metadata and the video was not resolvable via web search; treat factual claims as low-weight popular-source corroboration only.

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
- note: transcript carries no channel/URL metadata and the video was not resolvable via web search; treat factual claims as low-weight popular-source corroboration only.

### zerzan-1991-catastrophe-of-postmodernism
- status: usable
- medium: text
- cite: John Zerzan, "The Catastrophe of Postmodernism" (1991; repr. The Anarchist Library)
- kb: `john-zerzan_the-catastrophe-of-postmodernism.md`
- verified: web (https://theanarchistlibrary.org/library/john-zerzan-the-catastrophe-of-postmodernism)

---

## Not used (assessed and excluded)
- `Glenn-Roberts_CH-19-FINAL-draft.md` — marked "DRAFT IN DEVELOPMENT – NOT FOR CIRCULATION"; barred per BRIEF.
- `Glenn-Roberts_A-day-in-the-life-of-Archie-Roberts.md`, `Glenn-Roberts_Dog-Dharma-Notes.md` — personal notes/letters, barred:ephemera per BRIEF.
- `Anna-Ronan_Anarchism-as-a-Spiritual-Practice_2019.md`, `Anna-Prouty_An-Anarcho-Taoist-Manifesto_2017.md` — reverse-direction translation specimens; deliberately left to note 8.3 (another agent's assignment) to avoid duplication.
