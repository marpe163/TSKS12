    EbNo=2;
    frmLen = 10000;
    s = RandStream('mt19937ar', 'Seed', 11);
    intrlvrIndices = randperm(s, frmLen);
    trellis=poly2trellis(3,[7 5],7);

    encoder = comm.TurboEncoder('TrellisStructure', trellis, ...
        'InterleaverIndices', intrlvrIndices);
    decoder=comm.TurboDecoder('TrellisStructure', trellis, ...
        'InterleaverIndices', intrlvrIndices, ...
                 'NumIterations', 4);

    bpskMod=comm.BPSKModulator; %generates unit power signals.
    
    channel=comm.AWGNChannel('EbNo',EbNo,'BitsPerSymbol',1);
    bpskDemod=comm.BPSKDemodulator;
    
    EbNo = -5:10;
    errorRates1=zeros(1,length(EbNo)); %coded
    errorRates2=zeros(1,length(EbNo)); %not coded
    eStat1 = comm.ErrorRate;
    eStat2=comm.ErrorRate;
    for it=1:length(EbNo) %bitwise SNR vector.
    noiseVar=10^(-EbNo(it)/10);
    channel.EbNo=EbNo(it);
    for frmInd=1:8
    data = randi([0 1],frmLen,1);
    encoded=step(encoder,data);
    modEncSign=step(bpskMod,encoded);
    modUnEncSign=step(bpskMod,data);
    
    transmEncSign=step(channel,modEncSign);
    transmUnEncSign=step(channel,modUnEncSign);
    
    demodEncSign=step(bpskDemod,transmEncSign);
    recUnEncData=step(bpskDemod,transmUnEncSign);
    
    recEncData=step(decoder,demodEncSign);
    
    tmp1=eStat1(data,recEncData);
    tmp2=eStat2(data,recUnEncData);
    
   
    end
     errorRates1(it)=tmp1(1);
    errorRates2(it)=tmp2(1);
    reset(eStat1)
    reset(e2Rate)
    
    end
    semilogy(EbNo,errorRates1(1,:),'bs-')
    hold on
    semilogy(EbNo,errorRates2(1,:),'r^-')
    xlabel('E_b/N_o [dB]')
    ylabel('P_b')
    legend('Using Turbo Code','Without error correction','Location','SouthWest');
    
    