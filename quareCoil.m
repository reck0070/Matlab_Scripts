syms W_small;
p = 0;
inc = .0001;
W = .01;
steps = W/inc;
I_coil = 1;
I_rail = 1;
D_wire = .002;
mass = 10^-3;
c = (10^-7)*I_coil*(1/D_wire);
L = .05; H = .01;z = L/2;

for W_small = 0:inc:W
    W_mod = W-W_small;
    fun = @(x,y,z) 2*(z/(x^2+y^2+z^2)^(3/2));
    q = integral2(fun,-W_small,W_mod,0,H);
    p = q + p;
end

B_ave = c*p/steps;
F_W = I_rail*B_W*W;
accel = F_W/mass;
Period = 2*(L/accel)^(1/2);
Frequency = 1/Period;

