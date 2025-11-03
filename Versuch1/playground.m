signal = [1 2 4 7 11 16 22];

% Forward difference filter: [1 -1 0]
forward_filter = [1 -1 0];
forward_diff = conv(signal, forward_filter, 'same');

% Backward difference filter: [0 1 -1]
backward_filter = [0 1 -1];
backward_diff = conv(signal, backward_filter, 'same');

disp('Original signal:');
disp(signal);
disp('Forward difference:');
disp(forward_diff);
disp('Backward difference:');
disp(backward_diff);

plot(signal, 'k-o'); hold on;
plot(forward_diff, 'r--');
plot(backward_diff, 'b-.');
legend('Original', 'Forward diff', 'Backward diff');
hold off;