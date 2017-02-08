% Statistical Neuroscience, EPFL Spring 2014
% Matlab Miniproject 1
% Starting points...


%%% Step 1: Firing rates.
T = 2000;  % 2 seconds = 2000 milliseconds

%y = firingrate('../data/l2a_good/conspecific/spike1', T, 400);
y = firingrate('spike1', T, 10);

% To crosscheck: The overall average firing rate, in SPIKES PER SECOND, was
sum(y)/(T/1000);
% Now, plot the firingrate as a function of time:
plot([1:T], y);
xlabel('time (msec)');
ylabel('firingrate');

%%% NOW, FOR YOU TO CONTINUE...