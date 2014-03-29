syms W_small;
p = 0;
inc = .0001;
W = .01;
steps = W/inc;
I_coil = 2;
I_rail = 1;
D_wire = .002;
mass = 10^-4;
c = (10^-7)*I_coil*(1/D_wire);
L = .01; H = .01;z = 3*L/4;
r = 0;
s = 0;
a = 0;
b = 0;


    for W_small = 0:inc:W
        W_mod = W-W_small;
        fun = @(x,y) z./(x.^2+y.^2+z.^2).^(3/2)+(L-z)./(x.^2+y.^2+(L-z).^2).^(3/2);
        q = integral2(fun,-W_small,W_mod,0,H);
        p = q + p;
    end

    for W_small = D_wire:inc:W+2*D_wire
        W_mod = (W+2*D_wire)-W_small;
        fun = @(x,y) (z+D_wire)./(x.^2+y.^2+(z+D_wire).^2).^(3/2)+(L-z+D_wire)./(x.^2+y.^2+(L-z+D_wire).^2).^(3/2);
        a = integral2(fun,-W_small,W_mod,0,H);
        r = a + r;
    end

    for W_small = 2*D_wire:inc:W+4*D_wire
        W_mod = (W+4*D_wire)-W_small;
        fun = @(x,y) (z+2*D_wire)./(x.^2+y.^2+(z+2*D_wire).^2).^(3/2)+(L-z+2*D_wire)./(x.^2+y.^2+(L-z+2*D_wire).^2).^(3/2);
        b = integral2(fun,-W_small,W_mod,0,H);
        s = b + s;
    end
B_ave = c*(p+r+s)/steps;
F_W = I_rail*B_ave*W
accel = F_W/mass
Period = 2*(L/accel)^(1/2)
Frequency = 1/Period

