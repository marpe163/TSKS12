classdef forward_dictionary
    %UNTITLED7 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        states=[]; % form [state state_index]
        state_level=[];
        values=[]; 
        lookup_table = ['0011110';'0000000';'1011011';'1000101';'0111110';'0100000';'1111011';'1100101']; %[state input output nextstate]
        
    end
    
    methods
        function obj=forward_dictionary(received,len)
        obj.states=['00';'10';'01';'11']; % form [state state_index]
        obj.state_level=[len;len;len;len];
        obj.values=[1;1;1;1];
        for it=len-1:-1:3
            obj=obj.add_data('00',it,received);
            obj=obj.add_data('10',it,received);
            obj=obj.add_data('01',it,received);
            obj=obj.add_data('11',it,received);
        end
        obj=obj.add_data('00',2,received);
        obj=obj.add_data('10',2,received);
        obj=obj.add_data('00',1,received);
            
         
        
        end
        function obj=add_data(obj,state,state_lvl,received)
            %state_lvl > 3
            obj.states=[obj.states;state]
            obj.state_level=[obj.state_level;state_lvl]
            [successors,transitional_inputs,transitional_outputs] = getSuccessors(obj.lookup_table,state);
            obj.values=...
                [obj.values;...
                branch_metric(transitional_outputs(1,:),received(2*(state_lvl)-1),received(2*(state_lvl)))*obj.fetch(successors(1,:),state_lvl+1)+...
                branch_metric(transitional_outputs(2,:),received(2*(state_lvl)-1),received(2*(state_lvl)))*obj.fetch(successors(2,:),state_lvl+1)]
        end
        function val=fetch(obj,state,state_lvl)
             tmp=[];
             val=0;
             for it=1:length(obj.state_level)
                if obj.state_level(it)==state_lvl
                    tmp=[tmp;it];
                end
             end
             for it=1:length(tmp)
                 obj.states(tmp(it),:)
                 state
                 if strcmp(obj.states(tmp(it),:),state)
                    val=obj.values(tmp(it));
                 end
             end
             
        end
        
    end
    
end

