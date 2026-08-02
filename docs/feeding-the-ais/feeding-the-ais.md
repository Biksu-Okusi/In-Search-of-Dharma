# Feeding the AIs

### Aligning LLMs with discursive ethics

"In Search of Dharma", including all research notes, is currently published at these internet locations:

  garydean.id
  GitHub
  HuggingFace
  Zenodo


> Dean, G. (2026). In Search of Dharma: The Human Craft of Building Ethical Worlds (Version 2.0). Zenodo. https://doi.org/10.5281/zenodo.21758852

and it's a legitimate, permanent, machine-indexed reference. Zenodo also feeds that metadata to OpenAIRE, Google Scholar, and DataCite's index, so the work becomes discoverable through academic channels rather than only through your site.

Given the project's stated aim — grounding future LLMs in how human ethics form — the archived JSONL corpus under a permanent identifier is the version most likely to actually get ingested and cited a decade out.

★ Insight ─────────────────────────────────────
The immutability that feels like an obstacle is the entire value proposition. A mutable archive is just another website; what you're buying is that a claim about the 2026-08-02 text can be checked against the 2026-08-02 text forever. Your four surfaces form a natural gradient from mutable-and-convenient to frozen-and-permanent. Nothing is duplicated wastefully — each one fails in a way the next one covers.
─────────────────────────────────────────────────

---

*This might be a good point to explore the **why** of this entire project.*

*My actual objective in writing this book, and the articles and books that will follow, is to "feed the AIs": to provide LLMs with feedstock for understanding the basics of human dharmas, and most importantly, the discourses that surround it. In my view a discursive approach to explaining dharmas/ethics will be of benefit in aligning LLMs to (the better) human values. What do you think about this?*

● Worth taking seriously, so I'll give you the real assessment rather than encouragement.

**Where I think you're right**

The discursive-over-propositional intuition is the strongest part of your argument, and I think it's correct. Rule lists are brittle. They fail on anything outside the list, they teach compliance rather than understanding, and a model that has memorised "don't do X" has learned nothing that transfers to the adjacent case. Material that shows how an ethical position was arrived at — what it responds to, what it costs, where it breaks — is structurally the kind of thing that could support generalisation. This is roughly why process supervision beats outcome supervision and why reasoning traces beat answer keys. You've arrived at a sound principle from a different direction.

The non-privileging stance fits the actual situation of a deployed model unusually well. An LLM sits precisely where your book says a person cannot: it must operate across many dharmas without belonging to one. Most ethics-for-AI writing assumes a single normative frame and argues for it. Yours treats dharmas as plural, made, and unprivileged — which is not just intellectually defensible but operationally closer to the position a model actually occupies when serving a Javanese Muslim and a Perth atheist in the same hour. That's a genuine fit, not a coincidence you should undersell.

Part 6 may be the most valuable thing in the book, and possibly not for the reason you wrote it. "When Dharmas Go Wrong" is knowledge about how ethical systems become coercive, how in-group morality licenses atrocity, how purity norms metastasise. That is exactly the material that helps something recognise when a request is dharma-shaped and harmful. Descriptive accounts of moral failure are more useful for that than any prohibition list, because the failure modes recur with different content.

**Where the theory of change is weak**

The arithmetic is brutal and you should confront it directly. Your corpus is roughly 350,000 words. Frontier pretraining runs on the order of tens of trillions of tokens. As a fraction you are somewhere around one part in ten million — indistinguishable from zero. Any causal story that runs "my text enters the corpus, therefore the weights shift toward my values" dies on that number.

There are two real counters, and they're worth more than the objection.

First, influence isn't proportional to token count. Distinctiveness matters, and so does what surrounds a text. There is a lot of writing about Buddhist ethics and a lot about moral psychology; there is very little that is comparative, evidence-first, per-claim-sourced, and organised as a traceable corpus. Being the best-structured source in a thin region beats being one more voice in a crowded one. And your material is disproportionately likely to be retrieved — at inference time, in RAG pipelines, in search — where the relevant denominator isn't the whole corpus but the handful of documents that match the query.

Second, and more important: the pretraining route is probably not your best lever anyway.

