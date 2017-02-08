function[] = plotDis2()
PlotsRD
Z = 100;
Cw = 40;
P11 = [0 1 0 0 0 0 0 0 0 0]; P12 =[0 0 0 0 0 0 1 0 0 0]; %P13 = [0 0 1 0 0 0 0 0 0 0];
P21 = [0 0 0 0 1 0 0 0 0 0]; P22= [0 0 0 0 0 0 0 0 1 0]; %P23 = [0 1 0 0 0 0 0 0 0 0];
P31  = [0 0 0 0 0 0 0 1 0]; P32= [0 0 0 0 0 0 0 1 0 0]; %P33 = [0 0 0 0 0 0 0 0 0 1];
G = [0.1 :0.05 : 1];
Dis = zeros(1, 199);
for k=1:numel(G)
    k
    Dis1(k)= RandomSlottedAlohav3Distortion2classes(G(k),P11,P12,Z, Cw,RD1, RD2, 9);
    Dis2(k)= RandomSlottedAlohav3Distortion2classes(G(k),P21,P22,Z, Cw,RD1, RD2, 9);
    Dis3(k)= RandomSlottedAlohav3Distortion2classes(G(k),P11,P12,Z, Cw,RD1, RD2, 5);
end
figure();
plot(G, Dis1,'r');
hold on;
plot(G, Dis2,'b');
hold on
plot(G, Dis3,'g');
xlabel('load');
ylabel('Distortion');
