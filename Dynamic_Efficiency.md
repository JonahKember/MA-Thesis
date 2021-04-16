<!--layout: page title: "PAGE TITLE" permalink: /Dynamic_Efficiency/-->

 ## Measuring Dynamic Efficiency
 
The measure referred to as 'dynamic efficiency' is the broadcast centrality of each node averaged across the whole network. Broadcast centrality is a measure of 
dynamic communication that assumes information travels along every possible path, through a method called 'diffusion' (i.e., a node sends information from one node to all of its 
neighbouring nodes). This is in contrast to methods which assume information is disseminated along the shortest route. 

Now, in reality, information transfer between large-scale brain areas likely relies on a balance of both shortest-path routing and diffusion. Relying solely on either is associated with large metabolic costs. Using shortest path routing, for example, requires information about the global topology of the whole network (which is metaboically expensive). While using diffusion requires that a large number of signals are sent in order for information to reach a target in an appropriate amount of time and with a strong enough signal (which is also metabolically expensive).


Despite this, using diffusion measures of efficiency allow us to rely on calculations that are much more computationally efficient, allowing us to examine the ability of nodes 
to disseminate information in networks with a relatively large number of time steps. Interstingly, the calculation of broadcast centrality is computationally
efficient because it relies on an a fundamental characteristic of adjacency matrices. That is, if we take the product of time-neighboring adjacency matrices (A) (i.e., A1 multiplied by A2, multiplied by AN), then element _ij_ in the resulting matrix will count the number of dynamic walks from node _i_ to _j_ that are N steps long. 

### Example:

![adjmat multiplication](https://user-images.githubusercontent.com/81769550/114958954-11da3a80-9e32-11eb-9e12-b64ecfc6844e.PNG)


Therefore, when we sum the product of consecutive adjacency matrices in a dynamic network (i.e., A1 * A2 * AN... + A2 * A3 * AN... + A3...), we get a matrix 
that records the sum of every possible path from time _t_ to time _t_ + _n_, so long as _n_ > _t_ (which, conveniently, respects our assumption that the brain
sends information forwards through time- not backwards).
