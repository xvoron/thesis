"""
Not working, frac non linear
"""
import sympy as sp

x = sp.Symbol('x')
dx = sp.Symbol('dx')
m = sp.Symbol('m')
p = sp.Symbol('p')
C1 = sp.Symbol('C1')
C2 = sp.Symbol('C2')
V0 = sp.Symbol('V0')
S = sp.Symbol('S')

f = C1 * m * 1/(V0 + x*S) - C2 *S * dx * 1/(V0 + x*S)
print(sp.factor(f))
f_x = sp.diff(f, x)
f_x = sp.factor(f_x)

print(f_x)
jacob = sp.jacobi(f)

print(jacob)


