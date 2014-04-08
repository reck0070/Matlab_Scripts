%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
polePairs = 4;
numPhase = 3;
phi = 0;                            % phi > 0 means that there is no coil overlap
                                    % phi < 0 means that there is overlap
fringe = 0;                         % fringe angle = angle between magnets
R = 0.15;                           %outer radius in meters
r = 0.10;                           %inner radius in meters
steps = 100;                       %discretization factor
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
NumCoils = numPhase * polePairs;
c_angle = 2*pi/NumCoils - phi;
p_angle = pi/polePairs - fringe;
area = (c_angle/2)*(R^2 - r^2);
tot_ang = p_angle + c_angle + fringe;
s_size = tot_ang/steps;                %step size
B = 1;
F = zeros((steps + 1)*polePairs*2);
FF = zeros((steps + 1)*polePairs*2); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


for t = 0:s_size:tot_ang

    var = 0;
    if (t > 0) && (t <= c_angle) && (t < p_angle)  % pole area entering coil area, partial overlap
        for i = 0:s_size:t
             var = var + B;
        end
        var = var * s_size;     %multiply by step = reimann sum  

    elseif (t>c_angle) && (t < p_angle)  %pole area covering coil area completely
        for i = 0:s_size:c_angle
             var =  var + B;
        end
        var = var * s_size;

     elseif (t>p_angle) && (t<=c_angle)       %pole area inside coil area completely
        for i = (t - p_angle):s_size:t
            var = var + B;
        end
        var = var * s_size;

     elseif (t>c_angle) && (t>p_angle) && (t<=p_angle + c_angle)      %
        for i = (t - p_angle):s_size:c_angle
            var = var + B;
        end
        var = var * s_size;
    end
    x = round(t/s_size) + 1;
    F(x) = var;
end
%Fill FF(,)
for i = 1:polePairs*2
    P = circshift(F,(i-1)*(steps + 1));
    FF = FF + P*(-1)^i;
end

plot (FF)