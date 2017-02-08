%LBA sliding window, main program
%calls bb_main1 the program for bb sliding window scheduling
%calls the bb optimal scheduling for whole packets, comment it out for long
%sequences

%calls the ARprediction to predict rates
%calls the lba3_prediction to compute the scheduling based on the
%predicted rates
%calls the compute_prediction to compute the new scheduling based on the
%predicted scheduling and the actual rates

close all;
clear all;


B1=[60000*8, 7000*8]; %here replace the 30000 by 20000, 15000, 10000 and 7000
B2=[60000*8, 40000*8];


    %SET 0 for AR prediction model
    r1avg=320;
    r2avg=320;
    r3avg=250;
    r4avg=250;
    
    %link rates in kbps
    %SET 1 path1=2000/9 kbps path2=2000/9 kbps
   r1=[800,100,300,150,300,300,300,400,400,400,500,100,200,200,600,300,1000,500];
   r2=[300,500,300,400,100,400,100,400,300,1000,400,400,200,500,200,200,400,500];
   r3=[800,100,300,500,200,300,200,400,400,500,300,200,300,500,200,100,700,500];
   r4=[100,500,500,200,500,100,200,400,400,200,500,100,200,200,500,400,500,500];
   
   %SET 2 path1=2200/9 kbps path2= 2200/9 kbps
   %r1=[900,200,300,200,300,300,300,300,400,400,500,100,200,200,600,300,1000,500];
   %r2=[500,700,300,400,300,400,300,400,100,1000,400,400,200,500,200,200,400,500];
   %r3=[900,200,300,500,200,300,200,400,400,500,300,200,300,500,200,100,700,500];
   %r4=[200,700,700,300,500,300,200,400,400,200,500,100,200,200,500,400,500,500];
   
   %SET 3 path1=2500/9 kbps path2= 2500/9 kbps
   %r1=[500,200,300,100,300,300,300,200,400,400,500,100,200,200,600,300,1000,500];
   %r2=[500,500,300,400,200,400,300,400,100,1000,400,400,200,500,200,200,400,500];
   %r3=[800,100,300,500,200,300,200,400,400,500,300,200,300,500,200,100,700,500];
   %r4=[200,500,500,200,500,200,200,400,400,200,500,100,200,200,500,400,500,500];
   
   
   Tinterval=400; %rate change period in ms
   
   %B1max=1000*8; %size of intermediate buffer link 1, in bits
   %B2max=80000*8; %size of intermediate buffer link 2, in bits

   
% constant link latencies in ms
L1= 0;
L2= 0;
L3= 0;
L4= 0;


GOP=6; %nr of frames in the GOP
Nr_Frames=100; %total number of frames in the video
Nr_Pkt_Frame=2; %number of packets per frame
N= Nr_Frames*Nr_Pkt_Frame; %number of packets
fps= 30; %playback rate in frames per second

%start the loop for different sliding windows
Window=[3,9,15,100];
Schedules(1:9,1:N)=0;

for w=1:2
    B1max=B1(w);
    B2max=B2(w);
    
%B1max=8*(10000+5000*(w-1));
%B2max=8*(10000+5000*(w-1));
    
ScheduledPkts=0; %total of packets scheduled
Wnd_Size=100;%Window(w);
%Wnd_Size= 12; %size of the sliding window in frames

Schedule(1:N)=0; %final schedule for all video
Indic(1:N)=0; %temporal packet scheduling
Dmax=200; %maximum palyback delay at the client

%set the importance and the list of ancestors for all packets in the video
Ancestors(1:N,1:2)=0;
Importance(1:N) = 0;
    
