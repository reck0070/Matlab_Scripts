function var = Overlap4(z,t_step,t_2)
    var = 0;
    for i = 0:t_step:t_2
        B_field = 1;%sin(z * i);
        var = var + B_field;
    end
    var = var*t_step;
end

