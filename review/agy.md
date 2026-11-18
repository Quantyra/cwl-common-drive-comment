# Referee Report

**Manuscript Title:** Comment on “Testing quantum gravity using pulsed optomechanical systems”  
**Author:** Daniel Fredriksen  
**Target Journal:** *Physical Review D* (Comments section)  
**Verdict:** **Major Revision** (Unsuitable for publication in current form; requires substantive reframing from a "correction" of Ref. [1] to an analysis of protocol calibration dependence).

---

### Scope of Review and Verification Statement
This report was prepared independently based strictly on the provided Typst source and the orienting source facts. **External links (including the Caltech Library repository link for Ref. [1] and the GitHub repository) were not opened or consulted.**

* **What was checked independently:**
  1. *Permanent identity and large-$N$ limit (Section 3):* I independently evaluated the matrix permanent $K_{j,N} = \mathrm{perm}[a_j I + (u_j - a_j)\Pi]$ and verified the integral representation $\int_0^\infty e^{-t}(1 + z t/N)^N dt$. For $u_0 = 0$ ($z = -1$), dominated convergence on $[0,N]$ yields $\int_0^\infty e^{-2t} dt = 1/2$, with exponential tail suppression. The $N$-th root $|K_{0,N}|^{2/N} \to |a_{0,\Omega}|^2 \cdot (1/2)^{2/N} = |a_{0,\Omega}|^2$ is mathematically correct.
  2. *First-order pulse dynamics (Section 2):* Verified that for identical rectangular pulses and a symmetric hold, the first-order detuning integral $\propto \int \sin(2\phi)\,dt$ vanishes by reflection symmetry across $\phi = \pi/2$, leaving only the pulse-area mismatch $-i\pi h/2$.
  3. *Non-RWA background (Section 4):* Checked the Bogoliubov normal-mode frequencies $\omega_\pm$ and verified the single-quantum background coefficient $B \approx 1.57 \times 10^{-5}$.
* **What was not checked:** Uncited derivations and full intermediate steps of Ref. [1] outside of Eqs. (85)–(138).

---

### Conceptual Assessment: Protocol Modification vs. Common-Input Correction
The headline equality $P_{\mathrm{CWL}}(0) = P_{\mathrm{SN}}(0)$ (yielding an SN/CWL ratio of 1) is **not** a mathematical correction of an error in Wilson-Gerow, Chen, and Stamp (WCS, Ref. [1]). It is the consequence of evaluating an entirely different physical calibration:
* **WCS Protocol:** Calibrates detuning ($\Delta = -\Omega$) and pulse area to the shifted mechanical resonance $\Omega$, enforcing $a_{0,\Omega} = 0$. In CWL, this leaves only the rank-one collective mode non-vanishing ($u_0 \neq 0$), producing the factorial suppression $(N!/N^N)^{2/N} \to e^{-2}$ and the resulting $e^2$ ratio.
* **Comment Protocol:** Calibrates detuning ($\Delta = -\omega$) and pulse area to the unshifted bare frequency $\omega$, enforcing $u_0 = 0$. Under this choice, the relative modes are detuned and under-rotated ($a_{0,\Omega} \neq 0$). Because the relative sector is full-rank ($N-1$ modes), its amplitude survives the replica limit without factorial suppression.

Presenting ratio 1 as an objective correction of Ref. [1]'s prediction mischaracterizes a calibration convention as an algebraic refutation.

---

### Numbered Findings

1. **Severity: Critical — Conflation of Operational Protocol with Derivation Correction.**  
   The Abstract and Section 1 claim to "rederive their first-swap comparison" and conclude that the ratio is "therefore one." This is misleading. Calibrating the laser to the bare mechanical frequency $\omega$ assumes *a priori* experimental knowledge of an unobservable parameter (in the presence of gravity, the physical resonance is $\Omega$). If an experimentalist calibrates to the measured physical resonance $\Omega$, WCS's $e^2$ ratio remains intact.

2. **Severity: Major — Destruction of Discriminative Power.**  
   If the experimentalist adopts the Comment's proposed calibration ($\Delta = -\omega$), both theories predict $P(0) \approx \pi^2\epsilon^4/4$. The protocol completely loses its ability to distinguish CWL from Schrödinger–Newton gravity. The Comment must state prominently that this calibration renders the experiment insensitive to the distinction it was designed to test.

3. **Severity: Moderate — Physical Irrelevance under Counter-Rotating Background.**  
   Section 4 correctly computes an ordinary non-RWA background $B \approx 1.57 \times 10^{-5}$, dwarfing the gravitational signal ($2.47 \times 10^{-12}$ at $h = 10^{-6}$) by seven orders of magnitude. The Comment cannot claim in the Abstract that the zero-photon probability is $\pi^2\epsilon^4/4 + O(\epsilon^6)$ without caveat; that expression is an unobservable rotating-wave abstraction.

4. **Severity: Minor (PRD Policy) — Premature AI Verification Statement.**  
   The statement *"This preprint precedes final human verification for journal submission"* is disqualifying for *Physical Review D*. A submission must be fully verified and endorsed by the author prior to refereeing.

5. **Severity: Minor — Inconsequential Discrepancy Note.**  
   The discrepancy noted between Eq. (107) [$g(1+h)A$] and Eq. (112) [$g(1+h/2)A$] is an astute observation, but the manuscript concedes it does not alter the downstream issue. It should be condensed to a brief footnote.

---

### Concrete Wording and Derivation Fixes

* **Abstract:** Replace:  
  *“We rederive their first-swap comparison at one laser drive and detuning... The SN/CWL zero-photon ratio is therefore one...”*  
  with:  
  *“We show that the predicted SN/CWL ratio of $e^2$ in Ref. [1] is calibration-dependent: if the pulse drive and detuning are referenced to the bare mechanical frequency rather than the shifted resonance, the replica suppression vanishes and the rotating-wave ratio becomes one, eliminating the leading-order distinction between the models.”*
* **Section 1 (p. 1, col. 2):** Explicitly clarify that setting $\Delta = -\omega$ requires access to the unshifted bare frequency $\omega$, which is operationally distinct from tuning to the active mechanical resonance $\Omega$.
* **Section 4 & Abstract:** Add explicit qualifying text: *"Within the rotating-wave approximation..."* when citing $\pi^2\epsilon^4/4$.
* **End matter:** Remove the sentence stating that human verification is incomplete.