%ancestors and importance of packets for 2 pkts per frame
for i=0:((Nr_Frames/GOP))
    
    Ancestors(12*i+3,1)=12*i+1;
    Ancestors(12*i+3,2)=max(0, 12*i-3);
    Ancestors(12*i+5,1)=12*i+1;
    Ancestors(12*i+7,1)=12*i+1;
    Ancestors(12*i+7,2)=12*i+5;
    Ancestors(12*i+9,1)=12*i+5;
    Ancestors(12*i+11,1)=12*i+5;
    Ancestors(12*i+11,2)=12*i+9;
    Ancestors(12*i+2,1)=12*i+1;
    Ancestors(12*i+4,1)=12*i+3;
    Ancestors(12*i+6,1)=12*i+5;
    Ancestors(12*i+8,1)=12*i+7;
    Ancestors(12*i+10,1)=12*i+9;
    Ancestors(12*i+12,1)=12*i+11;
    Importance(12*i+1) = 1;
    Importance(12*i+3) = 4;
    Importance(12*i+5) = 2;
    Importance(12*i+7) = 4;
    Importance(12*i+9) = 3;
    Importance(12*i+11) =4;
    Importance(12*i+2) = 5;
    Importance(12*i+4) = 5;
    Importance(12*i+6) = 5;
    Importance(12*i+8) = 5;
    Importance(12*i+10) =5;
    Importance(12*i+12) =5;

    
end

temp(1:3)=0;
%get sizes of packets and decoding times
fid = fopen('framesBL.txt');
fid1= fopen('framesfgs.txt');


L(1:N)=0; %size of all packets
    
for i=1:N/Nr_Pkt_Frame
    L(2*i-1) = fscanf(fid,'%g', 1); % Gets frame sizes
    L(2*i) = fscanf(fid1, '%g',1);
end
   
%compute decoding time vector for all packets
Tdec(1:N)= 0; %decoding time for each packet
Tdec1(1:N)=0;    

for i=1:N/Nr_Pkt_Frame
    Tdec(2*i-1)=(i-1)*(1/fps)*1000;
    Tdec(2*i)=(i-1)*(1/fps)*1000;
end

for i=0:N/4
    Tdec1(i*4+1)=(i*(1/fps)*2)*1000;
    Tdec1(i*4+2)=(i*(1/fps)*2+(1/fps))*1000;
    Tdec1(i*4+3)=(i*(1/fps)*2)*1000;
    Tdec1(i*4+4)=(i*(1/fps)*2)*1000;
end




Sort(1:N,1:3)=0; %matrix used for sorting packets according to importance: col 1 = size of pkt, col2=pkt nr; col3=pkt importance

pointer=1; %pointer to the first unscheduled packet in the sort structure
%inintialize sorting strucutre with first sliding window
for i=1:Nr_Pkt_Frame*Wnd_Size
    Sort(i,1)=L(i);
    Sort(i,2)=i;
    Sort(i,3)=Importance(i);
end

%packet sorting according to importance
for m=1:Nr_Pkt_Frame*Wnd_Size
    for i=2:Nr_Pkt_Frame*Wnd_Size
        if Sort(i,3)<Sort(i-1,3)
            temp(1:3)=Sort(i,1:3);
            Sort(i,1:3)=Sort(i-1,1:3);
            Sort(i-1,1:3)=temp(1:3);
        end
    end
end    

count = 0;
 
