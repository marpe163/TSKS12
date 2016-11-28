function bit = mapbitest( alpha,beta,bitindex,received )
    p1=0; %prob of 1.
    p0=0; %prob of 0.
    states=['00';'10';'01';'11'];
    for it=1:length(states)
        if bitindex<(length(received)/2)-1
        [input, output, next_sta] = next_states( states(it,:),'1' );
        p1=p1+alpha(state_index(states(it,:)),bitindex)*branch_metric(output(1,:),received(2*bitindex-1),received(2*bitindex))*...
            beta(state_index(next_sta(1,:)),bitindex+1);
        
        [input, output, next_sta] = next_states( states(it,:),'0' );
        p0=p0+alpha(state_index(states(it,:)),bitindex)*branch_metric(output(1,:),received(2*bitindex-1),received(2*bitindex))*...
            beta(state_index(next_sta(1,:)),bitindex+1);
        else
            p1=0;
            p0=1;
        end
        
    end

    if p1>p0
        bit=1;
    else
        bit=0;
    end
end

