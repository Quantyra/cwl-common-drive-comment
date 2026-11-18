import Mathlib.LinearAlgebra.Matrix.Permanent
import Mathlib.Algebra.BigOperators.Group.Finset.Powerset
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Analysis.SpecialFunctions.Pow.Asymptotics
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.Ring

/-! Finite replica combinatorics and the ideal bare-reference dark endpoint. -/

open Finset Filter
open scoped Topology

namespace CommonDrive

/-- The diagonal identity plus a matrix whose entries are all `c`. -/
def replicaMatrix {R : Type*} [CommSemiring R] (n : ℕ) (c : R) :
    Matrix (Fin n) (Fin n) R := fun i j => c + if i = j then 1 else 0

private theorem diagonalProduct {R : Type*} [CommSemiring R] {n : ℕ}
    (σ : Equiv.Perm (Fin n)) (s : Finset (Fin n)) :
    (∏ i ∈ sᶜ, (if σ i = i then (1 : R) else 0)) =
      if σ ∈ permsOfFinset s then 1 else 0 := by
  classical
  split_ifs with h
  · apply prod_eq_one
    intro i hi
    have hs := mem_compl.mp hi
    exact if_pos (by by_contra hne; exact hs (mem_perms_of_finset_iff.mp h hne))
  · have hex : ∃ i, σ i ≠ i ∧ i ∉ s := by
      by_contra! hf
      exact h (mem_perms_of_finset_iff.mpr (fun {i} hi => hf i hi))
    obtain ⟨i, hne, hi⟩ := hex
    exact prod_eq_zero (mem_compl.mpr hi) (if_neg hne)

/-- The rank-one permanent expansion, valid for every replica count and scalar. -/
theorem permanent_replicaMatrix {R : Type*} [CommSemiring R] (n : ℕ) (c : R) :
    (replicaMatrix n c).permanent =
      ∑ k ∈ range (n + 1), (n.descFactorial k : R) * c ^ k := by
  classical
  unfold Matrix.permanent replicaMatrix
  simp_rw [Fintype.prod_add, prod_const, diagonalProduct]
  rw [sum_comm]
  calc
    _ = ∑ s : Finset (Fin n), (s.card.factorial : R) * c ^ s.card := by
      apply sum_congr rfl
      intro s _
      simp only [mul_ite, mul_one, mul_zero, sum_ite_mem, univ_inter,
        sum_const, nsmul_eq_mul, card_perms_of_finset]
    _ = _ := by
      have h := sum_powerset_apply_card (fun k => (k.factorial : R) * c ^ k)
        (x := (univ : Finset (Fin n)))
      simpa [Nat.descFactorial_eq_factorial_mul_choose, nsmul_eq_mul, mul_assoc,
        mul_left_comm, mul_comm] using h

/-- The finite falling-factorial sum with the negative entry fixed to `-1/N`. -/
noncomputable def factor (N m : ℕ) : ℝ :=
  ∑ k ∈ range (m + 1), (m.descFactorial k : ℝ) * (-(N : ℝ)⁻¹) ^ k

