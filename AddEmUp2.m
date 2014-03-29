function Q = AddEmUp2(G,NumCoils,Steps)
    for i = 1:(Steps + 1)
        for j = 1:(NumCoils - 1)
            G(i,1) = G(i,1) + G(i,j + 1);
        end
    end
    
    Q = G(:,1);
end

