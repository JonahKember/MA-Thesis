<!--layout: page title: "PAGE TITLE" permalink: /Connector_Hubs/-->

## “Connector hubs could be the conductor of the brain’s neural symphony.” #### Bertolero, Yeo, Bassett & D’Esposito (2018)

![image](https://user-images.githubusercontent.com/81769550/123014774-ef661f80-d394-11eb-8e20-e5071aaeb0dd.png)

### Connector Hubs
Across scales, one of the most important characteristics of brain networks is their modularity– the fact that they can be easily divided into distinct subnetworks that show a relatively high degree of within-module connectivity, and a relatively low degree of between-module connectivity.

In the context of large-scale functional networks (like those recorded from EEG or fMRI and which index the shared neural activity between distinct regions) this modular structure allows for specialized processing, like that required for distinct cognitive functions, to take place in relative independence from irrelevant or disruptive processing. 

Equally important to this modular organization, however, is the ability to integrate the information between these modules. Higher-order, more complex cognitive processes require the combination of a number of lower-level functions, each of which might be localized to some extent to distinct modules. How then do large-scale cortical networks integrate the processing between modules? There are various ways in which they could integrate processing between modules, yet there is evidence to suggest that natural selection has arrived at one in particular. This method of integration relies on the use of privileged nodes, called connector hubs. Connector hubs are nodes in a network characterized by two distinct properties: their connections are evenly distributed across modules (making them connectors), and they hold a high number of connections with nodes in their own module (making them a hub). 

![image](https://user-images.githubusercontent.com/81769550/123013841-f8ee8800-d392-11eb-9016-0e0d791acaaa.png)

In large-scale functional networks, connector hubs are crucial to cognition. The ability of connector hubs to ‘tune’ their within-module connections (that is, strengthen or weaken the connections they share with other nodes in their module) is thought to be a fundamental mechanism used by the brain for the integration of information between modules. This power that connector hubs hold in influencing the modularity of the entire network is what led Bertolero et al. (2018) to describe them as potential “conductors of the brain’s neural symphony”. By tuning their within-module connections, connector hubs effectively gate the transfer of information between modules.

This importance is a double-edged sword, however. When connector hubs are damaged, or when the topology of a functional network is such that no connector hubs exist, networks are limited in their ability to influence the level of within- and between-module communication, and wide-spread cognitive impairments can arise. 

Recently, research by Hiller & Fiebach (2019) found that the level of integration between modules in intrinsic brain networks, captured through resting-state fMRI, is reduced in those with attention-deficit/hyperactivity disorder. Given the fundamental mechanism described by Bertolero et al. (2018), this lack of integration might arise from an inability of connector hubs to influence the modularity and communication between modules of the global network.
By examining the ability connector hubs have in influencing network modularity, and correlating this ability with ADHD symptoms severity, we could provide associative evidence that this is the case; that weak connector hubs are to blame for the lack of integration between modules in the intrinsically connected functional brain networks found in those with ADHD.

### Identifying and Characterizing Connector Hubs
To identify connector hubs, we need to quantify their two defining properties: the diversity of their connections amongst different modules, and their high number of within-module connections. To do so, we’ll use the participation coefficient and the within-module degree z-score, respectively.

#### Participation Coefficient
The participation coefficient measures a node’s tendency to distribute its connections evenly between modules, and is measured as follows:

![image](https://user-images.githubusercontent.com/81769550/123013860-00159600-d393-11eb-9c6b-5f04478e8aa1.png)

Where M is the set of network modules, as determined by a modularity-maximization algorithm (i.e., Louvain), ki is the degree (the number of edges connected to a node) of node i, and ki(mi) is the within-module degree of node i (the number of connections within the module node i belongs to).  

A node with a high participation coefficient distributes its connections amongst all modules and can therefore be referred to as a ‘connector’.

#### Within-Module Degree Z-Score
The within module degree z-score simply measures the number of connections a node has with other nodes in its module (within-module degree) and standardizes this using the distribution of within-module degree for all nodes in the module. This is measured as follows:
 
Where ki(mi) is the within-module degree of node i, k ̅(mi) is the average within module degree of the module m, and the difference between those two is divided by the standard deviation of the within module degree of module m.

Because this value has been z-scored, the value can be directly interpreted as the number of standard deviations a node’s within-module degree is outside the mean.

### Z-PC Space
After measuring each node along these two dimensions, we can visualize the role of each node by plotting it in ‘Z-PC’ space, where the X-axis corresponds to the node’s participation coefficient, and the Y-axis corresponds to the nodes within module degree z-score:

![image](https://user-images.githubusercontent.com/81769550/123014282-e3c62900-d393-11eb-9173-531dca90728b.png)

 
In this space, connector hubs are nodes in the top right corner, which show a ‘high’ within module degree z-score (above some artificial threshold, commonly ~2), as well as a ‘high’ (commonly above ~.6) participation coefficient. By defining these thresholds, we’ve now identified the nodes that might act as connector hubs.

### Charaterizing Connector Hubs
The number of connector hubs that exist is the first characteristic of concern. In the context or resting state functional networks in ADHD, it could be that they lack any nodes that have the properties of connector hubs. The next important characteristic is the ability of these connector hubs to influence the modularity of the network. 

Ideally, a measure that captures tha bility of a connector hube to inlfuence the modularity of the netire network might involve changing just one of the connector hub’s within-module connections, measuring the change in modularity, and then doing this for every possible combination of edges that the connector hub might be able to ‘tune’. However, for a node with only 12 within-module connections (a conservative estimate), this would require testing 12! (479,001,600) different combinations, which might be computationally difficult. 

A simpler approach involves removing all within-module connections held by the connector hub and measuring the change in global modularity that results. By measuring the change in modularity that results from the removal of all the connector hubs within-module edges, we get an appropriate approximation of the ability of the connector hub to influence the entire network’s modularity.

It is important to note that the impact the removal of a connector hub’s within-module edges has on the modularity of the network is entirely dependent on the specific topology of the network. For some topologies, the removal of a connector hub’s within-module edges results in an increase in global modularity, and for others, it results in a decrease. 

To measure the ability of connector hubs to influence the modularity of the network, I introduce a new metric, ‘Jonah’s modularity modulation index (MMI)’:

![image](https://user-images.githubusercontent.com/81769550/123014477-546d4580-d394-11eb-8a35-c86ccb06f1e8.png)

Where n is the number of connector hubs, Q  is the modularity of the original adjacency matrix, and Ax is the adjacency matrix following the removal of all within-module connections from connector hub x.

To break this down, this term:

![image](https://user-images.githubusercontent.com/81769550/123014492-60590780-d394-11eb-9edd-aa9bd978053e.png)

takes the absolute value of the difference in modularity that occurs when a connector hub’s within-module connections are removed. This measures the ability that one connector hub has in influencing the modularity of the network. By taking the absolute value, we are only concerned with the ability of the connector hub to influence the network, not whether the removal of all it’s within-module edges results in a decrease or increase. 

Then, by doing this for all connector hubs, summing these values together, and dividing by n (multiplying by 1 over n):

![image](https://user-images.githubusercontent.com/81769550/123014521-723aaa80-d394-11eb-9268-ff6913e556e4.png)


we are simply measuring the mean ability that all connector hubs have in influencing the modularity of the network. 

#### More thoughts…
The number of connector hubs is an important and distinct measure from the ability those hubs have to moudlate the network. However, one interesting idea is to combine the number of modules, and this ability into one metric. To do so, we could divide the MMI by a factor proportional to the number of connector hubs that exist:

![image](https://user-images.githubusercontent.com/81769550/123014602-9a2a0e00-d394-11eb-9794-f3064093bfce.png)

Where α is an arbitrary parameter between zero and 1. When the alpha parameter is 1, this would simplify tothe MMI. As the alpha-parameter approaches zero, however, we give greater and greater weight to networks with more connector hubs– we say that they are better able to influence the modularity of the network. The ‘optimal’ alpha parameter requires one to decide how much weight to give to the number of connector hubs, and how much weight to give to the ability of connector hubs. This depends on answering the question: is a network better able to use the ‘connector hub tuning mechanism’ to integrate processing if it has more connector hubs (smaller alpha parameter), or stronger connector hubs (larger alpha parameter)? 
