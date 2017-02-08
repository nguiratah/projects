function[] = plotDis()
PlotsRD
Z = 100;
Cw = 40;
P1 = [0 0 1 0 0 0 0 0 0 0 0];
P2 = [0 0 0 0 0 1 0 0 0 0 0];
P3 = [0 0 0 0 0 0 0 1 0 0 0];
G = [0.1 :0.05 : 1];
Dis = zeros(1, 199);
for k=1:numel(G)
    k
    Dis1(k)= RandomSlottedAlohav3Distortion(G(k),P1,Z, Cw,RD1(1), RD1(2), RD1(3));
    Dis2(k)= RandomSlottedAlohav3Distortion(G(k),P2,Z, Cw,RD1(1), RD1(2), RD1(3));
    Dis3(k)= RandomSlottedAlohav3Distortion(G(k),P3,Z, Cw,RD1(1), RD1(2), RD1(3));
end
figure();
plot(G, Dis1,'r');
hold on;
plot(G, Dis2,'b');    Dis1(k)= RandomSlottedAlohav3Distortion(G(k),P1,Z, Cw,RD1(1), RD1(2), RD1(3))
hold on
plot(G, Dis3,'g');
xlabel('load');
ylabel('Distortion');
