function Network = modelDynamicNetwork(T,C,ProbIntra,ProbInter,ProbSwitch,Weight)
%%        
%         Generate a model of a dynamic network, as described by Habiba & Berger-Wolf (2013). Parameters include the temporal length of the network, the size 
%         of each community, the probability that connections will be wired within modules, the probability that connections will be wired  outside
%         modules, the probability that a node will change allegiance to a module at each time point, and whether the resulting network is binary or weighted.        
%
%   INPUTS 
%           T           =     Number of time-points
%           C           =     [C1,C2,C3...] Community distribution vector (number of nodes per community)
%           ProbIntra   =     Probability that a node shares a connection with a node in its community (0 to 1)
%           ProbInter   =     Probability that a node shares a connection with a node outside its community (0 to 1)
%           ProbSwitch  =     Probability that a node will change communities at each time point (0 to 1)
%           Weight      =     Binary (0) or Weighted (1)
%
%   Output
%           
%           Network     =     [Node X Node] 3-dimensional array over time
% 
%%

At = [];
for n = 1: length(C)
a = repelem(n,C(n));
At = [At,a];
end

uniqueAt = unique(At);
Network = [];


for t = 1:T  
   for n = 1:length(At)
       r = rand(1);
        if r < ProbSwitch
         At(n) = randsample(uniqueAt,1);
        else
        end
   end
 
A = zeros(length(At));

for n = unique(At)
comm = find(At==n);
for i = comm
    for j = 1:length(At)
       r = rand(1);
       if ismember(j,comm) 
            if r < ProbIntra  
               if Weight == 0
               A(i,j) = 1;
               else
               A(i,j) = rand(1);
               end
               else
               A(i,j) = 0;    
            end
       else 
            if r < ProbInter   
               if Weight == 0
               A(i,j) = 1;
               else
               A(i,j) = rand(1);
               end
            else
               A(i,j) = 0;  
            end
       end
    end
end
end

Network = cat(3,Network,A);
end

dynamicPlot(Network)
end
