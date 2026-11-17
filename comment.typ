#set document(title: [Comment on “Testing quantum gravity using pulsed optomechanical systems”], author: "Daniel Fredriksen", keywords: ("optomechanics", "correlated worldline theory", "Schrödinger–Newton model"))
#set page(paper: "us-letter", margin: (top: 0.78in, bottom: 0.75in, x: 0.87in), numbering: "1")
#set text(font: "Libertinus Serif", size: 12pt, lang: "en")
#set par(justify: true, leading: 0.62em, spacing: 0.78em)
#set heading(numbering: none)
#show heading.where(level: 1): it => block(above: 0.75em, below: 0.45em, text(size: 13pt, weight: "semibold", it.body))
#align(center)[
  #text(size: 17pt, weight: "semibold")[Comment on “Testing quantum gravity using pulsed optomechanical systems”] \
  #v(4pt)
  #link("https://orcid.org/0009-0002-9123-7435")[Daniel Fredriksen] \
  #text(size: 10pt)[Quantyra Inc. · November 17, 2026]
]
#v(3pt)
*Abstract.* Wilson-Gerow, Chen, and Stamp predict different photon-count probabilities for correlated worldline (CWL) and Schrödinger–Newton (SN) gravity in a two-pulse optomechanical experiment. We rederive their first-swap comparison at one laser drive and detuning. The CWL collective mechanical mode has the ordinary frequency, while each relative mode has the SN frequency. For the prescribed replica endpoints, the large-replica limit gives the relative-mode transition probabilities for both photon outcomes. The SN/CWL zero-photon ratio is therefore one in the specified rotating-wave model. The ideal zero-photon probability in either gravity model is $pi^2 epsilon^4/4 + O(epsilon^6)$. We also identify a first-order discrepancy between two equations in the published derivation and quantify the limitation imposed by the counter-rotating interaction at a fixed pulse strength.

= What is held fixed
Wilson-Gerow, Chen, and Stamp [1] give the CWL zero-photon probability in their Eq. (126) and the SN probability in Eq. (138). For the first swap, their leading coefficients of $epsilon^4$ are $pi^2/(16e^2)$ and $pi^2/16$, respectively. The comparison turns on which oscillator defines the pulse area. A fractional change of order $epsilon^2$ in an area near perfect return creates a zero-photon probability of the very order being compared. The external position drive and the laser frequency therefore have to be specified before expanding that probability.

There is also a discrepancy within the CWL equations. Put $h=epsilon^2$. In Eq. (107) of Ref. [1] the term in $i dot(B)$ proportional to the optical mean $A$ is $g(1+h)A$. Averaging the individual mechanical equation (112) with the means in Eq. (110) instead gives $g(1+h/2)A$. Inverting the collective kinetic factor $1-h$ in Eq. (105) recovers the former coefficient to first order. Repairing this factor alone would leave unresolved how to implement both hypotheses at one laser setting.

Write $omega=omega_m$, $Omega^2=omega^2+omega_"SN"^2$ and $h=omega_"SN"^2/(2 Omega^2)$. We use units with $ℏ=1$. Let $F(t) q(a+a^dagger)$ be the linearized interaction, where $F(t)$ specifies the classical intracavity drive in position units. For a canonical oscillator of frequency $nu$,
$ q = (c+c^dagger)/sqrt(2m nu), quad g_nu(t)=F(t)/sqrt(2m nu), quad
  g_Omega/g_omega = (1-2h)^(1/4) = r. $
The last factor also appears in the journal's SN calculation, Eqs. (127)–(131). Independent references for mass, bare stiffness, intracavity field, pulse timing and laser frequency would specify these inputs experimentally. We assume these reference values in the calculation.
#pagebreak()
= Two sectors of one pulse sequence
Take two same-phase rectangular pulses, each of duration $t_p=pi/(2g_*)$, at laser detuning $-omega$ relative to the cavity. The ordinary coupling during an ideal pulse is $g_*=omega/20$. The drive vanishes for a hold $T=t_p$ between pulses. The initial preparation is one cavity photon and the centered mechanical ground state of each model. There is no intermediate measurement. Small pulse offsets $d_i$ refer to the ordinary area, so that the two shifted-mode areas are $r(pi/2+d_i)$. Using the same symbol for the two models’ nominal areas without specifying $F$ would miss this shift.

