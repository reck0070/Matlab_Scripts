function var = Overlap3(z,t_step,theta,c_angle,t_2)
    var = 0;
    for i = (theta - c_angle):t_step:t_2
        B_field = sin(z * i);
        var = var + B_field;
    end
    var = var*t_step;
end

