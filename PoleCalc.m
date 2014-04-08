%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Single_Coil_Number = 1;
R = 10;                                 %big radius
r = 5;                                  %bore radius
NumPoles = 2;                          %number of poles
Steps = 1000;
fringe = 0;                           %fringe angle
NumCoils = 3;                          %number of coils
z = NumPoles/2;                         %coefficient to make sine zero at theta = 0 and theta = t_2
phi = pi/(NumCoils);                  %angle between coil centers

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t_2 = ((2*pi)/NumPoles) - fringe;      %angle subtended by magnet
c_angle = (4*pi)/(NumCoils);             %angle subtended by coil
t_step = (2*pi)/Steps;                 %increment step size for theta/tau
Const = (R^2 - r^2)*(c_angle/2);       %constant value
F = zeros(Steps + 1,NumPoles + NumCoils,NumCoils);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
i = 0;                                 %index for array values
for theta = 0:t_step:2*pi
    i = i + 1;
    
    if (theta >= 0) && (theta <= c_angle) && (theta <= t_2)
        F(i,1,1) = Overlap1(z,t_step,theta);
    elseif (theta > c_angle) && (theta <= t_2)
       F(i,1,1) = Overlap2(z,t_step,theta,c_angle);
    elseif (theta > t_2) && (theta <= c_angle)
       F(i,1,1) = Overlap4(z,t_step,t_2);
    elseif (theta > t_2) && (theta <= (t_2 + c_angle))
        F(i,1,1) = Overlap3(z,t_step,theta,c_angle,t_2);    
    
    
        
    end
end

B = F;
spp = Steps/NumPoles;           %steps per pole
for j = 1:(NumPoles - 1)
    q = round(spp);
    B = circshift(B,q);
    B = B*(-1)^j;
    F(:,j + 1,1) = B(:,1,1);
end


C = F;
spphi = (phi*Steps)/(2*pi);          %spphi = phi in steps

for k = 1:(NumCoils - 1)
    r = round(spphi);
    C = circshift(C,r);
    F(:,:,k + 1) = C(:,:,1);
end
% P = F(:,:,2);
% plot(P)
P = AddEmUp(F,NumPoles,NumCoils,Steps);
P = P * Const;
Q = AddEmUp2(P,NumCoils,Steps);

close all force


figure
h1 = subplot(2,2,1);
plot(P(:,Single_Coil_Number));
title('Flux linkage Single Coil')


h2 = subplot(2,2,2);
plot(P);
title('Flux linkage/All Coils')


h3 = subplot(2,2,[3,4]);
plot(Q);
title('Total Flux')




    
   
        
       
    
    
    
