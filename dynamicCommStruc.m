function dynamicCommStruc = dynamicCommStruc(staticCommStruc, minJaccard)
%% Detect Dynamic Community Structure 
%   
%   After detecting the community structure for static adjacency matrices over time, assess the similarity between time-neighbouring communities at time (t) and time (t+1)). 
%   For each community in the (t + 1) vector, redefine it as the community in vector (t) with the highest similarity. 
% 
%   To measure the similarity between a community at time (t) and (t + 1), first use the community affiliation vector to create an individual adjacency matrix for each community.
%   To compare these two time-neighbouring matrices, take the subdiagonal at (t) and the corresonding subdiagonal at (t + 1), and evaluate their jaccard-index. Do this for each
%   subdiagonal pair of the two matrices (from the 1st subdiagonal to the (node - 1)th subdiagonal), and take the average value as a metric of similarity between communities. 
%  
%   After assessing the similarity between each community at (t) with each community at (t + 1), reassign each community at (t + 1) as the community with which it is most 
%   similar. If two communities fail to meet the minimum similarity value ('minJaccard'), assign them random values. If two communities at (t + 1) share a community with which
%   they are most similar, they will be considered the same community.
%   
%   Jaccard-Index: Size of the intersection of two sets divided by the size of the union of two sets.
% 
%  INPUT:
%               
%            staticCommStruc      =    [Node X Time] matrix with the community affiliation of each node for every time point (detected from static adjacency matrices).
%            minJaccard            =   Minimum similarity required to be considered the same community (0 to 1).    
%               
%  OUTPUT:           
%
%            dynamicCommStruc    =    [Node X Time] matrix with the community affiliation of each node for every time point. 
%                                     Communities at (t) correspond to the communities with which they were most similar to at (t - 1).
%
%Reference:
% 
% Cherifi, H., Szymanski, B.K. et al. On community structure in complex networks: challenges and opportunities.
%       Appl Netw Sci 4, 117 (2019). https://doi.org/10.1007/s41109-019-0238-9
%
%% Assign Each Community a Unique Value
 
time = size(staticCommStruc,2);                             
r = rand(time,1);                                           

for n = 1:time
    staticCommStruc(:,n) = staticCommStruc(:,n) + r(n);
end

for timeOne = 1:size(staticCommStruc,2)-1
    timeTwo = timeOne + 1;

%% Create a Matrix for each Community at time point (t) and (t + 1), then measure the similarity between each pair of communities

A_vector = staticCommStruc(:,timeOne);
B_vector = staticCommStruc(:,timeTwo);

A_mat = zeros(length(A_vector));
B_mat = zeros(length(B_vector));

for n = 1:length(A_vector)
    for nn = 1:length(A_vector)                             
        if A_vector(n) == A_vector(nn)
            A_mat(n,nn) = A_vector(n);
         end
    end
end

for n = 1:length(B_vector)
    for nn = 1:length(B_vector)       
        if B_vector(n) == B_vector(nn)
            B_mat(n,nn) = B_vector(n);
         end
    end
end

A_mat(find(A_mat == 0)) = max(max(A_mat))+1;
B_mat(find(B_mat == 0)) = max(max(B_mat))+1;

commStrucSim = [];  

uniqueANZ = unique(A_mat);
if length(uniqueANZ) ~= 1       
uniqueANZ = uniqueANZ(uniqueANZ ~= max(max(A_mat)));
end
uniqueBNZ = unique(B_mat);
uniqueBNZ = uniqueBNZ(uniqueBNZ ~= max(max(B_mat)));

for n = 1:length(uniqueANZ)
    numa = unique(A_mat);
    A_bin = A_mat == numa(n);                       
    j = [];
    J =[];
   
    for nn = 1:length(uniqueBNZ)
        numb = unique(B_mat);
        B_bin = B_mat == numb(nn);
       
        for kk = 1:127
            a_diag = diag(A_bin,kk);
            b_diag = diag(B_bin,kk);
            a = find(a_diag == 1);
            b = find(b_diag == 1);
            jac = length(intersect(a,b))/length(union(a,b));
            if isnan(jac)  
               jac = 0;
            end
            J = [J,jac]; 
        end
    J = mean(J);
    j = [j,J];
    end
    commStrucSim = [commStrucSim;j];  % 'commStrucSim' is a matrix that shows the similarity between every possible pair of communities.
end
    if size(commStrucSim,1) == 1 
    commStrucSim(2,:) = commStrucSim;
end

%% For each community in time point (t + 1), reassign it the value of the community with which it is most similar to in time (t)

[simOfNeighbour,locationSimNeighbour] = max(commStrucSim); %locationSimNeighbour is a vector telling which communities in timeB (columns) correspond to which communities in timeA (rows)
       
        numa = unique(staticCommStruc(:,timeOne));
        numb = unique(staticCommStruc(:,timeTwo));
        
for nn = 1:length(simOfNeighbour)
    if simOfNeighbour(nn) > minJaccard  
        changeFrom = numb(nn);
               changeTo = numa(locationSimNeighbour(nn));          
               staticCommStruc(:,timeTwo) = changem(staticCommStruc(:,timeTwo),changeTo,changeFrom);
    else            
               changeFrom = numb(nn); 
               changeTo = rand(1);
               staticCommStruc(:,timeTwo) = changem(staticCommStruc(:,timeTwo),changeTo,changeFrom);           
    end
end

dynamicCommStruc = staticCommStruc;
end
end
