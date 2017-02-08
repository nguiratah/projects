% %Question 1
% close all;
% clear all;
% clc;
% load('AF_sync.dat');
% ord2=[];
% a=[];
% e=[];
% for k=1:(length(AF_sync)/250-1)
%     ord2=[ord2 AR_order(AF_sync(250*(k-1)+1:(250*(k+1))),50,0)];
%     [a1,e1]=arcov(AF_sync(250*(k-1)+1:(250*(k+1))),ord2(k));
%     a=[a a1];
%     e=[e,e1];
% end
% figure();
% subplot(4,1,1)
% plot(AF_sync)
% title('AF sync')
% subplot(4,1,2);
% plot(ord2);
% title('ordre');
% subplot(4,1,3);
% plot(a);
% title('a');
% subplot(4,1,4);
% plot(e/var(AF_sync));
% title('e/var(AF sync)'),
% figure();
% plot(AF_sync)
% Question 2
for k=10%1:length(ord2)
    t = linspace(0,2*pi,1000); 
    figure();
    plot(cos(t),sin(t)); 
    axis('square') 
    set(gca,'Xlim',[-1.5 1.5]); 
    set(gca,'Ylim',[-1.5 1.5]); 

    hold on;
    plot(roots(aryule(AF_sync,ord2(k))),'r*');
end