For $N$ CWL replicas let $J$ be the all-ones matrix and $Pi=J/N$. From Eqs. (85)–(86) of Ref. [1], the squared-frequency matrix is $omega^2 Pi + Omega^2 (I-Pi)$. Rotate both the mechanical and optical coordinates by the same orthogonal matrix that diagonalizes $Pi$. The summed position interaction stays diagonal. The collective pair evolves with mechanical frequency $omega$ and coupling $g_omega$. Each relative pair evolves with frequency $Omega$ and coupling $g_Omega$. In the SN model joint parity of the centered initial state is preserved by the bilinear drive. The mechanical first moment consequently vanishes and the SN self-potential in Eq. (13) gives the oscillator at $Omega$. This argument uses the specified preparation throughout the unobserved pulse sequence.

In the frame rotating at $omega$, the number-conserving Hamiltonian in either sector is $H_nu=g_nu(t)X+(nu-omega)Q$. Here $X$ exchanges the optical and mechanical excitation, and $Q$ projects onto the mechanical excitation. Define $a_(0,nu)$ and $a_(1,nu)$ as the final mechanical and optical amplitudes, respectively, for optical input. For $delta=d_1+d_2$, $a_(0,omega)=i sin delta$ and $a_(1,omega)=-cos delta$. At perfect ordinary area, the excitation returns to the cavity exactly in this approximation.

To first order in $h$, $r=1-h/2+O(h^2)$ and $Omega-omega=omega h+O(omega h^2)$. The shift of the two areas gives $-i pi h/2$ in the final mechanical amplitude. The first-order detuning insertion is proportional to the time integral of $cos(pi-phi)sin phi$, where $phi(t)$ is the nominal accumulated ordinary pulse angle. The integrand vanishes on the hold. Reflection of the two ideal ramps about $phi=pi/2$ cancels their integrals. Consequently,
$ a_(0,Omega)=i(delta-pi h/2)+O(h^2), quad a_(1,Omega)=-1+O(h). $
These remainders are uniform for $abs(d_i)<=h/100$ at the fixed frequency ratio. For example, the integrated first-order perturbation norm is below $100h$ since $omega(2t_p+T)=30pi$. The integrated Taylor remainder is below $210h^2$ for $h<=0.01$. A second Duhamel insertion bounds the propagator remainder by $210h^2+(105h)^2/2$. Thus $10^4h^2$ suffices for the displayed mechanical-amplitude error. At $delta=0$ the SN dark probability is $pi^2h^2/4+O(h^3)$. An unknown $delta$ comparable with $h$ changes that coefficient; $delta=o(h)$ suffices to recover it.
#pagebreak()
= Why the replica normalization matters
Sector propagation alone does not determine a CWL photon probability. Ref. [1] first differentiates the coherent-state kernel once in every replica, takes the $N$th root of each squared endpoint amplitude, and then normalizes the two weights. For a photon count $j$ let $a_j=a_(j,Omega)$ be the relative amplitude and $u_j$ the collective amplitude including the outgoing endpoint metric. Equation (114) gives $u_1=a_(1,omega)$ and $u_0=sqrt(omega/Omega) a_(0,omega)$: the canonical collective annihilator is $sqrt(omega/Omega)$ times the paper's collective mechanical variable in Eq. (90). In particular $u_0=0$ at perfect ordinary area. The endpoint metric leaves this zero exact.

Returning to physical replica labels gives the matrix $a_j I+(u_j-a_j)Pi$. Differentiation gives its permanent. Write $z=(u_j-a_j)/a_j$ when $a_j != 0$. Choosing the $k$ columns contributed by $Pi$ leaves $k!$ permutations on those columns. With $(N)_k=N!/(N-k)!$, the endpoint amplitude obeys the finite identity
$ K_(j,N)/a_j^N = sum_(k=0)^N (N)_k (z/N)^k
   = integral_0^infinity e^(-t)(1+z t/N)^N dif t. $
The integral follows by expanding the binomial and integrating each power of $t$. At the ideal dark endpoint $z=-1$. The integral on $0<=t<=N$ tends to $1/2$ by dominated convergence, and the absolute tail is $e^(-N)N!/N^N$. Thus the ratio $K_(0,N)/a_0^N$ tends to a nonzero constant. Its squared modulus contributes a factor of one after the $N$th root.

