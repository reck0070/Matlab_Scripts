function var = Overlap1(z,t_step,theta)
    var = 0;
    for i = 0:t_step:theta
        B_field = 1;% sin(z * i);
        var = var + B_field;
    end
    var = var*t_step;
end

