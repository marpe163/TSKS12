function metric=branch_metric(edgeOutput, llr1,llr2)
%Generates the branch metric of an edge, given the output that corresponds
%to that edge and the decoded log-likelihoods.

    px1=1/(1+exp(-llr1)); %Probability that the first bit is 0
    px2=1/(1+exp(-llr2)); %as above.
    ptot=0;
    if strcmp(edgeOutput(1),'0')
       if strcmp(edgeOutput(2),'0')
           ptot=px1*px2;
       else
           ptot=px1*(1-px2);
       end
    else    
        if strcmp(edgeOutput(2),'0')
           ptot=(1-px1)*px2;
       else
           ptot=(1-px1)*(1-px2);
       end
    end
    metric=ptot;
end