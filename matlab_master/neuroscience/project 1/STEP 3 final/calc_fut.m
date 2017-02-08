function [Stimulus, Response] = calc_fut(Windowlength,FutWindowlength,stim,y)
J = 32 *(Windowlength+FutWindowlength);

N=min(floor((length(stim)-J)/32),2000-Windowlength );
Stimulus = zeros(J, N);
Response = zeros(1, N);
for n=1:N,
    Stimulus(:,n) = abs(stim(32*(n-1)+1:32*(n-1)+J))';
    Response(n) = y(Windowlength+n-1);
end

end