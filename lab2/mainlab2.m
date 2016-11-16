
    EbNo=2;
    frmLen = 1000;
    puncturePattern=[1;1;0;1;0;1];
    puncturePattern=repmat(puncturePattern,(ceil(frmLen/6))*4,1);
    
    s = RandStream('mt19937ar', 'Seed', 11);
    intrlvrIndices = randperm(s, frmLen);
    trellis=poly2trellis(3,[7 5],7);
    trellis=poly2trellis(5,[35 37],35);
    encoder = comm.TurboEncoder('TrellisStructure', trellis, ...
        'InterleaverIndices', intrlvrIndices);
    decoder=comm.TurboDecoder('TrellisStructure', trellis, ...
        'InterleaverIndices', intrlvrIndices, ...
                 'NumIterations', 4);

    bpskMod=comm.BPSKModulator; %generates unit power signals.
    
    channel=comm.AWGNChannel('EbNo',EbNo,'BitsPerSymbol',1);
    bpskDemod=comm.BPSKDemodulator;
    
    EbNo = -6:0.25:4;
    errorRates1=zeros(4,length(EbNo)); %coded
    errorRates2=zeros(1,length(EbNo)); %uncoded
    
    eStat1 = comm.ErrorRate;
    eStat2=comm.ErrorRate;
   numIt=[1,2,5,10]
   for jt=1:length(numIt)
    for it=1:length(EbNo) %bitwise SNR vector.
        decoder=comm.TurboDecoder('TrellisStructure', trellis, ...
        'InterleaverIndices', intrlvrIndices, ...
                 'NumIterations', numIt(jt));
    noiseVar=10^(-EbNo(it)/10);
    channel.EbNo=EbNo(it);
   for kt=1:5
       EbNo(it)
    data = randi([0 1],frmLen,1);
    
    encoded=step(encoder,data);
    encoded=encoder(data);
    modEncSign=step(bpskMod,encoded);
    modUnEncSign=step(bpskMod,data);
    
    
    transmEncSign=step(channel,modEncSign);
    transmUnEncSign=step(channel,modUnEncSign);
    
  
    
    demodEncSign=step(bpskDemod,transmEncSign);
    recUnEncData=step(bpskDemod,transmUnEncSign);
   
    %For the punctured version.
    puncturePattern=puncturePattern(1:length(transmEncSign));
    transmEncSign=transmEncSign.*puncturePattern;
    
    recEncData=step(decoder,(-2/(noiseVar/2))*real(transmEncSign));
   
  
    tmp1=step(eStat1,data,recEncData);
    tmp2=step(eStat2,data,recUnEncData);
   end
    
   
    
    errorRates1(jt,it)=tmp1(1);
    errorRates2(it)=tmp2(1);
    
    reset(eStat1)
    reset(eStat2)
    
    
    end
   end
   
   
%    semilogy(EbNo+10*log10(3),errorRates1(1,:),'bs-')
%     hold on
%     semilogy(EbNo+10*log10(3),errorRates1(2,:),'go-')
%     semilogy(EbNo+10*log10(3),errorRates1(3,:),'kv-')
%     semilogy(EbNo+10*log10(3),errorRates1(4,:),'md-')
%     semilogy(EbNo,errorRates2(1,:),'r^-')
%    
   
     semilogy(EbNo+10*log10(2),errorRates1(1,:),'bs-')
    hold on
    semilogy(EbNo+10*log10(2),errorRates1(2,:),'go-')
    semilogy(EbNo+10*log10(2),errorRates1(3,:),'kv-')
    semilogy(EbNo+10*log10(2),errorRates1(4,:),'md-')
    semilogy(EbNo,errorRates2(1,:),'r^-')
    xlabel('E_b/N_o [dB]')
    ylabel('P_b')
legend('Turbo Code using 1 iteration','Turbo Code using 2 iterations','Turbo Code using 5 iterations', ...
    'Turbo Code using 10 iterations','Without error correction','Location','SouthWest');