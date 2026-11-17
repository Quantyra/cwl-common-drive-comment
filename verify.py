"""Numerical cross-checks for the common-drive preprint, using mpmath."""
from itertools import permutations
from math import factorial
import mpmath as mp

mp.mp.dps = 65
I = mp.j
pi = mp.pi
eye = mp.eye
X = mp.matrix([[0, 1], [1, 0]])
Q = mp.diag([0, 1])
t = pi / 2       # ordinary g_* = 1
omega = 20


def close(actual, expected, tolerance, name):
    error = abs(actual - expected)
    if error > tolerance:
        raise AssertionError(f"{name}: {mp.nstr(error, 10)} > {tolerance}")


def propagate(frequency, d1, d2):
    # Independent piecewise matrix exponential, in the common laser frame.
    detuning = frequency - omega
    r = mp.sqrt(omega / frequency)
    def pulse(offset):
        return mp.expm(-I * (r * (1 + offset / t) * X + detuning * Q) * t)
    return pulse(d2) * mp.expm(-I * detuning * Q * t) * pulse(d1)


def permanent_direct(n, z):
    # Relative-normalized matrix I + z J/N. Direct permutation enumeration.
    matrix = [[int(row == col) + z / n for col in range(n)] for row in range(n)]
    return sum(mp.fprod(matrix[i][p[i]] for i in range(n))
               for p in permutations(range(n)))


def permanent_sum(n, z):
    return sum(mp.mpf(factorial(n)) / factorial(n-k) * (z/n)**k
               for k in range(n+1))


def passive_checks():
    for h in map(mp.mpf, ["1e-6", "1e-7", "1e-8", "1e-14"]):
        shifted = omega / mp.sqrt(1 - 2*h)
        for d1, d2 in [(0, 0), (h/100, h/100), (h/100, -h/100), (-h/100, -h/100)]:
            uml = propagate(mp.mpf(omega), d1, d2)
            usn = propagate(shifted, d1, d2)
            close(uml[1,0], I * mp.sin(d1+d2), mp.mpf("1e-55"), "ordinary amplitude")
            close(usn[1,0], I*(d1+d2-pi*h/2), 10000*h*h, "shifted amplitude")
            close(sum(abs(usn[j,0])**2 for j in (0,1)), 1, mp.mpf("1e-55"), "unitarity")
            for row in (1,0):
                a = usn[row,0]
                u = uml[row,0] * (mp.sqrt(omega/shifted) if row == 1 else 1)
                z = u/a - 1
                assert abs(z+1) < mp.mpf(".1") if row == 1 else abs(z) < mp.mpf(".25")
                for n in (2,3,5):
                    close(permanent_direct(n,z), permanent_sum(n,z), mp.mpf("1e-55"), "permanent")
            if d1 == d2 == 0:
                coeff = abs(usn[1,0]/h)**2
                print("h =",mp.nstr(h,2)," shifted zero probability/h^2 =",mp.nstr(coeff,15))
                # Squaring |a/h + i*pi/2| <= 1e4*h gives this finite-h bound.
                close(coeff, pi**2/4, (pi+10000*h)*10000*h, "nominal coefficient")
    for n in (10,30,60):
        dark = permanent_sum(n,mp.mpf(-1))
        assert abs(dark-mp.mpf(".5")) < 1/n


def unaveraged_check():
    # Ordinary vacuum-click probability by quadrature evolution; independent
    # exclusive one-phonon lower bound from two scalar Bogoliubov coefficients.
    J = mp.matrix([[0,1,0,0],[-1,0,0,0],[0,0,0,1],[0,0,-1,0]])
    hessian = omega*eye(4)
    hessian[0,2] = hessian[2,0] = 2
    pulse = mp.expm(J*hessian*t)
    S = pulse*mp.expm(J*omega*t)*pulse
    M = S[:2,:]
    Ma = M[:,:2]
    D = eye(2) + M*M.T
    V = D**-1 * Ma*Ma.T
    inclusive = 2*(1-V[0,0]-V[1,1])/mp.sqrt(mp.det(D))
    def bog(sign):
        frequency = mp.sqrt(omega*(omega+2*sign))
        return mp.cos(2*t*frequency) - I*(omega+sign)/frequency*mp.sin(2*t*frequency)
    up, um = bog(1), bog(-1)
    exclusive = abs(1/up.conjugate()-1/um.conjugate())**2/(4*abs(up*um))
    assert 0 < exclusive < inclusive
    close(inclusive,mp.mpf("0.00001567375972373"),mp.mpf("1e-14"),"inclusive background")
    print("exclusive =",mp.nstr(exclusive,15)," inclusive =",mp.nstr(inclusive,15))


if __name__ == "__main__":
    passive_checks()
    unaveraged_check()
    print("Arithmetic checks passed. The infinite-replica result is proved in the manuscript.")
