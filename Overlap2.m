function var = Overlap2(z,t_step,theta,c_angle)
    var = 0;
    for i = (theta - c_angle):t_step:theta
        B_field = sin(z * i);
        var = var + B_field;
    end
    var = var*t_step;
end

