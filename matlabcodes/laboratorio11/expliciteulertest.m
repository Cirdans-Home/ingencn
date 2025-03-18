clc; close all; clear all;
%% Il metodo di Eulero esplicito
f = @(x,y) -y; 
ytrue = @(x) exp(-x);
% 0 < h < 2
% h = [1, 1.9, 2, 0.9, 2.1]

% y_n = (1+lambda h)^n y_0 = (1-h)^n y_0

y0 = 1;

a = 0;
b = 100;
h = 1e-2;

[y,x] = impliciteuler(f,y0,a,b,h);
figure(1)
plot(x, ytrue(x), LineWidth=2);
hold on

list_of_h = [1, 1.6, 2, 0.3, 2.01];
xlabel('x');
legend_labels = cell(1, length(list_of_h)); % Preallocate a cell array for legend labels
legend_labels{1} = 'Exact'
for i = 1:length(list_of_h)
    h = list_of_h(i);
    [y, x] = impliciteuler(f, y0, a, b, h);
    plot(x, y, LineWidth=2);
    legend_labels{i+1} = ['h = ', num2str(h)]; % Create the label for the current plot
end

legend(legend_labels, FontSize=24); % Add the legend to the plot