while (count <= Nr_Frames-Wnd_Size)
    %slide window and consider next incoming frame
    if count~=0
        for i=1:Nr_Pkt_Frame
            Sort((Wnd_Size+count-1)*Nr_Pkt_Frame+i,1)=L((Wnd_Size+count-1)*Nr_Pkt_Frame+i);
            Sort((Wnd_Size+count-1)*Nr_Pkt_Frame+i,2)=(Wnd_Size+count-1)*Nr_Pkt_Frame+i;
            Sort((Wnd_Size+count-1)*Nr_Pkt_Frame+i,3)=Importance((Wnd_Size+count-1)*Nr_Pkt_Frame+i);
        end
    end
    %packet sorting according to importance
    for m=1:Nr_Pkt_Frame
        for i=pointer:(Wnd_Size+count-1)*Nr_Pkt_Frame
             if Sort((Wnd_Size+count-1)*Nr_Pkt_Frame+m,3) < Sort(i,3)
                 temp(1:3)=Sort((Wnd_Size+count-1)*Nr_Pkt_Frame+m,1:3);
                 
                 for j=(Wnd_Size+count-1)*Nr_Pkt_Frame+m-1:-1:i
                     Sort(j+1,1:3)=Sort(j,1:3);
                 end
                 Sort(i,1:3)=temp(1:3);
                        
                break;
            end
        end
    end    
     
    %upload final scheduling in the current state
    Indic(1:N)=Schedule(1:N);
   
    %compute partial scheduling
    Tsend=0; %used to stop the partial scheduling before the new packet enters the sliding window
    i=pointer;
    while i<=(Wnd_Size+count)*Nr_Pkt_Frame
        possibleA=0;
        possibleB=0;
        tmp=i;
        changed=0;
        
        tmp1=i;
        cnt=1;
        %loop that finds all not scheduled ancestors of current packet
        while(cnt<=(Wnd_Size+count)*Nr_Pkt_Frame-pointer)
            
            if((Ancestors(Sort(i,2),1)==0) & (Ancestors(Sort(i,2),2)==0))
                break;
            end
            
            if((Ancestors(Sort(i,2),1)~=0 & Indic(Ancestors(Sort(i,2),1))==3) | (Ancestors(Sort(i,2),2)~=0 & Indic(Ancestors(Sort(i,2),2))==3))
            %if(((Ancestors(Sort(i,2),1)~=0) & (Indic(Ancestors(Sort(i,2),1))==3) & (Ancestors(Sort(i,2),2)==0)) | ((Ancestors(Sort(i,2),1)~=0) & (Indic(Ancestors(Sort(i,2),1))==3) & (Ancestors(Sort(i,2),2)~=0) & (Indic(Ancestors(Sort(i,2),2))==3)))
                Indic(Sort(i,2))=3;
                break;
            end
            for j=1:2
                if ((Ancestors(Sort(i,2),j)~=0) & (Indic(Ancestors(Sort(i,2),j))==0))
                
                    for g=pointer:(Wnd_Size+count)*Nr_Pkt_Frame
                        if(Sort(g,2)==Ancestors(Sort(i,2),j))
              
                            i=g;
                            changed=1;
                            break;
                        end
                    end
                end 
                if (i~=tmp1)
                    tmp1=i;
                    continue;
                end
            end
            cnt=cnt+1;
        end
     
            %decide on all ancestors of current packet then on current
            %packet
            if(Indic(Sort(i,2))==0)
                Indic(Sort(i,2))=1;
                [DA,D1i,PacketA,PacketB]=compute_delay_buffconstraint(N,L(1:N),Tdec(1:N),Indic(1:N),Sort(i,2), Tinterval,r1,r2,r3,r4,L1,L2,L3,L4,B1max,B2max);
                if DA>Dmax
                    possibleA=1;
                end
                Indic(Sort(i,2))=2;
                [DB,D2i,PacketA,PacketB]=compute_delay_buffconstraint(N,L(1:N),Tdec(1:N),Indic(1:N),Sort(i,2), Tinterval,r1,r2,r3,r4,L1,L2,L3,L4,B1max,B2max);
                if DB>Dmax
                    possibleB=1;
                end
               
                %if not possible, do not send pkt
                if ((possibleA==1) & (possibleB==1))
                    Indic(Sort(i,2))=3;
                else if((possibleA==0) & (possibleB==0))
                        %if possible on both paths, pick the best one
                        if (D1i<D2i)
                            Indic(Sort(i,2))=1;
                        else
                            Indic(Sort(i,2))=2;
                        end
                       
                    %if possible only on path A, do it
                    else if (possibleA==0)
                            Indic(Sort(i,2))=1;
                        else
                            %if possible only on path B, do it
                            Indic(Sort(i,2))=2;
                        end
                    end       
                end
            end
            
            if (changed==1)
                i=tmp;
            else 
                i=tmp+1;
            end
        end
        
   
    %update pointer
    
    jump=0;
    
    while ((pointer<=N)&(Indic(pointer)~=0) & (PacketA(pointer,1)<=(count+1)*(1000/fps)) & (PacketB(pointer,1)<=(count+1)*(1000/fps)))
        pointer=pointer+1;
        jump=jump+1;
    end
    
    %fprintf('slide nr %d can schedule %d packets time %f\n', count, jump, (count+1)*1/fps);
    ScheduledPkts=ScheduledPkts+jump;
    
    %update final scheduling from partial schedulings
    Schedule(1:pointer-1)=Indic(1:pointer-1);

    
    %update Sort structure
    for sort=pointer-jump:pointer-1
        for v=1:N
            if Sort(v,2)==sort;
                pospkt=v;
                break;
            end
        end
        
        for v=pospkt-1:-1:sort
            Sort(v+1,1:3)=Sort(v,1:3);
        end
        
        Sort(sort,1)=L(sort);
        Sort(sort,2)=sort;
        Sort(sort,3)=Importance(sort);
    end
   
    count=count+1;
