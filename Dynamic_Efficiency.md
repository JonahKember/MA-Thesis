<!--layout: page title: "PAGE TITLE" permalink: /Dynamic_Efficiency/-->

 ## Measuring Dynamic Efficiency
 
The measure referred to here as 'dynamic efficiency' is the broadcast centrality of each node, averaged across the whole network. Broadcast centrality is a measure of 
communication that assumes information travels along every possible path, through a method called 'diffusion' (i.e., a node sends information from one node to all of it's 
neighbouring nodes). This is in conrast to 'routing' methos, which assume information is dissmeinated along the shortest route. In reality, information transfer between 
large-scale brain areas likely relies on a balance of both shortest-path routing and diffusion routing. Relying solely on either is associated with large metabolic costs- using 
shortest path routing requires inforamtion about the global topology of the whole network (which is metaboically expensive), while diffusion routing requires a large number 
of signals to be sent in order to reach a target in an appropriate amount of time and with a strong enough signal (which is also metabolically expensive).


Using diffusion measures of efficiency allows us to rely on calculations that are much more computationally efficient, allowing us to
examine the ability of nodes to disseminate information in networks with a relatively large number of time steps. The calculation of broadcast centrality is computationally
efficient because relies on an a fundamental characteristic of adjacency matrices. That is, if we take the product of time-neighboring adjacency matrices (A) (i.e., A1 multiplied 
by A2, multiplied by AN), then element _ij_ in the resulting matrix will count the number of dynamic walks from node _i_ to _j_ that are N steps long. 

Example:

![adjmat multiplication](https://user-images.githubusercontent.com/81769550/114958954-11da3a80-9e32-11eb-9e12-b64ecfc6844e.PNG)


Therefore, when we sum the product of consecutive adjacency matrices in a dynamic network (i.e., A1 * A2 * AN... + A2 * A3 * AN... + A3...), we get a matrix 
that records the sum of every possible path from time _t_ to time _t_ + _n_, so long as _n_ > _t_ (which, conveniently, respects our assumption that the brain
sends information forwards through time- not backwards).
