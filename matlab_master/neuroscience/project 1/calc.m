function[Stimulus1, Response1] = calc(Windowlength,stim1, y1); 
J = 32 * Windowlength;
N1 = min( floor((length(stim1)-J)/32), 2000-Windowlength );
Stimulus1 = zeros(J, N1);
Response1 = zeros(1, N1);
for n=1:N1
    Stimulus1(:,n) = abs(stim1(32*(n-1)+1:32*(n-1)+J))';
    Response1(n) = y1(Windowlength+n-1);
end
