"""Check the centered SN inclusive optical zero-count slope at h=0.
Dimensionless units: nominal coupling = 1; bare frequency = 20.
Run with Python and mpmath. No CWL inclusive measurement is assumed.
"""
import mpmath as mp

mp.mp.dps = 55
time = mp.pi / 2
identity = mp.eye
J = mp.matrix([[0, 1, 0, 0], [-1, 0, 0, 0], [0, 0, 0, 1], [0, 0, -1, 0]])


def segment(h, pulse_on):
    frequency = 20 / mp.sqrt(1 - 2*h)
    coupling = (1 - 2*h)**mp.mpf("0.25") if pulse_on else 0
    hessian = mp.diag([20, 20, frequency, frequency])
    hessian[0, 2] = hessian[2, 0] = 2*coupling
    return mp.expm(time * J * hessian)


def trace2(matrix):
    return matrix[0, 0] + matrix[1, 1]


def probability(h):
    pulse = segment(h, True)
    evolution = pulse * segment(h, False) * pulse
    rows = evolution[:2, :]
    optical = rows[:, :2]
    covariance = identity(2) + rows*rows.T
    # Overlap with the optical vacuum for initial |1,0>, mechanics traced out.
    return 2*(1-trace2(covariance**-1 * optical*optical.T))/mp.sqrt(mp.det(covariance))


def segment_and_derivative(pulse_on):
    hessian = identity(4)*20
    hessian[0, 2] = hessian[2, 0] = 2*int(pulse_on)
    derivative = mp.diag([0, 0, 20, 20])
    derivative[0, 2] = derivative[2, 0] = -int(pulse_on)
    block = mp.matrix(8)
    block[:4, :4] = block[4:, 4:] = time * J * hessian
    block[:4, 4:] = time * J * derivative
    exponential = mp.expm(block)
    return exponential[:4, :4], exponential[:4, 4:]


def slope():
    pulse, dpulse = segment_and_derivative(True)
    hold, dhold = segment_and_derivative(False)
    rows = (pulse*hold*pulse)[:2, :]
    drows = (dpulse*hold*pulse + pulse*dhold*pulse + pulse*hold*dpulse)[:2, :]
    optical, doptical = rows[:, :2], drows[:, :2]
    D, dD = identity(2) + rows*rows.T, drows*rows.T + rows*drows.T
    B, dB = optical*optical.T, doptical*optical.T + optical*doptical.T
    inverse = D**-1
    C = inverse * B
    dC = inverse * (dB - dD*C)
    return (-2*trace2(dC) - (1-trace2(C))*trace2(inverse*dD))/mp.sqrt(mp.det(D))


if __name__ == "__main__":
    h = mp.mpf("1e-12")
    # Negative h here is only the analytic extension for a central difference.
    numerical = (probability(h) - probability(-h)) / (2*h)
    derivative = slope()
    assert abs(derivative - numerical) < mp.mpf("1e-17")
    assert abs(derivative + mp.mpf(".01262371118820744")) < mp.mpf("1e-17")
    print("P(0) =", mp.nstr(probability(0), 19))
    print("dP/dh from Frechet derivative =", mp.nstr(derivative, 19))
    print("dP/dh from central difference =", mp.nstr(numerical, 19))
    print("P(1e-6)-P(0) =", mp.nstr(probability(mp.mpf("1e-6"))-probability(0), 19))
