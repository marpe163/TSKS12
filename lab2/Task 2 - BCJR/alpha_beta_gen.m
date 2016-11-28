function [alpha, beta ] = alpha_beta_gen( received )
%A function that generates the alpha and beta matrices given the decoded
%log-likelihoods.
trellisLen=(length(received)/2)+1; %to determine the number of columns of the matrices

alpha=zeros(4,trellisLen);
alpha(4,1)=1;
beta=zeros(4,trellisLen);
beta(4,trellisLen)=1;

%The possible states
states=['00';'10';'01';'11'];

%generating alpha
for it=2:trellisLen
    for jt=1:length(states)
        [input, output, prev_states] = previous_states(states(jt,:),it,trellisLen);
        for kt=1:size(output,1)
            alpha(state_index(states(jt,:)),it)=alpha(state_index(states(jt,:)),it)+...
                alpha(state_index(prev_states(kt,:)),it-1)*branch_metric(output(kt,:),received((2*(it-1)-1)),received((2*(it-1))));
        end
    end
    alpha(:,it)=normalize(alpha(:,it));
end

%generating beta
for it=trellisLen-1:-1:1
    for jt=1:length(states)
        [input, output, next_sta] = next_states(states(jt,:),'-1');
        for kt=1:size(output,1)
            beta(state_index(states(jt,:)),it)=beta(state_index(states(jt,:)),it)+...
                beta(state_index(next_sta(kt,:)),it+1)*branch_metric(output(kt,:),received(2*it-1),received(2*it));
        end
    end
    if it==2
        beta(1:2,2)=[0;0];
    end
    if it==1
        beta(1:3,1)=[0;0;0];
    end
    beta(:,it)=normalize(beta(:,it));
end


end