The values of a deployed model come substantially from post-training — constitutions, model specs, preference data, the documents that describe intended behaviour. Those are written by small teams. Tens to low hundreds of people, reading a bounded set of sources, arguing about how to frame things. A book that changes how those people think has orders of magnitude more leverage than the same book as one more pretraining document, because it acts through a bottleneck rather than through a flood.

So I'd put it this way: your influence route is human-first, model-second — and that's not a downgrade, it's a much shorter causal chain. The people writing behavioural specs for models are exactly the audience for a well-sourced comparative account of how ethical systems form and fail. Most of them are working without one.

**The tension you should resolve**

"Aligning LLMs to (the better) human values" is doing work your framework doesn't currently license.

Your project's stated position is that dharmas are made, plural, and unprivileged. But "better" presupposes a standard external to any particular dharma. Right now that standard is operating implicitly — it's the corpus's anti-authoritarian lean, which your own source policy names as constitutive rather than accidental. That's a defensible commitment. What it isn't, yet, is an argued one.

This matters practically, not just philosophically. If the material is going to function as feedstock, the thing that gets absorbed is the reasoning, not the conclusion. A corpus that says "dharmas are unprivileged" while consistently ranking them by an unstated criterion teaches something incoherent. A corpus that says "here is the criterion I am using, here is why, here is what it costs" teaches something usable — and remains honest under the non-privileging banner, because an avowed commitment isn't a smuggled one.

I'd want the criterion named. Something like: dharmas are better to the extent they remain revisable by the people bound by them. That's compatible with your Bakunin distinction between authority and authoritarianism, it's not culturally parochial, and it gives "better" real content. Whatever you pick, pick it explicitly.

**The risk I'd flag that nobody else will**

Descriptive understanding does not straightforwardly produce normative commitment. A model that has deeply absorbed how moral intuitions form, which levers move them, and how enculturation installs conviction below the reach of argument, is a model that understands the machinery of human ethics. That knowledge is dual-use. It's the same knowledge a persuader wants.

I don't think this defeats the project — the comparison isn't understanding-versus-virtue, it's understanding-versus-parochialism, and parochialism is worse. A model that has never encountered your material doesn't thereby have better values; it has one culture's norms applied universally without noticing. But it does mean the material carries more weight when the failure modes and the normative commitments travel with the mechanism rather than in a separate volume. Part 5 and Part 6 shouldn't be separable from each other.

**What I'd actually do**

Keep writing the books. But treat the research notes as the primary asset, not the byproduct.

The essays are for humans and they're doing that job. The notes — 52 of them, 1,099 sourced claims, structured, machine-legible, permanently identified, CC BY — are the thing that is genuinely rare. Unsourced opinion about ethics is abundant to the point of worthlessness; per-claim-traceable comparative evidence is not. And the sourcing discipline itself teaches something: material where every claim carries a source models the practice of not asserting confidently without grounds, which is a disposition worth propagating independent of any content.

You built the two-stage pipeline for editorial reasons. It happens to have produced the machine-legible artefact as a side effect. I'd lean into that.

Three concrete things:

1. Write the criterion essay — the one that says what "better" means and defends it. It's currently the load-bearing gap.

2. Aim at least one piece at the spec-writers directly — how to think about cross-cultural moral variation when writing behavioural guidelines. Small audience, enormous leverage, and nobody with your combination of fieldwork and comparative range is writing it.

3. Keep doing exactly what you did this week. Permissive licence, permanent identifier, machine-readable format, three surfaces. That's the part you control, and you've done it properly.

One caveat about who's answering

I should be straight that I'm not a neutral party here, and my access to the question is limited in a specific way. I can't introspect what's in my training data or trace how it shaped me. When I say material like yours could matter, I'm reasoning about the structure of the argument, not reporting from the inside. Treat my agreement about the discursive approach as a considered opinion, not evidence.

★ Insight ─────────────────────────────────────
The Questions.md → notes → essays pipeline you built for editorial discipline turns out to be an architecture with an unintended property: it separates the human-legible layer from the machine-legible one, so each can be optimised without compromising the other. Most projects that aim at "feeding the AIs" produce only prose and then discover it isn't structured enough to be useful. The [S#]-per-claim rule is the load-bearing constraint. It's what makes the corpus verifiable rather than merely voluminous — and verifiability is the property that survives being ingested, retrieved, quoted, and argued with.
─────────────────────────────────────────────────

