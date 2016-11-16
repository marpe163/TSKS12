function [successors,transitional_inputs,transitional_outputs] = getSuccessors(lookup_table,state)
successors=[];
transitional_inputs=[];
transitional_outputs=[];
    for it=1:size(lookup_table,1)
        if strcmp(lookup_table(it,1:2),state)
           successors=[successors;lookup_table(it,6:7)];
           transitional_inputs=[transitional_inputs;lookup_table(it,3)];
           transitional_outputs=[transitional_outputs;lookup_table(it,4:5)];
        end        
    end
end

