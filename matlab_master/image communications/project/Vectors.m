function[C]=Vectors
%trials
%N = 6
I = 0:0.05:1;
g =1;
for l=1 : numel(I)
 for k  =1: numel(I)
     for h  =1: numel(I)
         [l k h]
        for w  =1: numel(I)
             for m = 1:numel(I)
                 for d = 1: numel(I)
                 if I(l)+I(k)+I(h)+I(w)+I(m)+I(d) == 1;
                     C{g}= [I(l) I(k) I(h) I(w) I(m) I(d)];
                     g = g+1;
                 end
             end
        end
    end
 end
 end
end

          