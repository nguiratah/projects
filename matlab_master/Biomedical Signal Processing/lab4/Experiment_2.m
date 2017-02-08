load('bci.mat');
ord2=[];
for k=1:4
    ord2=[ord2 AR_order(left_hand(:,k),10,0)];
end
ord1=[];
for k=1:4
    ord1=[ord1 AR_order(right_foot(:,k),5,0)];
end
coeff_lh=[];
for k=1:4
    coeff_lh=[coeff_lh; aryule(left_hand(:,k),3)];
end

coeff_rf=[];
for k=1:4
    coeff_rf=[coeff_rf;aryule(right_foot(:,k),3)];
end

figure();
plot(coeff_lh(:,2),coeff_lh(:,3),'*');
hold on;
plot(coeff_rf(:,2),coeff_rf(:,3),'ro');


 