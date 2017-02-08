%image comm project
function [Throughput] = RandomSlottedAloha(N, Nmax, Cw, V)
%N : number of packets to transmit
%Nmax : maximum of Backoff Stage
%Cw : Starting backoff Timer
%we start first without packet recovery
%Nmax =1; V = 1; Cw = 3; N = 8;
Throughput = 0;
for A= 1:V
    R =0;
    time = 0;
    Timer1 =zeros(N, 2);
    for i =1: N
        Timer1(i, 1) = 1+floor(Cw*rand());
        Timer1(i, 2) =1;
    end
    while (R<N)
        Y = [];
        TimerSorted=zeros(1, max(Timer1(:,1)));
        for i =1 : max(Timer1(:,1))
            for j = 1: length(Timer1(:,1))
                if Timer1(j,1) == i
                    TimerSorted(i)=TimerSorted(i)+1;
                end
            end
        end
        X = Timer1(:,1);
        for k = 1 : length(TimerSorted);
            if TimerSorted(k)>1
                s = find(Timer1(:,1)==k);
                for l=1 : length(s)
                    X(s(l)) = -X(s(l));
                end
            end
        end
        for i=1:length(X)
            if X(i)<0
                Y = [Y, -X(i)]; %Y contains packets which will collide
            end
        end
        if(isempty(Y))
            time = time+max(Timer1(:,1));
            R= N;
            break;
        end
        H = min(Y);
        p=0;
        f = 0;
        while(p<H)
            C = sort(find(Timer1(:,1)==p));
            Q= isempty(C);
            if Q~=true;
                for b = 1:length(C)
                    Timer1(C(b),:)=[];
                    f = f+1;
                end
            end
            p=p+1;
        end
        R= R+f;
        O = find(Timer1(:,1)==H);
        if ~(isempty(O))
            for d=1:length(O)
                Timer1((O(d)), 2)= min(Timer1((O(d)), 2)+1, Nmax);
                Timer1((O(d)), 1) = 1+floor(rand()*2^(Timer1((O(d)), 2)-1)*Cw);
            end
        end
        time = time +H;
    end
    Throughput = Throughput+ (N/(time*V));
end
end