The argument survives small offsets in the physical drive. For $0<h<=10^(-6)$ and $abs(d_i)<=h/100$, the previous bounds give $abs(z+1)<0.1$ at the dark endpoint and $abs(z)<=1/4$ at the bright endpoint. For the dark disk write $z=-1+xi$ and $eta=0.1$. On $[0,N]$ the absolute integrand is bounded by $exp(-(2-eta)t)$. On $t=N+s$ the absolute tail is at most
$ e^(-N)(1+eta)^N exp(N eta/(1+eta)) N!/N^N. $
It decays exponentially by Stirling's formula. The dark integral therefore tends uniformly to $1/(1-z)$. For the bright endpoint the coefficients $(N)_k/N^k$ are bounded by one and tend to one at each fixed $k$, so geometric domination gives the same nonzero limit there.

It follows that the two rooted weights are $abs(a_(j,Omega))^2$. They already sum to one by unitarity of the shifted two-mode evolution. At fixed positive $h$ in this range, taking the replica limit before the weak-gravity limit gives
$ P_"CWL"(j) = P_"SN"(j) = abs(a_(j,Omega))^2, quad j=0,1. $
The change from Ref. [1] concerns what is zero at ideal calibration. For a pulse calibrated to the shifted relative mode, its dark amplitude vanishes and the rank-one collective matrix produces the factorial suppression in Eq. (122). For a pulse calibrated to the ordinary reference at the same laser drive, the collective dark amplitude vanishes instead. The relative amplitude then survives the replica root. Applying the earlier suppression to this second matrix would change the predicted observable.
#pagebreak()
= Scope of the optical prediction
For the specified first swap, the common-drive calculation gives an SN/CWL dark-count ratio of one. At the nominal area each probability equals $pi^2 epsilon^4/4+O(epsilon^6)$. The equality of both photon probabilities holds in the rotating-wave model throughout the area interval above. Predictions for a physical apparatus additionally require the terms discarded in arriving at a one-excitation model.

An ordinary-quantum example shows the scale of this issue. Keep the same pulse settings and restore $g_*(a+a^dagger)(c+c^dagger)$ in the quadratic Hamiltonian. At zero gravity the free hold rotates both modes through $10pi$, so the two pulses concatenate to time $t=pi/g_*$. The symmetric and antisymmetric optical–mechanical coordinates have frequencies $omega_+ = sqrt(omega(omega+2g_*))$ and $omega_- = sqrt(omega(omega-2g_*))$. Their Bogoliubov coefficients are
$ u_± = cos(omega_± t)-i (omega ± g_*)/(omega_±) sin(omega_± t). $
Even the single final state with zero photons and one phonon contributes the probability
$ B = abs(1/u_+^* - 1/u_-^*)^2/(4 abs(u_+ u_-)) approx 1.56738 times 10^(-5). $
To obtain this expression, write the input and output as the sum and difference of the two one-quantum normal-mode states. Each mode preserves parity. For each mode the ratio of the one-particle and vacuum diagonal amplitudes is $1/u^*$, and the vacuum probability is $1/abs(u)$. These give the expression above. Its value is strictly positive: the phase angles are $pi sqrt(440)$ and $pi sqrt(360)$, whose cosines differ because neither the sum nor the difference of the two square roots is an even integer.

This is a lower bound on an ordinary zero-count probability at fixed drive strength. At $h=10^(-6)$ the nominal rotating-wave gravity rate is about $2.47 times 10^(-12)$. A subtraction could remove an independently known background. To infer a physical coefficient, however, the subtraction would have to control the difference of probabilities at order $o(h^2)$ and include all mechanical final states compatible with zero optical photons. Pair creation opens additional outcomes, outside the two exclusive endpoints used in the passive calculation. The calculation here establishes a change to the approximate comparison in Ref. [1]; the full experimental ratio remains open.

*Data availability.* This analytical work uses no experimental dataset. The manuscript source and a reproducible arithmetic check accompany this preprint. #link("https://github.com/Quantyra/cwl-common-drive-comment")[github.com/Quantyra/cwl-common-drive-comment].

*Use of AI.* OpenAI Codex (GPT-6.2-Astra, xhigh reasoning) assisted with source comparison, mathematical derivation, verification code and manuscript preparation. The author specified the common-drive question, the source equations and the decision criteria. The accompanying checks reproduce the pulse propagator and finite-replica amplitudes computationally. These checks were AI-assisted. This preprint precedes final human verification for journal submission.

*Reference* \
[1] J. Wilson-Gerow, Y. Chen, and P. C. E. Stamp, “Testing quantum gravity using pulsed optomechanical systems,” #emph[Phys. Rev. D] *109*, 064078 (2024). #link("https://doi.org/10.1103/PhysRevD.109.064078")[doi:10.1103/PhysRevD.109.064078].
