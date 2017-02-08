%called by lba3_buffconstraint.m
%computes the minim delay for a given vector for buff constraints, maximum
%link rates, variable rates.


function [Dmax1,Di,PacketA,PacketB]=compute_delay_buffconstraint(N,L,Tdec,vect,position, Tinterval,r1,r2,r3,r4,L1,L2,L3,L4,B1max,B2max)
    
    BufferA(1:N)=0;
    BufferB(1:N)=0;
    Dmax(1:N)=0;
    PacketA(1:N,1:5)=0;%time structure for each packet: Tsend link 1, T arrival buffer, Tsend link2, Tarrival
    PacketB(1:N,1:5)=0;


    %compute Dmax for the first packet, and initialize vectors
        i=1;
   
        if vect(1)==1

            PacketA(i,1)=0;
            j=0;
            Tint=L(i)*8/r1(j+1);
            Lint=L(i)*8;
            while Tint>Tinterval
                Lint=Lint - Tinterval*r1(j+1);
                j=j+1;
                Tint=Lint/r1(j+1);
            end
            PacketA(i,2)=j*Tinterval+Tint;
            
            PacketA(i,3)=PacketA(i,2);
            
            j=0;
            Tint=L(i)*8/r2( floor(PacketA(i,3)/Tinterval)+1+j );
            Tlead=PacketA(i,3)-Tinterval*floor(PacketA(i,3)/Tinterval);
            Lint=L(i)*8;
            while Tint>Tinterval-Tlead
                Lint=Lint - (Tinterval-Tlead)*r2(floor(PacketA(i,3)/Tinterval)+1+j);
                j=j+1;
                Tlead=0;
                Tint=Lint/r2(floor(PacketA(i,3)/Tinterval)+1+j);
            end
            PacketA(i,4)=(floor(PacketA(i,3)/Tinterval)+j)*Tinterval+Tint+Tlead;
            BufferA(i)=L(i)*8;
            
            PacketA(i,5)=BufferA(i);
            
        else
          if vect(1)==2  
            
            PacketB(i,1)=0;
            j=0;
            Tint=L(i)*8/r3(j+1);
            Lint=L(i)*8;
            while Tint>Tinterval
                Lint=Lint - Tinterval*r3(j+1);
                j=j+1;
                Tint=Lint/r3(j+1);
            end
            PacketB(i,2)=j*Tinterval+Tint;
            
            PacketB(i,3)=PacketB(i,2);
            
            j=0;
            Tint=L(i)*8/r4( floor(PacketB(i,3)/Tinterval)+1+j );
            Tlead=PacketB(i,3)-Tinterval*floor(PacketB(i,3)/Tinterval);
            Lint=L(i)*8;
            while Tint>Tinterval-Tlead
                Lint=Lint - (Tinterval-Tlead)*r4(floor(PacketB(i,3)/Tinterval)+1+j);
                j=j+1;
                Tlead=0;
                Tint=Lint/r4(floor(PacketB(i,3)/Tinterval)+1+j);
            end
            PacketB(i,4)=(floor(PacketB(i,3)/Tinterval)+j)*Tinterval+Tint+Tlead;
            BufferB(i)=L(i)*8;
            PacketB(i,5)=BufferB(i);
        end
      end
        Dmax(i)=max(PacketA(i,4)-Tdec(i), PacketB(i,4)-Tdec(i));
        if i==position
            Di=Dmax(i);
        end
        
        i=i+1;
        
        %compute Dmax on the tree depth first, on the path given by Vect
        while i<=N 
            if vect(i)==1
                
                %compute te sending time on link 1 and arrival tine at
                %intermediate node
                PacketA(i,1)=PacketA(i-1,2);    
                j=0;
                Tint=L(i)*8/r1( floor(PacketA(i,1)/Tinterval)+1+j);
                Tlead=PacketA(i,1)-Tinterval*floor(PacketA(i,1)/Tinterval);
                Lint=L(i)*8;
                while Tint>Tinterval-Tlead
                    Lint=Lint - (Tinterval-Tlead)*r1(floor(PacketA(i,1)/Tinterval)+1+j);
                    j=j+1;
                    Tlead=0;
                    Tint=Lint/r1(floor(PacketA(i,1)/Tinterval)+1+j);
                end
                PacketA(i,2)=(floor(PacketA(i,1)/Tinterval)+j)*Tinterval+Tint+Tlead;
            
                %compute the time when the buffer has enough place to
                %receive the packet
                if B1max-L(i)*8<0
                    fprintf('error, buffer size smaller than packet size, final results might be incorect\n');
                end
                
                if BufferA(i-1)>B1max-L(i)*8
                    j=0;
                    Tlead=PacketA(i-1,2)-Tinterval*floor(PacketA(i-1,2)/Tinterval);
                    Tint=(BufferA(i-1)-(B1max-L(i)*8))/r2(floor(PacketA(i-1,2)/Tinterval)+j+1);
                    BuffA=BufferA(i-1)-(B1max-L(i)*8);
                    while Tint>Tinterval-Tlead
                        BuffA=BuffA-(Tinterval-Tlead)*r2(floor(PacketA(i-1,2)/Tinterval)+1+j);
                        j=j+1;
                        Tlead=0;
                        Tint=BuffA/r2(floor(PacketA(i-1,2)/Tinterval)+1+j);
                    end
                    TpossibleA=(floor(PacketA(i-1,2)/Tinterval)+j)*Tinterval+Tint+Tlead;
                else
                    TpossibleA=PacketA(i-1,2);
                end
                PacketA(i,2)=max(PacketA(i,2),TpossibleA);
                   
                %update buffer content at the time packet i enters the
                %buffer
                j=floor(PacketA(i-1,2)/Tinterval);
                Tlead=PacketA(i-1,2)-j*Tinterval;
                h=floor(PacketA(i,2)/Tinterval);
                Tlead1=PacketA(i,2)-h*Tinterval;
                BufferA(i)=BufferA(i-1);
                while j<h
                    BufferA(i)=max(0, BufferA(i)-(Tinterval-Tlead)*r2(j+1));
                    Tlead=0;
                    j=j+1;
                end
                BufferA(i)=max(0, BufferA(i)-(Tlead1-Tlead)*r2(j+1))+L(i)*8;                
                
                %compute the sending time on the second link
                PacketA(i,3)=max(PacketA(i-1,4),PacketA(i,2));
                
                %compute the arrival time at the client
                j=0;
                Tint=L(i)*8/r2( floor(PacketA(i,3)/Tinterval)+1+j );
                Tlead=PacketA(i,3)-Tinterval*floor(PacketA(i,3)/Tinterval);
                Lint=L(i)*8;
                while Tint>Tinterval-Tlead
                    Lint=Lint - (Tinterval-Tlead)*r2(floor(PacketA(i,3)/Tinterval)+1+j);
                    j=j+1;
                    Tlead=0;
                    Tint=Lint/r2(floor(PacketA(i,3)/Tinterval)+1+j);
                end
                PacketA(i,4)=(floor(PacketA(i,3)/Tinterval)+j)*Tinterval+Tint+Tlead;
                PacketA(i,5)=BufferA(i);
                
                %update structures on the other link
                PacketB(i,1:5)=PacketB(i-1,1:5);
                BufferB(i)=BufferB(i-1);
                Dmax(i)=PacketA(i,4)-Tdec(i);
                if i==position
                    Di=PacketA(i,4)-Tdec(i);
                end
                
            else
              if vect(i)==2
                %compute sending time on first link and arrival time at the
                %buffer
                PacketB(i,1)=PacketB(i-1,2);
                j=0;
                Tint=L(i)*8/r3( floor(PacketB(i,1)/Tinterval)+1+j);
                Tlead=PacketB(i,1)-Tinterval*floor(PacketB(i,1)/Tinterval);
                Lint=L(i)*8;
                while Tint>Tinterval-Tlead
                    Lint=Lint - (Tinterval-Tlead)*r3(floor(PacketB(i,1)/Tinterval)+1+j);
                    j=j+1;
                    Tlead=0;
                    Tint=Lint/r3(floor(PacketB(i,1)/Tinterval)+1+j);
                end
                PacketB(i,2)=(floor(PacketB(i,1)/Tinterval)+j)*Tinterval+Tint+Tlead;
            
                %compute the time when the buffer has enough place to
                %receive the packet
                if B2max-L(i)*8<0
                    fprintf('error, buffer2 size smaller than packet size, final results might be incorect\n');
                end
                
                if BufferB(i-1)>B2max-L(i)*8
                    j=0;
                    Tlead=PacketB(i-1,2)-Tinterval*floor(PacketB(i-1,2)/Tinterval);
                    Tint=(BufferB(i-1)-(B2max-L(i)*8))/r4(floor(PacketB(i-1,2)/Tinterval)+j+1);
                    BuffB=BufferB(i-1)-(B2max-L(i)*8);
                    while Tint>Tinterval-Tlead
                        BuffB=BuffB-(Tinterval-Tlead)*r4(floor(PacketB(i-1,2)/Tinterval)+1+j);
                        j=j+1;
                        Tlead=0;
                        Tint=BuffB/r4(floor(PacketB(i-1,2)/Tinterval)+1+j);
                    end
                    TpossibleB=(floor(PacketB(i-1,2)/Tinterval)+j)*Tinterval+Tint+Tlead;
                else
                    TpossibleB=PacketB(i-1,2);
                end
                PacketB(i,2)=max(PacketB(i,2),TpossibleB);
                   
                %update buffer content at the time packet i enters the
                %buffer
                j=floor(PacketB(i-1,2)/Tinterval);
                Tlead=PacketB(i-1,2)-j*Tinterval;
                h=floor(PacketB(i,2)/Tinterval);
                Tlead1=PacketB(i,2)-h*Tinterval;
                BufferB(i)=BufferB(i-1);
                while j<h
                    BufferB(i)=max(0, BufferB(i)-(Tinterval-Tlead)*r4(j+1));
                    Tlead=0;
                    j=j+1;
                end
                BufferB(i)=max(0, BufferB(i)-(Tlead1-Tlead)*r4(j+1))+L(i)*8;     
                                
                %compute sending time on the second link
                PacketB(i,3)=max(PacketB(i-1,4),PacketB(i,2));
                
                %compute arrival time at the client
                j=0;
                Tint=L(i)*8/r4( floor(PacketB(i,3)/Tinterval)+1+j );
                Tlead=PacketB(i,3)-Tinterval*floor(PacketB(i,3)/Tinterval);
                Lint=L(i)*8;
                while Tint>Tinterval-Tlead
                    Lint=Lint - (Tinterval-Tlead)*r4(floor(PacketB(i,3)/Tinterval)+1+j);
                    j=j+1;
                    Tlead=0;
                    Tint=Lint/r4(floor(PacketB(i,3)/Tinterval)+1+j);
                end
                PacketB(i,4)=(floor(PacketB(i,3)/Tinterval)+j)*Tinterval+Tint+Tlead;
                PacketB(i,5)=BufferB(i);
                
                
                %update structures for the other path
                PacketA(i,1:5)=PacketA(i-1,1:5);
                BufferA(i)=BufferA(i-1);
                Dmax(i)=PacketB(i,4)-Tdec(i);  
                
                if i==position
                    Di=PacketB(i,4)-Tdec(i);
                end
                
              else
                PacketA(i,1:5)=PacketA(i-1,1:5);
                PacketB(i,1:5)=PacketB(i-1,1:5);
                BufferA(i)=BufferA(i-1);
                BufferB(i)=BufferB(i-1);
                
                if i==position
                    Di=0;
                end
              end
            end
            
            i=i+1;
        end

        Dmax1=max(Dmax(position:N));
        PacketA;
        PacketB;
     