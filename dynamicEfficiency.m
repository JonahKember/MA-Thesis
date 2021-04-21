function [nodeBC, globalBC] = dynamicEfficiency(Network)
%%
%
%       Here, dynamic efficiency is measured using the broadcast centrality (Mantzaris et al., 2013). Broadcast centrality measures the potential
%       for each node to communicate with every other node in the network through diffusion, where information travels along each possible path.
% 
%       Finding the Alpha value: First, the absolute eigenvalue of each static adjacency matrix is found. For the highest value found, 
%       the inverse is taken, and this represents the highest possible alpha value (Grindrod et al., 2011). The midpoint between 
%       zero and this value is then taken as the appropriate alpha value.
%
%   INPUTS:
% 
%               Network     =   [Node X Node X Time], 3-Dimensional array with static adjacency matrices over time
% 
%   OUTPUTS:
%   
%               nodeBC      =   Broadcast centrality of each node
%               globalBC    =   Broadcast centrality averaged across every node in the network
% Reference:
% 
%    Grindrod, P., Parsons, M., Higham, D., & Estrada, E. (2011). Communicability across evolving networks. 
%     Physical Review. E, Statistical, Nonlinear, and Soft Matter Physics, 83(4 Pt 2), 046120–046120. 
%     https://doi.org/10.1103/PhysRevE.83.046120
% 
%    Mantzaris, A., Bassett, D., Wymbs, N., Estrada, E., Porter, M., Mucha, P., Grafton, S., & Higham, D. (2013). 
%     Dynamic network centrality summarizes learning in the human brain. Journal of Complex Networks, 1(1), 
%     83–92. https://doi.org/10.1093/comnet/cnt001
%
%%

time = size(Network,3);
nNodes = size(Network,1);

%% Choose an Appropriate Alpha Value

eigenVals = zeros(nNodes,time);

for n = 1:time  
eigen = eig(Network(:,:,n));
eigenVals(:,1) = eigen;
end

eigenVals = abs(eigenVals);
maxAlpha = 1/max(max((eigenVals)));
alpha = maxAlpha/2;

%% Compute Local and Global Broadcast Centrality

matResolvents = [];

for n = 1:time
q = (eye(128) - (alpha*((Network(:,:,n)))))*-1;
matResolvents = cat(3,matResolvents,q);
end

for n = 1:(time - 1)
   matResolvents(:,:,1) = matResolvents(:,:,1)*matResolvents(:,:,(n+1));
end

P = matResolvents(:,:,1);
Q = P/norm(P);

nodeBC = zeros(nNodes,1);
bc = zeros(nNodes,1);

for i = 1:nNodes
    for j = 1:nNodes
        if j ~= i
        bc(j) = Q(i,j);
        else
        bc(j) = 0;
        end
    end
    nodeBC(i) = mean(bc);
end

globalBC = mean(nodeBC);
end
