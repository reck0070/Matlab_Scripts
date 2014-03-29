function P = AddEmUp(F,NumPoles,NumCoils,Steps)
    for i = 1:NumCoils
        for j = 1:(Steps + 1)
            for k = 1:(NumPoles - 1)
                F(j,1,i) = F(j,1,i) +F(j,k + 1,i);
            end
        end
    end
    for l = 2:NumCoils
        F(:,l,1) = F(:,1,l);
    end
    P = F(:,1:NumCoils,1);
end

