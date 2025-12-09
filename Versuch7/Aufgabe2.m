f1 = [30; 20];
A1 = [2, 1; 1, 1; 1, 0];
b1 = [1500; 1200; 500];

f2 = [12, 7];
A2 = [2, 1; 3, 2];
b2 = [10000; 16000];

f3 = [2; 5];
A3 = [1, 4; 3, 1; 1, 1; 0, 1];
b3 = [24; 21; 9;  4];

x1 = linprog(-f1, A1, b1, [], [], [0; 0]);
x2 = linprog(-f2, A2, b2, [], [], [0; 0]);
x3 = linprog(-f3, A3, b3, [], [], [0; 0]);

disp("Optimal solutions for first problem:");
disp(x1);
disp("Optimal solutions for second problem:");
disp(x2);
disp("Optimal solutions for third problem:");
disp(x3);