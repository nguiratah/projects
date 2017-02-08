% Statistical Neuroscience, EPFL Spring 2014
% Matlab Miniproject 1
% Starting points...


%%% Step 1: Firing rates.
T = 2000;  % 2 seconds = 2000 milliseconds

%y = firingrate('../data/l2a_good/conspecific/spike1', T, 400);
y1 = firingrate('matlabSTRF/data/l2a_good/conspecific/spike1', T, 400);
y2 = firingrate('matlabSTRF/data/l2a_avg/conspecific/spike8', T, 400);
y3 = firingrate('matlabSTRF/data/l2a_bad/flatrip/spike6', T, 400);
y4 = firingrate('matlabSTRF/data/mld_avg/songrip/spike7', T, 400);

% To crosscheck: The overall average firing rate, in SPIKES PER SECOND, was
%sum(y)/(T/1000);
% Now, plot the firingrate as a function of time:
plot([1:T], y1);
xlabel('time (msec)');
ylabel('firingrate');
title('spike1 l2a_good conspecific');

figure();
plot([1:T], y2);
xlabel('time (msec)');
ylabel('firingrate');
title('spike8 l2a_avg conspecific');
figure();
plot([1:T], y3);
xlabel('time (msec)');
ylabel('firingrate');
title('spike6 l2a_bad flatrip');
figure();
plot([1:T], y1);
xlabel('time (msec)');
ylabel('firingrate');
title('spike7 mld_avg songrip');

%%% NOW, FOR YOU TO CONTINUE...