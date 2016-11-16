function mbit = mapbit( bit,b,c,received )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
[backwards,edgeOutput,forwards] = getStatePairs(1,bit);
sum=0;
for it=1:size(backwards,1)
    sum=sum+b.fetch(backwards(it,:),bit)*branch_metric(edgeOutput(it,:),received(2*bit-1),received(2*bit))*...
        c.fetch(forwards(it,:),bit+1);
end
sum2=0;
[backwards,edgeOutput,forwards] = getStatePairs(0,bit);
for it=1:size(backwards,1)
    sum2=sum2+b.fetch(backwards(it,:),bit)*branch_metric(edgeOutput(it,:),received(2*bit-1),received(2*bit))*...
        c.fetch(forwards(it,:),bit+1);
end
sum
sum2
if sum>sum2
    mbit=1;
else
    mbit=0;
end

end

