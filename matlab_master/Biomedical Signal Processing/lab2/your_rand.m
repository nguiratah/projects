function x = your_rand(N);

% x = your_rand(N)
% Create a Bernouilli signal of length N using mouse input
% If you click on the blue you get -1
% If you click on the red you get +1
% x output signal 

image([1 255]);
[x,y] = ginput(N);
x = 2*(x>1.5)-1;
