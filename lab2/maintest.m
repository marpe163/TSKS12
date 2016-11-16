lookup_table = ['0011110';'0000000';'1011011';'1000101';'0111110';'0100000';'1111011';'1100101']; %[state input output nextstate]
received=repmat([-4],1,400);
trellis=poly2trellis(3,[7 5],7);
a=comm.ConvolutionalEncoder(trellis);
hhhh=step(a,[0;1;1;0;1;0]);
q=comm.BPSKModulator;
 channel=comm.AWGNChannel('EbNo',4,'BitsPerSymbol',1);
d=comm.BPSKDemodulator('DecisionMethod','Log-likelihood ratio');

e=step(d,step(channel,step(q,hhhh)));

b=backward_dictionary(hhhh,7);
c=forward_dictionary(hhhh,7);


%Fill upp the backward dictionary.
mapseq=[]
for it=1:6
    mapseq=[mapseq;mapbit(it,b,c,e)]
end
