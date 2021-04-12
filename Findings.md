<!--layout: page title: "PAGE TITLE" permalink: /Findings/-->

## MA Thesis Research

Following the inhibition of a motor response, EEG functional networks in the Alpha-band (8-12Hz) dynamically shift towards a less globally efficient configuration. 

![Alpha_GA_Efficiency](https://user-images.githubusercontent.com/81769550/114312653-5a57c800-9ac1-11eb-8352-e51ee7ab1fa4.PNG)

This shift can be seen from ~300-650 ms in the following video, which shows how Alpha-band networks change from stimulus presentation to 800 ms post-stimulus. In each of the adjacency matrices shown here, EEG sensors are nodes, and two sensors (i.e., _i_ and _j_) communicate with one another if element _ij_ is yellow. The top 10% of cross-trial phase-lag index values, binarized, are used to represent communication. 

<iframe width="560" height="315" src="https://www.youtube.com/embed/FevL_Y_AMjU" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>


Videos like this can be created using the script **dynamicPlot**:


        function  dynamicPlot(network,time)
        %%
        %   Plot adjacency matrices over time.
        %%
        %   INPUTS:
        %            Network           =   3-D array of adjacency matrices over time
        %            Time (optional)   =   Time vector of size(Network,3)
        %%
                
        if exist('time','var')
            else
            time = 1:size(network,3);
        end
        
        for n = 1:length(time)
            imagesc(network(:,:,n));
            xlabel(time(n))
            set(gcf,'color','w');
            pause(.2)
        end
        end

