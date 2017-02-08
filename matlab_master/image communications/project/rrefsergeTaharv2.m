function [dec, tab3]= rrefsergeTaharv2(x) 
y = true;
dec = 0;
tab3=[];
while (y)
s1 = size(x, 1);
s2 = size(x, 2);
tab2 =[];
parfor k =1:s2
    w = find(x(:,k)==1);
    l= numel(w);
if l==1
tab2 =[tab2, find(x(:,k)==1)];
tab3 =[tab3, find(x(:,k)==1)];
end
end
tab2=unique(tab2);
if isempty(tab2)
    break;
end
x(tab2,:)=0;
dec = dec+numel(tab2);
end
tab3=unique(tab3);
end