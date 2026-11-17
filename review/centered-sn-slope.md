# Inclusive optical zero-count derivative in the centered SN model

Hold the bare detuning, physical force, mass and pulse times fixed as in the Comment. Both the optical and mechanical input quadratures have vacuum covariance $I/2$, with one photon added in the optical mode. The mechanical quadratures are scaled to the centered ground state of the oscillator for each $h$. Set $g_*=1$, $\omega=20$, $t_p=T=\pi/2$. With coordinate order $(x_a,p_a,x_c,p_c)$ and $J=J_2\oplus J_2$, the Hessian has diagonal $(20,20,\Omega,\Omega)$ and symmetric entries $H_{13}=H_{31}=2g_\Omega$ during the pulses, zero on the hold. Here $\Omega=20(1-2h)^{-1/2}$ and $g_\Omega=(1-2h)^{1/4}$.

Let $S=e^{t_pJH_p}e^{TJH_f}e^{t_pJH_p}$ and let $M$ consist of its first two rows. Write $A$ for the first two columns of $M$, and $D=I+MM^T$. Use the characteristic function $\chi(v)=\langle e^{i v^T R}\rangle$, for which the vacuum has $\chi(v)=e^{-|v|^2/4}$. The outgoing optical characteristic function of the input $|1,0\rangle$ is $(1-v^T AA^Tv/2)e^{-v^T MM^Tv/4}$. Projection onto the optical vacuum multiplies this function by $e^{-|v|^2/4}$ and integrates with measure $d^2v/(2\pi)$. Gaussian integration gives the inclusive probability

$$
P(h)=\frac{2}{\sqrt{\det D}}\left[1-\operatorname{tr}(D^{-1}AA^T)\right].
$$

For each segment set $L=tJH$. The top-right block of $\exp\bigl(\begin{smallmatrix}L&L'\\0&L\end{smallmatrix}\bigr)$ gives the exact derivative of the segment propagator. At $h=0$, $\Omega'=20$ and the on-pulse $g_\Omega'=-1/2$. The product rule yields $S'$ and differentiation of the displayed probability gives $P'(0)=-0.01262371118820744$ numerically. Direct evaluation gives $P(0)=0.00001567375972367482$ and $P(10^{-6})-P(0)=-1.26174558917\times10^{-8}$. A centered finite difference of step $10^{-12}$ agrees with the block derivative to within $10^{-17}$ using 55-digit arithmetic. No uncertainty certificate is claimed from the numerical precision. [Reproduce the arithmetic](../verify_physical_slope.py).

These are inclusive single-model probabilities under the specified lossless quadratic dynamics, with per-model ground preparation. An inclusive CWL photon probability with pair creation requires a separate measurement calculation. The derivative above supplies neither that probability nor its difference from SN.
