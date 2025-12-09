% Problem i)
% Maximize 30*x1 + 20*x2
% Subject to:
% 2*x1 + x2 <= 1500
% x1 + x2 <= 1200
% x1 <= 500

f1 = [-30; -20]; % Negated for maximization
A1 = [2, 1; 
      1, 1; 
      1, 0];
b1 = [1500; 1200; 500];
lb1 = [0; 0];

[x1, fval1] = linprog(f1, A1, b1, [], [], lb1);

fprintf('Problem i:\n');
fprintf('x1 = %.2f, x2 = %.2f\n', x1(1), x1(2));
fprintf('Max value = %.2f\n\n', -fval1);


% Problem ii)
% Maximize 12*x1 + 7*x2
% Subject to:
% 2*x1 + x2 <= 10000
% 3*x1 + 2*x2 <= 16000

f2 = [-12; -7]; % Negated for maximization
A2 = [2, 1; 
      3, 2];
b2 = [10000; 16000];
lb2 = [0; 0];

[x2, fval2] = linprog(f2, A2, b2, [], [], lb2);

fprintf('Problem ii:\n');
fprintf('x1 = %.2f, x2 = %.2f\n', x2(1), x2(2));
fprintf('Max value = %.2f\n\n', -fval2);


% Problem iii)
% Maximize 2*x1 + 5*x2
% Subject to:
% x1 + 4*x2 <= 24
% 3*x1 + x2 <= 21
% x1 + x2 <= 9
% x2 <= 4

f3 = [-2; -5]; % Negated for maximization
A3 = [1, 4; 
      3, 1; 
      1, 1; 
      0, 1];
b3 = [24; 21; 9; 4];
lb3 = [0; 0];

[x3, fval3] = linprog(f3, A3, b3, [], [], lb3);

fprintf('Problem iii:\n');
fprintf('x1 = %.2f, x2 = %.2f\n', x3(1), x3(2));
fprintf('Max value = %.2f\n', -fval3);


% Problem b) Politician Optimization
% Variables x1, x2, x3, x4 represent spending (in 1000 EUR) on:
% x1: Straßenbau
% x2: Sicherheit
% x3: Landwirtschaftsbeihilfe
% x4: Mineralölsteuer

% Objective: Minimize total cost (sum of x_i)
f_b = [1; 1; 1; 1];

% Constraints (Votes needed >= 50% of population)
% Population: Stadt=100k, Vorstadt=200k, Land=50k
% Needed: Stadt=50k, Vorstadt=100k, Land=25k
% Table values are in thousands of votes per 1000 EUR.
%
% Stadt:    -2*x1 + 8*x2 +  0*x3 + 10*x4 >= 50
% Vorstadt:  5*x1 + 2*x2 +  0*x3 +  0*x4 >= 100
% Land:      3*x1 - 5*x2 + 10*x3 -  2*x4 >= 25
%
% Convert to Ax <= b form by multiplying by -1:
A_b = [ 2, -8,   0, -10;   % Stadt constraint negated
       -5, -2,   0,   0;   % Vorstadt constraint negated
       -3,  5, -10,   2];  % Land constraint negated

b_b = [-50; -100; -25];

lb_b = [0; 0; 0; 0]; % Non-negative spending

[x_b, fval_b] = linprog(f_b, A_b, b_b, [], [], lb_b);

fprintf('\nProblem b (Politician):\n');
fprintf('Spending (in 1000 EUR):\n');
fprintf('Straßenbau: %.2f\n', x_b(1));
fprintf('Sicherheit: %.2f\n', x_b(2));
fprintf('Landwirtschaft: %.2f\n', x_b(3));
fprintf('Mineralölsteuer: %.2f\n', x_b(4));
fprintf('Total Cost: %.2f (1000 EUR)\n', fval_b);

% Calculate resulting votes (in thousands)
votes_stadt = -2*x_b(1) + 8*x_b(2) + 0*x_b(3) + 10*x_b(4);
votes_vorstadt = 5*x_b(1) + 2*x_b(2) + 0*x_b(3) + 0*x_b(4);
votes_land = 3*x_b(1) - 5*x_b(2) + 10*x_b(3) - 2*x_b(4);

fprintf('\nResulting Votes (in thousands):\n');
fprintf('Stadt: %.2f (Target: 50)\n', votes_stadt);
fprintf('Vorstadt: %.2f (Target: 100)\n', votes_vorstadt);
fprintf('Land: %.2f (Target: 25)\n', votes_land);
