<!--layout: page title: "PAGE TITLE" permalink: /Dynamic_Efficiency/-->

![static](https://user-images.githubusercontent.com/81769550/115120060-70f69700-9f79-11eb-819b-cada6557d943.PNG)

Describing the features of functional networks is an important first step towards understanding the mechanisms that underlie cognition, and how these mechanisms might be altered in neuropsychiatric disorders. In addition to description, however, a mechanistic understanding requires an understanding of what manipulations to the system might give rise to the observations we make empirically. By using a model- a statistical process that generates synthetic data, and interpreting the parameters of our model through biological mechanisms, we can begin to understand the manipulations that might give rise to the empirical data that we observe. 

How might we go about creating a simple model of a dynamic network? One characteristic of functional networks that holds the potential for dynamic models is the behaviour of network modules. Modules are sub-networks of nodes that tend to have lots of connections with each other, and relatively few connections outside of themselves. If we think of something like social networks, this is a very intuitive concept- a friend group would be easily divided into a module.

Modules have consistently been shown to play an important role during cognition. Cognitive processing is dependent on both the local processing of highly connected modules (which have very specialized functions), as well the integration of these locally dense areas with each other. Therefore, we might be able to charaterize the dynamic process of cognition through how these modules behave over time. By adjusting these parameters- how nodes tend to behave with nodes inside and outside of their modules, we can better understand the mechanisms that might give rise to our empirically observed data.

Here, I present a simple dynamic network model based on this idea. The foundation of this model is from a paper by Habiba & Berger-Wolf (2013). The parameters of their model include: (1) the temporal length of the network (i.e., the number of time-points), (2) the number and size of modules, (3) the probability that a node will form a connection with a node inside of its module, (4) the probability that a node will form a connection with a node outside of its module, and (5) the probability that a node will switch modules at each time-point. 

The original intention of this model was for these probability parameters (how modules behave) to be held constant. However, I have added on the ability for these parameters to change over time. This more accurately reflects the changes that functional brain networks undergo during cognition. One way to reflect how a parameter might change over time (i.e., as a result of a perturbation to the system, which we can think of as someting like 'Inhibit execution of a response'), is to change the probability at each time point as a function of a gaussian curve:

![GaussianCurves](https://user-images.githubusercontent.com/81769550/115119744-f9743800-9f77-11eb-990d-80ad59fcb907.PNG)

One of the parameters of this model is the maximum value of this curve. Three values are shown in the above example (2,3 and 4), with a constant value of .02 added on for realism.

When we hold the other parameters of the model constant (i.e., as a straight line), then we can observe the role of this parameter on the system. Here's a video of a dynamic network generated through this model, where the probability of a within-module connection existing changes over time, while the other two parameters (outside-module connections and module-switching) remain constant. As you can see, the dynamic network becomes much more modular at around _t_ = 5, when the probability of a within-module connection existing reaches its maximum value of .32.

<iframe width="560" height="315" src="https://www.youtube.com/embed/JRf4cEFVmuE" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

### Code:
The model can be used with the function *modelDynamicNetwork*:

      function Network = modelDynamicNetwork(T,C,ProbIntra,ProbInter,ProbSwitch,Weight)

      if length(ProbInter) == 1
      ProbInter = ones(1,T)*ProbInter;else;end   
      if length(ProbIntra) == 1
      ProbIntra = ones(1,T)*ProbIntra;else;end   
      if length(ProbSwitch) == 1
      ProbSwitch = ones(1,T)*ProbSwitch;else;end     
      
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
            if r < ProbSwitch(t)
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
                  if r < ProbIntra(t)  
                     if Weight == 0
                    A(i,j) = 1;
                   else
                   A(i,j) = rand(1);
                   end
                    else
                    A(i,j) = 0;    
                end
             else 
                  if r < ProbInter(t)   
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
