function [predecessors,transitional_inputs,transitional_outputs] = getPredecessors(lookup_table,state,state_index)
predecessors=[];
transitional_inputs=[];
transitional_outputs=[];

    for it=1:size(lookup_table,1)
        if strcmp(lookup_table(it,6:7),state)
           predecessors=[predecessors;lookup_table(it,1:2)];
           transitional_inputs=[transitional_inputs;lookup_table(it,3)];
           transitional_outputs=[transitional_outputs;lookup_table(it,4:5)];
        end        
    end
end

