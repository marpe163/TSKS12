function    [input, output, prev_states] = previous_states( state,index,trellisLength )

if strcmp(state,'00')
    prev_states=['01';'00'];
    input=[1;0];
    output=['11';'00'];
    
    
elseif strcmp(state,'10')
    if index<trellisLength-1
        prev_states=['00';'01'];
        input=[1;0];
        output=['11';'00'];
    else
        prev_states=[];
        input=[];
        output=[];
    end
    
elseif strcmp(state,'01')
    prev_states=['10';'11'];
    input=[1;0];
    output=['10';'01'];
    
elseif strcmp(state,'11')
    if index<trellisLength-1
        prev_states=['10';'11'];
        input=[0;1];
        output=['01';'10'];
    else
        prev_states=[];
        input=[];
        output=[];
    end 
    end
    
end





