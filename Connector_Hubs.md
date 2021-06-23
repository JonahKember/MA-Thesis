<!--layout: page title: "PAGE TITLE" permalink: /Connector_Hubs/-->
## Connector Hubs

### “Connector hubs could be the conductor of the brain’s neural symphony.”
Bertolero, Yeo, Bassett & D’Esposito (2018)

![image](https://user-images.githubusercontent.com/81769550/123014774-ef661f80-d394-11eb-8e20-e5071aaeb0dd.png)

## Connector Hubs
Across scales, one of the most important characteristics of brain networks is their modularity– the fact that they can be easily divided into distinct subnetworks that show a relatively high degree of within-module connectivity, and a relatively low degree of between-module connectivity. In the context of large-scale functional networks, this modular structure allows for specialized processing to take place in relative independence from irrelevant or disruptive processing. 

Equally important to this modular organization, however, is the ability to integrate the information between these modules. Higher-order, more complex cognitive processes require the combination of a number of lower-level functions, each of which might be localized in some extent to distinct modules. How then do large-scale cortical networks go about integrating the processing between modules? Interestingly, while there are various ways in which they could integrate processing between modules, there is evidence to suggest that natural selection has arrived at one in particular. This method of integration relies on the use of privileged nodes, called connector hubs. Connector hubs are nodes in a network characterized by two distinct properties: their connections are evenly distributed across modules (making them connectors), and they hold a high number of connections with nodes in their own module (making them a hub). 

![image](https://user-images.githubusercontent.com/81769550/123013841-f8ee8800-d392-11eb-9016-0e0d791acaaa.png)

In large-scale functional networks, connector hubs are crucial to cognition. The ability of connector hubs to ‘tune’ their within-module connections (that is, strengthen or weaken the connections they share with other nodes in their module) is thought to be a fundamental mechanism used by the brain for the integration of information between modules. This power that connector hubs hold in influencing the exchange of information in the entire network is what led Bertolero et al. (2018) to describe them as potential “conductors of the brain’s neural symphony”. By tuning their within-module connections, connector hubs effectively gate the transfer of information between modules.

This importance is a double-edged sword, however. When connector hubs are damaged, or when the topology of a functional network is such that no connector hubs exist, networks are inefficient in their ability to influence the level of within- and between-module communication (inefficient in the sense that they require more edges to be changed for the same change in modularity). When this occurs, wide-spread cognitive impairments can arise. 

Recently, research by Hiller & Fiebach (2019) found that the level of integration between modules in intrinsic functional brain networks, captured through resting-state fMRI, is reduced in those with attention-deficit/hyperactivity disorder. Given the fundamental mechanism described by Bertolero et al. (2018), this lack of integration might arise from an inability of connector hubs to influence the modularity of the entire network.

If so, we should find a relationship between the ability connector hubs have in influencing network modularity and ADHD symptom severity. Such a relationship would provide associative evidence that weak connector hubs are to blame for the lack of integration between modules in the intrinsically connected functional brain networks found in those with ADHD.

### Identifying and Characterizing Connector Hubs
To identify connector hubs, we need to quantify their two defining properties: the diversity of their connections amongst different modules, and their number of within-module connections. To do so, we’ll use the participation coefficient and the within-module degree, respectively.

#### Participation Coefficient
The participation coefficient measures a node’s tendency to distribute its connections evenly between modules, and is measured as follows:

![image](https://user-images.githubusercontent.com/81769550/123013860-00159600-d393-11eb-9c6b-5f04478e8aa1.png)

Where M is the set of network modules, as determined by a modularity-maximization algorithm (i.e., Louvain), ki is the degree (the number of edges connected to a node) of node i, and ki(mi) is the within-module degree of node i (the number of connections within the module node i belongs to).  

A node with a high participation coefficient distributes its connections evenly amongst all modules and can therefore be referred to as a ‘connector’.

#### Within-Module Degree (Z-Score)
The within module degree simply measures the number of connections a node has with other nodes in its module. By z-scoring this value, we standardize it using the within-module degree distribution for all nodes in the module. This is measured as follows:
 
 ![image](https://user-images.githubusercontent.com/81769550/123015135-b1b5c680-d395-11eb-9012-2b5bfb506d68.png)
 
Where ki(mi) is the within-module degree of node i, k ̅(mi) is the average within module degree of the module m, and the difference between those two is divided by the standard deviation of the within module degree of module m.

This value can be directly interpreted as the number of standard deviations a node’s within-module degree is outside the mean.

### Z-PC Space
After measuring each node along these two dimensions, we can visualize the role of each node by plotting it in ‘Z-PC’ space, where the X-axis corresponds to the node’s participation coefficient, and the Y-axis corresponds to the nodes within module degree z-score:

![image](https://user-images.githubusercontent.com/81769550/123014282-e3c62900-d393-11eb-9173-531dca90728b.png)

In this space, connector hubs are nodes in the top right corner, which show a ‘high’ within module degree z-score as well as a ‘high’ participation coefficient. By defining these thresholds, we can identify the nodes that act as connector hubs. While some research has set distinct boundaries to threshold this space and argued that these values will hold across all networks (WM-Dz = 2.5, PC = .62; Guimerà & Amaral, 2005), other research has chosen values such that all participants being analyzed have at least one connector hub (Cohen, 2014).

### Charaterizing Connector Hubs
The number of connector hubs that exist is the first characteristic of concern. In the context or resting state functional networks in ADHD, it could be that they lack any nodes that have the properties of connector hubs. Indeed, the number of connector hubs in task-based functional networks has been associated with increased working memory demands (Cohen, 2014). 

The next important characteristic is the ability of these connector hubs to influence the modularity of the network. The most intuitive measure that captures this ability might involve changing just one of the connector hub’s within-module connections, measuring the change in modularity, doing this for every possible combination of edges that the connector hub might be able to ‘tune’, and then finding the maximum change that node i was able to initiate. However, for a node with only 12 within-module connections (a conservative estimate), this would require testing 12! (479,001,600) different combinations, which might be computationally difficult. While the right greedy algorithm might be able to render this tractable, there are simpler approaches.

One such approach involves removing all within-module connections held by the connector hub and measuring the change in global modularity that results. By measuring the change in modularity that results from the removal of all the connector hubs within-module edges, we get an approximation of the ability the connector hub has in influencing the entire network’s modularity. To measure this ability, I introduce a new metric, called ‘Jonah’s modularity modulation index (MMI)’ (patent pending):

![image](https://user-images.githubusercontent.com/81769550/123014477-546d4580-d394-11eb-8a35-c86ccb06f1e8.png)

Where n is the number of connector hubs, Q  is the modularity of the original adjacency matrix, and Ax is the adjacency matrix following the removal of all within-module connections from connector hub x.

To break this down, this term:

![image](https://user-images.githubusercontent.com/81769550/123014492-60590780-d394-11eb-9edd-aa9bd978053e.png)

takes the absolute value of the difference in modularity that occurs when a connector hub’s within-module connections are removed. This measures the ability that one connector hub has in influencing the modularity of the network. By taking the absolute value, we are only concerned with the ability of the connector hub to influence the network, not whether the removal of all it’s within-module edges results in a decrease or increase. 

Then, by doing this for all connector hubs, summing these values together, and dividing by n (multiplying by 1 over n):

![image](https://user-images.githubusercontent.com/81769550/123014521-723aaa80-d394-11eb-9268-ff6913e556e4.png)

we are simply measuring the mean ability that all connector hubs have in influencing the modularity of the network. 

## From Controlling Epidemics to Measuring the Influence of the Brain's Connector Hubs
While this metric allows us to get closer, it overlooks some important factors. The ideal measure was actually presented in an article on network analysis by Ghalmane et al. (2019). Their goal was to understand which people in a social network you could target in order to effectively control an epidemic (a perhaps prescient research question). They argued that the people most likley to spread disease, and thus most efficiently targeted by immunization strategies, would have two characteristics: they would propogate the disease within their module to a high degree, while at the same time, propogate the disease to neighbouring modules to a high degree. In other words, these people are connector hubs. 

The benefit of the work by Ghalmane et al. (2019) is that they holistically considered the 5 defining charatersitics of a node in the context of it's ability to act as a connector hub (influence the modularity of the network). These charateristics were: (1) The number of within-module connections held by node i, (2) the number of between-module connections held by node i, (3) the size of the module that node i belongs to, (4) the number of node i's neighbouring modules, and (5) how well-defined node i's module is (is it easily divided into it's own module, or not very easily divided, since connector hubs are more important to integration when a module is very well defined).

They refer to this measure as the Weighted Community-Hub Bridge measure, and it provides a precise measure of the abililty nodes have in the mechanistic framework described by Bertolero et al. (2018), whereby connector hubs 'tune' their connections to influence the integration between modules in the network.

If the resting-state functional networks of those with ADHD show weak between-module integration because their connector hubs lack the ability to effectively initiate said integration, we should find a relationship between the Weighted Community-Hub Bridge measure and ADHD symptom severity.


### Matlab Code for MMI Calculation (Requires the Brain Connectivity Toolbox):

    % Input = n (Node X Node binary adjacency matrix)
    
    %%
    Q = [];
    for rep = 1:25
        [Ci,m] = community_louvain(n,1);
        Q = [Q,m];
    end

    Q = mean(Q);
    Z = module_degree_zscore(n,Ci);
    P = participation_coef(n,Ci);

    ConHubs = find(((Z > 2) + (P > .6)) == 2);    % Decide on thresholds for connector hubs.
    diff = [];

    for num = 1:length(ConHubs)
       Mod = Ci(ConHubs(num));
       find(Ci == Mod);
       i = ConHubs(1);
       A = zeros(1,size(n,1));
         for j = 1:length(n)
           if n(i,j) == 1
           A(j) = 1;
           end
         end

    withinModConns = find(A == 1);
    
    nn = n;
    for h = 1:length(withinModConns)
        nn(withinModConns(h),ConHubs(num)) = 0;
        nn(ConHubs(num),withinModConns(num)) = 0;
    end
    
    newQ = [];
    for rep = 1:25                              % Calculate modularity by taking the average after 25 repetitions.
        [Ci,m] = community_louvain(n,1);
        newQ = [newQ,m];
    end

    newQ = mean(newQ);
    diff(num) = Q - newQ;
    disp(diff(num))
    end
    
    MMI = mean(diff);
