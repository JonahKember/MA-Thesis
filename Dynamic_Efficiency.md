<!--layout: page title: "PAGE TITLE" permalink: /Dynamic_Efficiency/-->

 ## Measuring Dynamic Efficiency
 
'Dynamic efficiency' measures the potential for information to be disseminated between nodes based on how the structure of the network changes with time. A network with high dynamic efficiency could send information from every node _i_ to every node _j_ in a short amount of time, at every point in time of the network.

Dynamic efficiency measures the 'broadcast centrality' of each node, and averages these values across every node in the network. Broadcast centrality is a measure that assumes  information travels along every possible path, through a method called 'diffusion' (i.e., a node sends information from one node to all of its neighbouring nodes).It measures this ability by taking the number of paths through time that connect two nodes, while downweighting paths that take a longer amount of time (the downweight parameter scales inversely with the amount of time it takes to traverse the path; measured as _alpha_ to the power _t_, where _alpha_ is a parameter between 0 and 1, and _t_ is the temporal path length).

This is in contrast to measures like global efficiency, which assume that information is disseminated along the shortest route. Now, in reality, information transfer between large-scale brain areas likely relies on a balance of both shortest-path routing and diffusion. Relying solely on either is associated with large metabolic costs. Using shortest path routing, for example, requires information about the global topology of the whole network (which is metabolically expensive). While using diffusion requires that a large number of signals are sent in order for information to reach a target in an appropriate amount of time (which is also metabolically expensive). Despite this reality, diffusion-based measure of dynamic efficiency rely on calculations that are much more computationally efficient, allowing us to measure the ability of nodes to disseminate information in networks with a relatively large number of time steps.

Interestingly, the calculation of broadcast centrality is computationally efficient because it relies on an a fundamental characteristic of adjacency matrices. That is, if we take the product of time-neighboring adjacency matrices (A) (i.e., A1 multiplied by A2, multiplied by AN...), then element _ij_ in the resulting matrix will represent the number of dynamic walks from node _i_ to _j_ that are N steps long. 

### Example:

![adjmat multiplication](https://user-images.githubusercontent.com/81769550/114958954-11da3a80-9e32-11eb-9e12-b64ecfc6844e.PNG)

In the resulting matrix, element _ij_ represents the number of paths between _i_ and _j_ that are 3 time points long. 

### Calculation:

Therefore, when we sum the product of consecutive adjacency matrices in a dynamic network (while downweighting longer paths):

      alpha^1 * A1
    + alpha^2 * A1 * A2
    + alpha^3 * A1 * A2 * A3
    ...
    + alpha^N * A1 * A2 ... * AN

While using each time as a starting point, i.e.:

    alpha^1 * A2
    + alpha^2 * A2 * A3
    + alpha^3 * A2 * A3 * A4
    ...
    alpha^1 * A3
    + alpha^2 * A3 * A4
    + alpha^3 * A3 * A4 * A5
    ...
    alpha^1 * A4
    + alpha^2 * A4 * A5
    + alpha^3 * A4 * A5 * A6
    ...

Then we get a matrix that records the sum of every possible dynamic path that node _i_ could take to node _j_ from time _t_ to time _t_ + _n_, (so long as _n_ > _t_, assuming that the brain can only send information forwards through time- not backwards).

When we average across the network, we get a global measure of dynamic efficiency.

### Code:

Dynamic Efficiency can be measured with the following code, where the alpha calue is slected as in Grindrod et al. (2011).

**dynamicEfficiency**:

    function [nodeBC, globalBC] = dynamicEfficiency(Network)
  
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