-- Separating the constant term leaves a scalar times the preceding sum.
private theorem factor_succ (N m : ℕ) :
    factor N (m + 1) = 1 - ((m + 1 : ℕ) : ℝ) / N * factor N m := by
  unfold factor
  rw [sum_range_succ']
  simp only [Nat.succ_descFactorial_succ, Nat.cast_mul, pow_succ,
    Nat.descFactorial_zero, Nat.cast_one, pow_zero, mul_one]
  rw [mul_sum]
  rw [sub_eq_add_neg, ← sum_neg_distrib, add_comm (1 : ℝ)]
  congr 1
  apply sum_congr rfl
  intro k _
  ring

private theorem factor_unit_interval {N : ℕ} (hN : 0 < N) (m : ℕ) (hm : m ≤ N) :
    0 ≤ factor N m ∧ factor N m ≤ 1 := by
  induction m with
  | zero => simp [factor]
  | succ m ih =>
    obtain ⟨h0,h1⟩ := ih (by omega)
    have hNr : (0 : ℝ) < N := by exact_mod_cast hN
    have hratio : ((m+1 : ℕ) : ℝ) / N ≤ 1 := (div_le_one hNr).mpr (by exact_mod_cast hm)
    have hpos : 0 ≤ ((m+1 : ℕ) : ℝ) / N := by positivity
    rw [factor_succ]
    constructor
    · linarith [mul_le_one₀ hratio h0 h1]
    · linarith [mul_nonneg hpos h0]

/-- A polynomial lower bound suffices for the root limit. -/
theorem factor_bounds {N : ℕ} (hN : 2 ≤ N) :
    (N : ℝ)⁻¹ ≤ factor N N ∧ factor N N ≤ 1 := by
  obtain ⟨m,rfl⟩ : ∃ m, N = m + 2 := ⟨N-2, by omega⟩
  have hpos : (0 : ℝ) < (m:ℝ)+2 := by positivity
  -- For N = m + 2, the upper bound on the preceding sum gives factor N m ≥ 2/N.
  have hm : 2 / ((m : ℝ)+2) ≤ factor (m+2) m := by
    cases m with
    | zero => norm_num [factor]
    | succ j =>
      have hu := (factor_unit_interval (N := (j+1)+2) (by omega) j (by omega)).2
      rw [factor_succ]
      push_cast
      apply (div_le_iff₀ (by positivity)).2
      field_simp
      nlinarith [mul_le_mul_of_nonneg_left hu (show (0:ℝ) ≤ j+1 by positivity)]
  -- Two recurrence steps give factor N N = (N-1)/N * factor N (N-2).
  constructor
  · rw [show m+2 = (m+1)+1 by omega, factor_succ, factor_succ]
    push_cast
    field_simp at hm ⊢
    nlinarith [mul_le_mul_of_nonneg_left hm (show (0:ℝ) ≤ m+1 by positivity)]
  · exact (factor_unit_interval (by omega) _ (le_refl _)).2


private theorem factor_root :
    Tendsto (fun n : ℕ => (factor n n) ^ ((1 : ℝ) / n)) atTop (𝓝 1) := by
  apply tendsto_of_tendsto_of_tendsto_of_le_of_le'
    (tendsto_rpow_neg_div.comp (tendsto_natCast_atTop_atTop (R := ℝ)))
    (tendsto_const_nhds (x := (1 : ℝ)))
  · filter_upwards [eventually_ge_atTop 2] with n hn
    change (n : ℝ) ^ (-(1 : ℝ) / n) ≤ _
    rw [neg_div, Real.rpow_neg (by positivity), ← Real.inv_rpow (by positivity)]
    exact Real.rpow_le_rpow (by positivity) (factor_bounds hn).1 (by positivity)
  · filter_upwards [eventually_ge_atTop 2] with n hn
    obtain ⟨hl,hu⟩ := factor_bounds hn
    simpa using Real.rpow_le_rpow (le_trans (by positivity) hl) hu
      (show (0 : ℝ) ≤ 1 / n by positivity)

private theorem dark_permanent (n : ℕ) :
    (replicaMatrix n (-(n : ℂ)⁻¹)).permanent = (factor n n : ℂ) := by
  rw [permanent_replicaMatrix]
  unfold factor
  push_cast
  rfl

/-- The Nth root of the squared modulus of the ideal bare-reference dark
endpoint amplitude tends to the squared modulus of the relative amplitude. -/
theorem ideal_dark_weight (a : ℂ) :
    Tendsto (fun n : ℕ =>
      (‖(a • replicaMatrix n (-(n : ℂ)⁻¹)).permanent‖ ^ 2) ^ ((1 : ℝ) / n))
      atTop (𝓝 (‖a‖ ^ 2)) := by
  have hlim := ((tendsto_const_nhds (x := ‖a‖)).mul factor_root).pow 2
  apply (by simpa using hlim : Tendsto _ _ (𝓝 (‖a‖ ^ 2))).congr'
  filter_upwards [eventually_ge_atTop 2] with n hn
  have hn' : (n : ℝ) ≠ 0 := by exact_mod_cast (show n ≠ 0 by omega)
  have hf : 0 ≤ factor n n := le_trans (by positivity) (factor_bounds hn).1
  simp only [Matrix.permanent_smul, Fintype.card_fin, dark_permanent, norm_mul,
    norm_pow, Complex.norm_real, Real.norm_eq_abs, abs_of_nonneg hf]
  have root_pow : (‖a‖ ^ n) ^ ((1 : ℝ) / n) = ‖a‖ := by
    rw [← Real.rpow_natCast_mul (norm_nonneg a),
      show (n : ℝ) * (1 / n) = 1 by field_simp, Real.rpow_one]
  have root_sq (x : ℝ) (hx : 0 ≤ x) :
      (x ^ 2) ^ ((1 : ℝ) / n) = (x ^ ((1 : ℝ) / n)) ^ 2 := by
    rw [← Real.rpow_natCast_mul hx, mul_comm ((2 : ℕ) : ℝ), Real.rpow_mul_natCast hx]
  rw [root_sq _ (by positivity), Real.mul_rpow (by positivity) hf, root_pow]
  simp only [one_div]

/-- For comparison, setting the relative amplitude to zero leaves a constant
matrix. Its permanent carries the factorial from counting all permutations. -/
theorem collective_only_amplitude (n : ℕ) (u : ℂ) :
    (Matrix.of (fun _ _ : Fin n => u / n)).permanent =
      (n.factorial : ℂ) * (u / n) ^ n := by
  simp [Matrix.permanent, Fintype.card_perm, nsmul_eq_mul, div_pow]

#print axioms collective_only_amplitude
#print axioms permanent_replicaMatrix
#print axioms factor_bounds
#print axioms ideal_dark_weight

end CommonDrive
