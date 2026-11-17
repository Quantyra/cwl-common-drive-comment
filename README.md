# Comment on “Testing quantum gravity using pulsed optomechanical systems”

Daniel Fredriksen · Quantyra Inc. · [ORCID](https://orcid.org/0009-0002-9123-7435)

[Read the preprint (PDF)](comment.pdf) · [Editable manuscript](comment.typ) · [Paper under discussion](https://doi.org/10.1103/PhysRevD.109.064078)

For one specified ordinary-referenced laser pulse train, the first-swap rotating-wave calculation gives equal photon probabilities under correlated worldline and centered Schrödinger–Newton dynamics. The proof uses the two normalized replica endpoint weights. The final section bounds a background present when counter-rotating terms are retained. The physical count ratio beyond the rotating-wave approximation remains open.

This branch contains an unreleased [review candidate](review/disposition.md) for the [archived v1.0.0 preprint](https://doi.org/10.5281/zenodo.24326219). Its AI assistance and verification scope are described in the manuscript. Journal submission and human author verification are separate.

## Reproduce the arithmetic and PDF

Using Python with mpmath 1.4.1, run `python verify.py` from this directory. The checks use matrix exponentials for the pulse sequence, direct permutation enumeration at small replica numbers, and a quadrature calculation for the unaveraged ordinary background. The manuscript proves the replica limit analytically. Run `python verify_physical_slope.py` for the inclusive centered SN response. The [slope derivation](review/centered-sn-slope.md) states the normalization and the physical scope.

Build with Typst 0.15.2 using `typst compile comment.typ comment.pdf`, or with the Python typst package of the same version using `python -c "import typst; typst.compile('comment.typ', output='comment.pdf')"`.

The manuscript and accompanying materials use [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/).
