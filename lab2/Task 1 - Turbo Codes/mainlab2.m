    frmLen = 1000;
    
    %Generate puncture pattern for the second code.
    puncturePattern=[1;1;0;1;0;1];
    puncturePattern=repmat(puncturePattern,(ceil(frmLen/6))*4,1);
    
    %Random interleaver
    s = RandStream('mt19937ar', 'Seed', 11);
    intrlvrIndices = randperm(s, frmLen);
    
    trellis=poly2trellis(3,[7 5],7); %Trellis for code 1 (1,5/7)
    trellis=poly2trellis(5,[35 37],35);%Trellis for code 2 (1,37/35) - punctured
    encoder = comm.TurboEncoder('TrellisStructure', trellis, ...
        'InterleaverIndices', intrlvrIndices); %Generate the turbo encoder for the given trellis
    decoder=comm.TurboDecoder('TrellisStructure', trellis, ...
        'InterleaverIndices', intrlvrIndices, ...
                 'NumIterations', 4); %Generate the turbo decoder for the given trellis

    bpskMod=comm.BPSKModulator; %generates unit power signals.
    bpskDemod=comm.BPSKDemodulator; %BPSK Demodulator
    channel=comm.AWGNChannel('BitsPerSymbol',1);
    
    EbNo = -6:0.25:4; %
    errorRates1=zeros(4,length(EbNo)); % error rates for the turbo code for different no. of iterations
    errorRates2=zeros(1,length(EbNo)); %error rates for the uncoded case.
    
    eStat1 = comm.ErrorRate; %For calculating the BER's for the
    eStat2=comm.ErrorRate;
   numIt=[1,2,5,10]
   for jt=1:length(numIt)
    for it=1:length(EbNo) %bitwise SNR vector.
        decoder=comm.TurboDecoder('TrellisStructure', trellis, ...
        'InterleaverIndices', intrlvrIndices, ...
                 'NumIterations', numIt(jt)); %Set the number of iterations for the decoder. Different with each iteration.
    noiseVar=10^(-EbNo(it)/10);
    channel.EbNo=EbNo(it);
   for kt=1:3
       EbNo(it)
    data = randi([0 1],frmLen,1);
    
    %Encode the data.
    encoded=step(encoder,data);
    
    %modulate both coded and uncoded data using BPSK
    modEncSign=step(bpskMod,encoded);
    modUnEncSign=step(bpskMod,data);
    
    %Transmit the modulated data sets.
    transmEncSign=step(channel,modEncSign);
    transmUnEncSign=step(channel,modUnEncSign);
    
  
    
    %Hard decoding of the uncoded data.
    recUnEncData=step(bpskDemod,transmUnEncSign);
   
    %For the punctured version.
    puncturePattern=puncturePattern(1:length(transmEncSign));
    transmEncSign=transmEncSign.*puncturePattern;
    
    %Soft-decoding of the turbo coded data, using Log-likelihoods.
    recEncData=step(decoder,(-2/(noiseVar/2))*real(transmEncSign));
   
  
    %Update error rates for the given SNR
    tmp1=step(eStat1,data,recEncData);
    tmp2=step(eStat2,data,recUnEncData);
   end
    
   
    
    errorRates1(jt,it)=tmp1(1);
    errorRates2(it)=tmp2(1);
    
    reset(eStat1)
    reset(eStat2)
    
    
    end
   end
   
   %For plotting the results, not the shift in the X-axes due to
   %distributing the energy per information bit over all transmitted bits.
   
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