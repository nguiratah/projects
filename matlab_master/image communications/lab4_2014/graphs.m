%produces frames graphs for variable rate 

function f=graphs(N,L,Tdec,fps,Dmax,Sch,Tinterval,r1,r2,r3,r4)

%create the double sized vectors for the frames representation in time
     
    F=floor(Tdec(N)/Tinterval)+1;
    T2interval(1:2*F+1)=0;
    
    for i=1:F
        T2interval(2*(i-1)+1)=Tinterval*(i-1);
        T2interval(2*(i-1)+2)=Tinterval*(i-1);
    end
    
    for i=1:2*F-1
        T2interval(i)=T2interval(i+1);
    end
    T2interval(2*F)=T2interval(2*F-1)+Tinterval;
    T2interval(2*F+1)=T2interval(2*F);
    
    R1(1:2*F+1)=0;
    R2(1:2*F+1)=0;
    R3(1:2*F+1)=0;
    R4(1:2*F+1)=0;
    
    for j=1:F
        R1(2*(j-1)+1)=r1(j);
        R1(2*(j-1)+2)=r1(j);
        R2(2*(j-1)+1)=r2(j);
        R2(2*(j-1)+2)=r2(j);
        R3(2*(j-1)+1)=r3(j);
        R3(2*(j-1)+2)=r3(j);
        R4(2*(j-1)+1)=r4(j);
        R4(2*(j-1)+2)=r4(j);
    end
    
    
    Lsch(1:9,1:N)=0;
    Cumul(1:3,1:N)=0;
    PathA(1:9,1:N)=0;
    PathB(1:9,1:N)=0;
    for w=1:9
    for i=1:N
         if Sch(w,i)==3
             Lsch(w,i)=0;
         else
             Lsch(w,i)=L(i);
         end
    end
    end
    
    for w=1:2
        PathA(w,1)=mod(mod(Sch(w,1),3),2)*L(1)+mod(mod(Sch(w,2),3),2)*L(2);
        PathB(w,1)=mod(mod(mod(Sch(w,1),3),2)+1,2)*L(1)+mod(mod(mod(Sch(w,2),3),2)+1,2)*L(2);
                    
        j=36;
   
        for i=36:N/2
            Cumul(3,j)=Cumul(3,j-1)+L(2*i-1)+L(2*i);
            Cumul(w,j)=Cumul(w,j-1);
            if Sch(w,2*i-1)~=3
                Cumul(w,j)=Cumul(w,j)+L(2*i-1);
            end
            if Sch(w,2*i)~=3
                Cumul(w,j)=Cumul(w,j)+L(2*i);
            end
            PathA(w,j)=PathA(w,j-1)+mod(mod(Sch(w,2*i-1),3),2)*L(2*i-1)+mod(mod(Sch(w,2*i),3),2)*L(2*i);
            PathB(w,j)=PathB(w,j-1)+mod(mod(mod(Sch(w,2*i-1),3),2)+1,2)*L(2*i-1)+mod(mod(mod(Sch(w,2*i),3),2)+1,2)*L(2*i);
            j=j+1;
        end
    end
            
     T2dec(1:N)=0;
     Size2(1:N)=0;
     SizeSch(1:9,1:N)=0;

    for i=1:N/2
         T2dec(2*(i-1)+1)=Tdec(2*i);
         T2dec(2*(i-1)+2)=Tdec(2*i);
         Size2(2*(i-1)+1)=L(2*i-1)+L(2*i);
         Size2(2*(i-1)+2)=L(2*i-1)+L(2*i);
         %SizeSch(2*(i-1)+1)=Lsch(2*i-1)+Lsch(2*i);
         %SizeSch(2*(i-1)+2)=Lsch(2*i-1)+Lsch(2*i);
    end
     
    for w=1:9
    for i=1:N/2
         SizeSch(w,2*(i-1)+1)=Lsch(w,2*i-1)+Lsch(w,2*i);
         SizeSch(w,2*(i-1)+2)=Lsch(w,2*i-1)+Lsch(w,2*i);
    end
    end
    
    
    for i=1:(N-1)
         T2dec(i)=T2dec(i+1)+Dmax;
    end
      T2dec(N)=T2dec(N)+1000/fps+Dmax;

    %figure(1);
    
    %subplot(411)
    %plot(T2interval,R1,'-');
    %xlabel('');
    %ylabel('r_1 (kbps)');
    %legend('');
    
    %subplot(412)  
    %plot(T2interval,R2,'-');
    %xlabel('');
    %ylabel('r_2 (kbps)');
    %legend('');
    
    %subplot(413)  
    %plot(T2interval,R3,'-');
    %xlabel('');
    %ylabel('r_3 (kbps)');
    %legend('');
    
    %subplot(414)  
    %plot(T2interval,R4,'-');
    %xlabel('time (ms)');
    %ylabel('r_4 (kbps)');
    %legend('');  
      
    %figure(2);

    %subplot(411)
    %plot (T2dec(36:148),Size2(36:148),'-', T2dec(36:148), SizeSch(1,36:148),'-*','MarkerSize',5);
    %xlabel('frame time at the decoder');
    %ylabel('scheduled bytes');
    %legend('encoded frame size', 'scheduled frame size');
    %title('B_a=10kB, B_b=10kB');
  
    %subplot(912)
    %plot (T2dec,Size2,'-', T2dec, SizeSch(2,:),'--*');
    %xlabel('frame time at the decoder');
    %ylabel('scheduled bytes (current frame)');
    %legend('Wnd-size=5');
    
    %subplot(913)
    %plot (T2dec,Size2,'-', T2dec, SizeSch(3,:),'--+');
    %xlabel('frame time at the decoder');
    %ylabel('scheduled bytes');
    %legend('Wnd-size=7');
    
    %subplot(412)
    %plot (T2dec(36:148),Size2(36:148),'-', T2dec(36:148), SizeSch(2,36:148),'-*','MarkerSize',5);
    %xlabel('frame time at the decoder');
    %ylabel('encoded and scheduled frame size (bytes)');
    %legend('Wnd-Size=9');
    %title('B_a=15kB, B_b=15kB');
 
    %subplot(915)
    %plot(T2dec, Size2,'-', T2dec, SizeSch(5,:), '--d')
    %xlabel('frame time at the decoder');
    %ylabel('scheduled bytes');
    %legend('Wnd-size=11');
    
    %subplot(916)
    %plot(T2dec, Size2,'-', T2dec, SizeSch(6,:), '--d')
    %xlabel('frame time at the decoder');
    %ylabel('scheduled bytes');
    %legend('Wnd-size=13');
    
    
    %subplot(413)
    %plot (T2dec(36:148),Size2(36:148),'-', T2dec(36:148), SizeSch(4,36:148),'-*','MarkerSize',5);
    %xlabel('frame time at the decoder');
    %ylabel('scheduled bytes');
    %legend('Wnd-Size=15');
    %title('B_a=25kB, B_b=25kB');
    
    %subplot(918)
    %plot(T2dec, Size2,'-', T2dec, SizeSch(8,:), '--d')
    %xlabel('frame time at the decoder');
    %ylabel('scheduled bytes');
    %legend('Wnd-size=20');
    
    %subplot(414)
    %plot (T2dec(36:148),Size2(36:148),'-', T2dec(36:148), SizeSch(6,36:148),'-*','MarkerSize',5);
    %xlabel('frame time at the decoder (ms)');
    %ylabel('scheduled bytes');
    %legend('Wnd-Size=100');
    %title('B_a=35kB, B_b=35kB');

    %figure(3)
    %subplot(211)
    %plot (T2dec,Size2,'-', T2dec, SizeSch(1,:),'-*','MarkerSize',5);
    %xlabel('frame time at the decoder (ms)');
    %ylabel('scheduled bytes');
    %legend('frame rate','scheduled rate');
    %title('LBA scheduling: Known Link Rates');    
    
    %subplot(412)
    %plot (T2dec,Size2,'-', T2dec, SizeSch(2,:),'-*','MarkerSize',5);
    %xlabel('frame time at the decoder (ms)');
    %ylabel('scheduled bytes');
    %legend('Predicted Rates');
    %title('B_a=35kB, B_b=35kB');
    
    %subplot(312)
    %plot (T2dec,Size2,'-', T2dec, SizeSch(3,:),'-*','MarkerSize',5);
    %xlabel('frame time at the decoder (ms)');
    %ylabel('scheduled bytes');
    %legend('predicted link rates');
    %title('B_a=35kB, B_b=35kB');
    
    %subplot(212)
    %plot (T2dec,Size2,'-', T2dec, SizeSch(4,:),'-*','MarkerSize',5);
    %xlabel('frame time at the decoder (ms)');
    %ylabel('scheduled bytes');
    %legend('frame rate','scheduled rate');
    %title('LBA scheduling: Predicted Link Rates');    

    FrameTimeEnc(1:N/2)=0;
    FrameTimeDec(1:N/2)=0;
    
    FrameTimeEnc(1:N/2)=(1/fps)*1000*(1:N/2);
    FrameTimeDec(1:N/2)=Dmax+(1/fps)*1000*(1:N/2);
    
    figure(1)
    %subplot(211)
    %plot(35:60, Cumul(3,35:60),'-*');
    %ylabel('cumulative frame size (bytes)');
    %xlabel('frame number');
    
    %subplot(212)
    plot(FrameTimeDec(35:60),Cumul(1,35:60), '-*', FrameTimeDec(35:60), Cumul(2,35:60),'--o', FrameTimeEnc(35:60), Cumul(3,35:60),'-.d' );
    ylabel('cumulative scheduled frame size (bytes)');
    xlabel('frame time (ms)');
    legend('decoder: infinite B_a, B_b','decoder: B_a=8 kb, infinite B_b', 'encoder: cumulative frame size',2);

    
    figure(2)
    subplot(211)
    plot(35:60,PathA(1,35:60),'-*',35:60,PathA(2,35:60),'--o');
    %xlabel('frame number');
    ylabel('cumulative rate on path a (bytes)');
    legend('infinite buffers','limited buffer size',2);
    
    subplot(212)
    plot(35:60,PathB(1,35:60),'-*',35:60,PathB(2,35:60),'--o');
    xlabel('frame number');
    ylabel('cumulative rate on path b (bytes)');
    legend('infinite buffers','limited buffer size',2);
   