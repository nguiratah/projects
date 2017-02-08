%displays the buffer content during streaming

function [TimeA,BuffA,TimeB,BuffB]=showbuff(N,L,PacketA,PacketB, Sch,r2,r4,Tinterval)

TimeA(2*N+2)=0;
TimeB(2*N+2)=0;
BuffA(2*N+2)=0;
BuffB(2*N+2)=0;

k=1;
n=1;

for i=1:N
    %compute BuffA
    if Sch(i)==1
            if k==1
                TimeA(k)=0;
                BuffA(k)=0;
                k=k+1;
            else 
               
                Tint=(BuffA(k-1)-(PacketA(i,5)-L(i)*8))/r2(floor(TimeA(k-1)/Tinterval)+1);
                Tlead=TimeA(k-1)-Tinterval*floor(TimeA(k-1)/Tinterval);
                Lint=BuffA(k-1)-(PacketA(i,5)-L(i)*8);
                
                while Tint>Tinterval-Tlead
                    Lint=Lint-(Tinterval-Tlead)*r2(floor(TimeA(k-1)/Tinterval)+1);
                    TimeA(k)=Tinterval*(1+floor(TimeA(k-1)/Tinterval));
                    BuffA(k)=BuffA(k-1)-(Tinterval-Tlead)*r2(floor(TimeA(k-1)/Tinterval)+1);
                    Tint=Lint/r2(floor(TimeA(k)/Tinterval)+1);
                    Tlead=0;
                    k=k+1;
                end
                TimeA(k)=TimeA(k-1)+Tint;
                BuffA(k)=PacketA(i,5)-L(i)*8;
                k=k+1;
            end 
            
            TimeA(k)=PacketA(i,2);
            BuffA(k)=PacketA(i,5)-L(i)*8;
        
            k=k+1;
        
            TimeA(k)=PacketA(i,2);
            BuffA(k)=PacketA(i,5);
        
            k=k+1;
        
    end
    
    %compute BuffB
    if Sch(i)==2
            if n==1
                TimeB(n)=0;
                BuffB(n)=0;
                n=n+1;
            else
                Tint=(BuffB(n-1)-(PacketB(i,5)-L(i)*8))/r4(floor(TimeB(n-1)/Tinterval)+1);
                Tlead=TimeB(n-1)-Tinterval*floor(TimeB(n-1)/Tinterval);
                Lint=BuffB(n-1)-(PacketB(i,5)-L(i)*8);
                
                while Tint>Tinterval-Tlead
                    Lint=Lint-(Tinterval-Tlead)*r4(floor(TimeB(n-1)/Tinterval)+1);
                    TimeB(n)=Tinterval*(1+floor(TimeB(n-1)/Tinterval));
                    BuffB(n)=BuffB(n-1)-(Tinterval-Tlead)*r4(floor(TimeB(n-1)/Tinterval)+1);
                    Tint=Lint/r4(floor(TimeB(n)/Tinterval)+1);
                    Tlead=0;
                    n=n+1;
                end
                TimeB(n)=TimeB(n-1)+Tint;
                BuffB(n)=PacketB(i,5)-L(i)*8;
                n=n+1;
            end
           
        
        TimeB(n)=PacketB(i,2);
        BuffB(n)=PacketB(i,5)-L(i)*8;
        
        n=n+1;
        
        TimeB(n)=PacketB(i,2);
        BuffB(n)=PacketB(i,5);
        
        n=n+1;
    end
end

    %solve the final iteration on buffA
    Tint=BuffA(k-1)/r2(floor(TimeA(k-1)/Tinterval)+1);
    Tlead=TimeA(k-1)-Tinterval*floor(TimeA(k-1)/Tinterval);
    Lint=BuffA(k-1);
                
    while Tint>Tinterval-Tlead
        Lint=Lint-(Tinterval-Tlead)*r2(floor(TimeA(k-1)/Tinterval)+1);
        TimeA(k)=Tinterval*(1+floor(TimeA(k-1)/Tinterval));
        BuffA(k)=BuffA(k-1)-(Tinterval-Tlead)*r2(floor(TimeA(k-1)/Tinterval)+1);
        Tint=Lint/r2(floor(TimeA(k)/Tinterval)+1);
        Tlead=0;
        k=k+1;
    end
    TimeA(k)=TimeA(k-1)+Tint;
    BuffA(k)=0;
    

    %solve the final iteration on buffB
    Tint=BuffB(n-1)/r4(floor(TimeB(n-1)/Tinterval)+1);
    Tlead=TimeB(n-1)-Tinterval*floor(TimeB(n-1)/Tinterval);
    Lint=BuffB(n-1);
                
    while Tint>Tinterval-Tlead
        Lint=Lint-(Tinterval-Tlead)*r4(floor(TimeB(n-1)/Tinterval)+1);
        TimeB(n)=Tinterval*(1+floor(TimeB(n-1)/Tinterval));
        BuffB(n)=BuffB(n-1)-(Tinterval-Tlead)*r4(floor(TimeB(n-1)/Tinterval)+1);
        Tint=Lint/r4(floor(TimeB(n)/Tinterval)+1);
        Tlead=0;
        n=n+1;
    end
    TimeB(n)=TimeB(n-1)+Tint;
    BuffB(n)=0;
    
    figure(3)
    
    subplot(211)
    plot(TimeA(1:k),BuffA(1:k),'-');
    %xlabel('');
    ylabel('buffer A content (bits)');
    
    subplot(212)
    plot(TimeB(1:n),BuffB(1:n),'-');
    xlabel('time (ms)');
    ylabel('buffer B content (bits)');
  

