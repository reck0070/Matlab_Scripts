function x = Flux(t,a,Const,position,y,Step_Size)
    Area = (1/2)*(position - t)* Const;
    B_field = sin(a*t);
    var = B_field*Area*Step_Size;
end
