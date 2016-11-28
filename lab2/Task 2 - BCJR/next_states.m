function    [input, output, next_sta] = next_states( state,opt )
%A function that returns all possible futures tates for a given state.
%the opt argument can be used to filter out only such states where the
%transition correspond to a certain input (eg zero or one).
    if strcmp(state,'00')
        next_sta=['00';'10'];
        input=[0;1];
        output=['00';'11'];

    elseif strcmp(state,'10')
        next_sta=['11';'01'];
        input=[0;1];
        output=['01';'10'];

    elseif strcmp(state,'01')
        next_sta=['10';'00'];
        input=[0;1];
        output=['00';'11'];

    elseif strcmp(state,'11')
        next_sta=['01';'11'];
        input=[0;1];
        output=['01';'10'];

    end

    if strcmp(opt,'1')
        next_sta=next_sta(2,:);
        input=input(2);
        output=output(2,:);
    elseif strcmp(opt,'0')
        next_sta=next_sta(1,:);
        input=input(1);
        output=output(1,:);
    else

    end

end

