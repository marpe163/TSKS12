function state_ind = state_index( state )
%Given a state, the function returns the row in the alpha or beta matrix 
%that corresponts to it.
    state_ind=0;
    if strcmp(state,'00')
        state_ind=4;
    end
    if strcmp(state,'10')
        state_ind=3;
    end
    if strcmp(state,'01')
        state_ind=2;
    end
    if strcmp(state,'11')
        state_ind=1;
    end

end

