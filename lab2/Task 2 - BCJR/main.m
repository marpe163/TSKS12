    frmLen = 1000;
    
    s = RandStream('mt19937ar', 'Seed', 11);
    trellis=poly2trellis(3,[7 5],7); % generating a (1,5/7) trellis
    
    %Generate the encoder for the (1,5/7 code) (that returns to the all
    %zero state by adding a few extra bits).
    enc = comm.ConvolutionalEncoder('TrellisStructure',trellis,'TerminationMethod','Terminated'); 
    
    
    bpskMod=comm.BPSKModulator; %generates unit power signals.
    
    channel=comm.AWGNChannel('BitsPerSymbol',1); %Generate our AWGN channel
    
    EbNo = -6:0.5:6; % What SNRs to estimate the BER for
    errorRates1=zeros(1,length(EbNo)); %for storing the BER's.
   
    
    eStat1 = comm.ErrorRate; %For calculating the BER's
    

    for it=1:length(EbNo) %Iterate over the different values of SNR
 
        noiseVar=10^(-EbNo(it)/10);
        channel.EbNo=EbNo(it);
    
       for kt=1:30
            EbNo(it)
            data = [randi([0 1],frmLen,1)]; %Generate random data

            encoded=step(enc,data); %run the data through the convolutional encoder

            modEncSign=step(bpskMod,encoded); %Modulate the data using BPSK
            transmEncSign=step(channel,modEncSign); %Transmit the data over the AWGN channel

            received=2/(noiseVar/2)*real(transmEncSign); %Get log-likelihoods
            [alpha,beta]=alpha_beta_gen(received); %Generate alpha and beta matrices from the log-likelihoods
            rec=[];%For storing the decoded codeword.

            %Decode by letting each bit be it's MAP estimate.
            for il=1:length(data)
                rec=[rec ;mapbitest(alpha,beta,il,received)];
            end

            tmp1=step(eStat1,data,rec); %Get the BER.

       end
       
       errorRates1(1,it)=tmp1(1); %Add the new BER to the errorRates1 vector.
       reset(eStat1)%Reset the stat object before estimating the BER for another SNR.
    end
    
    %Present the results in  a plot.
  semilogy(EbNo+10*log10(2),errorRates1(1,:),'bs-')
  xlabel('E_b/N_o [dB]')
  ylabel('P_b')
  title('MAP Bit Estimation using the BCJR Algorithm')