end


%update final scheduling
Schedule=Indic;

%compute total size of LBA scheduled video
TotalSize=sum(L(1:N));
GreedySize=0;
for i=1:N
    if (Schedule(i)~=3 & Schedule(i)~=0)
        GreedySize=GreedySize+L(i);
    end
end

[D,D2,PacketA,PacketB]=compute_delay_buffconstraint(N,L(1:N),Tdec(1:N),Schedule(1:N),N, Tinterval,r1,r2,r3,r4,L1,L2,L3,L4,B1max,B2max);

%update the schedules vector
%Schedules(w,:)=Schedule;


    %call the optimal BB for whole sequences only in case of small N
    Sch(1:N)=0;
    OptValue=0;
    %[Sch, OptValue]=bb_optimdistortion(N,L(1:N),Ancestors(1:N,1:2),Importance(1:N), Tdec(1:N),fps, Dmax,R1,R2,R3,R4,L1,L2,L3,L4);

    
    %call the BB sliding window algorithm
    Schbb(1:N)=0;
    %Schbb=bb_main1(Nr_Frames, Nr_Pkt_Frame,GOP, L(1:N),fps,Wnd_Size, Ancestors(1:N,1:2), Tdec(1:N),Dmax,R1,R2,R3,R4,L1,L2,L3,L4);
    
[TimeA,BuffA,TimeB,BuffB]=showbuff(N,L(1:N),PacketA,PacketB, Schedule(1:N),r2,r4,Tinterval);

ScheduledPkts=0;
Sum=sum(L(1:N));
Total=0;
for i=1:N
    if Schedule(i)~=3
        Total=Total+L(i);
        ScheduledPkts=ScheduledPkts+1;
    end
end
fprintf('LBA sliding wnd: total size %d, scheduled size %d, scheduled pkts %d, percentage %f\n', Sum, Total, ScheduledPkts, Total/Sum);

%fid2=fopen(sprintf('Buff%d.txt',w), 'wt');
%for i=1:N
%    fprintf(fid2,'%d', Schedule(i));
%end
fclose(fid);
fclose(fid1);
%fclose(fid2);
%end the loop for different sliding windows
%end


%% THE PREDICTION MODULE %%
   %set the prediction model parameters (their sum should be equal to 1.0)
   a1=0.8;
   a2=0.2;
   %call the rate prediction function
   %[R1,R2,R3,R4] = ARprediction(r1avg,r2avg,r3avg,r4avg,r1,r2,r3,r4, a1, a2);
   %Call the scheduling function
   %Sch_Prediction = lba3_prediction1(R1,R2,R3,R4,Tinterval,Dmax-50,B1max,B2max, Nr_Frames,Nr_Pkt_Frame,N,L,Tdec,Ancestors,Importance,fps);
   %call the computation of the final scheduling based on prediction
   %scheduling
   %[Sch_Pred_RealRates,PackA,PackB] = compute_prediction_realrates(N,L,Tdec,Sch_Prediction, Dmax, Tinterval,r1,r2,r3,r4,B1max,B2max);
   %Sch_Pred_Real_Ancestor = check_ancestors(N,Sch_Pred_RealRates, Ancestors,Tdec, PackA,PackB,Sch_Prediction);
    
 %% END PREDICTION MODULE %%

Schedules(w,:)=Schedule;
%Schedules(2,:)=Sch_Prediction;
%Schedules(3,:)=Sch_Pred_RealRates;
%Schedules(4,:)=Sch_Pred_Real_Ancestor;

%end the loop fpr different buffer sizes
end

graphs(N,L(1:N),Tdec(1:N),fps,Dmax,Schedules(1:9,1:N),Tinterval,r1,r2,r3,r4);

%showpaths(N, L(1:N), Schedules(1:2,1:N));
