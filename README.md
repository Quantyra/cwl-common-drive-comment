# Comment on “Testing quantum gravity using pulsed optomechanical systems”

Daniel Fredriksen · Quantyra Inc. · [ORCID](https://orcid.org/0009-0002-9123-7435)

[Read the preprint (PDF)](comment.pdf) · [Editable manuscript](comment.typ) · [Paper under discussion](https://doi.org/10.1103/PhysRevD.109.064078)

For one specified ordinary-referenced laser pulse train, the first-swap rotating-wave calculation gives equal photon probabilities under correlated worldline and centered Schrödinger–Newton dynamics. The proof uses the two normalized replica endpoint weights. The final section bounds a background present when counter-rotating terms are retained. The physical count ratio beyond the rotating-wave approximation remains open.

This branch contains the Comment submitted to *Physical Review D* on November 17, 2026, after author verification. The journal received the four-page [submitted manuscript](comment.pdf). [Three-model review and disposition](review/disposition.md) and [earlier Zenodo preprint](https://doi.org/10.5281/zenodo.24326219).

## Reproduce the arithmetic and PDF

Using Python with mpmath 1.4.1, run `python verify.py` from this directory. The checks use matrix exponentials for the pulse sequence, direct permutation enumeration at small replica numbers, and a quadrature calculation for the unaveraged ordinary background. The manuscript proves the replica limit analytically. Run `python verify_physical_slope.py` for the inclusive centered SN response. The [slope derivation](review/centered-sn-slope.md) states the normalization and the physical scope.

Build with Typst 0.15.2 using `typst compile comment.typ comment.pdf`, or with the Python typst package of the same version using `python -c "import typst; typst.compile('comment.typ', output='comment.pdf')"`.

## Lean certificate for the ideal dark endpoint

The Comment derives a replica matrix from the pulse and readout model. At ideal bare calibration its collective dark amplitude vanishes. For relative amplitude $a$, the resulting matrix is $K_N = a(I-J/N)$, where every entry of $J$ is one. Starting from this matrix, Lean proves for every complex $a$ that

$$
\lim_{N\to\infty} \left(\left|\operatorname{perm} K_N\right|^2\right)^{1/N}=|a|^2.
$$

The proof expands the permanent of $I+cJ$ over subsets for arbitrary $N$ and $c$. For $c=-1/N$ a recurrence bounds its real permanent between $1/N$ and $1$ for every $N\ge2$. Both bounds have replica root tending to one. The manuscript also derives the sharper unrooted limit of $1/2$. A comparison theorem gives the finite permanent $N!(u/N)^N$ when the relative amplitude vanishes and only the collective amplitude $u$ remains. [Lean source](lean/Replica.lean)

This certificate covers the algebra and the ideal dark-endpoint limit in the section “Why the replica normalization matters.” Connecting the matrix to the pulse model, controlling calibration offsets, checking the bright endpoint and normalizing the photon probabilities remain manuscript arguments. The full quadratic detector response is outside this certificate.

### Reproduce the kernel check

Use Lean 4.33.0 and [Mathlib commit db584cd](https://github.com/leanprover-community/mathlib4/tree/db584cd6d46c92f209a44c0f1c829460d327499d). The example below starts at the root of this repository in a POSIX shell with Elan and Git installed. If you already have a Lake workspace with this Mathlib revision and its compiled imports, run the final command there with `cert_dir` set to this repository's `lean` directory.

```sh
set -eu
cert_dir="$(pwd)/lean"
work_dir="$(mktemp -d)"
git clone --quiet https://github.com/leanprover-community/mathlib4.git "$work_dir/mathlib4"
cd "$work_dir/mathlib4"
git checkout --quiet --detach db584cd6d46c92f209a44c0f1c829460d327499d
awk '$1 == "import" {print $2}' "$cert_dir/Replica.lean" | xargs lake exe cache get
out_dir="$(mktemp -d)"
lake env sh -c '
  set -eu
  lean -DwarningAsError=true -R "$1" -o "$2/Replica.olean" "$1/Replica.lean"
  LEAN_PATH="$2:$LEAN_PATH" leanchecker -v Replica
' sh "$cert_dir" "$out_dir"
```

The compiler reported only `propext`, `Classical.choice` and `Quot.sound` for all four public theorems. `leanchecker` replayed the compiled module against the pinned imports. The replay uses the Lean kernel and trusts those imports.

The manuscript and accompanying materials use [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/).
