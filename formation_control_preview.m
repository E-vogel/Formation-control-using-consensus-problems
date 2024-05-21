clear
close all

% Number of agents
n = 200;

% Initial positions of agents
x0 = 900 * rand(n, 1) - 300;
y0 = 900 * rand(n, 1) - 300;

% Relative Positioning
RP = [100 100];

% Load star formation coordinates
load('star_image_coordinate.mat');

% Compute initial relative positions for star formation
RP_star = [x0 y0] + RP .* ones(n, 2) - star_data;

% Adjacency matrix
A = randi([0 1], n);

% Simulation parameters
fin = 0.05;
h = 0.0001;
t = 0:h:fin;

% Degree matrix and Laplacian matrix
d = zeros(n,1);
for i = 1:n
    d(i) = sum(A(i, :));
end

D = diag(d);
L = D - A;

% Initialize video writer
% v = VideoWriter('formation_control.mp4', 'MPEG-4');
% open(v);

% Plot initial positions
color_str = parula(n);
s = scatter(x0, y0, [], color_str, 'filled');
xlim([-300 600])
ylim([-300 600])
daspect([1 1 1])
box on
set(gca, 'TickLabelInterpreter', 'latex')
set(gca, 'LooseInset', get(gca, 'TightInset'));

% Simulation loop for star formation
for i = 1:numel(t) - 1
    s.XData = s.XData.' - L * RP_star(:, 1) * h;
    s.YData = s.YData.' - L * RP_star(:, 2) * h;
    RP_star = RP_star - L * RP_star * h;
%     frame = getframe(gcf);
%     writeVideo(v, frame);
    drawnow
end

% Rotation and formation control loop for star
for i = 1:numel(t) - 1
    s.XData = s.XData.' - L * RP_star(:, 1) * h;
    s.YData = s.YData.' - L * RP_star(:, 2) * h;
    theta = 0.003 * i;
    R = [cos(theta) -sin(theta); sin(theta) cos(theta)];
    star_data_r = zeros(n,2);
    for j = 1:n
        star_data_r(j,:) = star_data(j, :) * R;
    end
    RP_star = [s.XData.' s.YData.'] + RP .* ones(n, 2) - star_data_r;
    RP_star = RP_star - L * RP_star * h;
%     frame = getframe(gcf);
%     writeVideo(v, frame);
    drawnow
end

% Load heart formation coordinates
load('heart_image_coordinate.mat');

% Compute initial relative positions for heart formation
RP_heart = [s.XData.' s.YData.'] + RP .* ones(n, 2) + 1.2 * [heart_data(:, 1) heart_data(:, 2)];

d = 1;
% Simulation loop for heart formation
for i = 1:1000
    s.XData = s.XData.' - L * RP_heart(:, 1) * h;
    s.YData = s.YData.' - L * RP_heart(:, 2) * h;
    if mod(i, 100) == 0
        d = d + 1;
        if mod(d, 2) == 0
            RP_heart = [s.XData.' s.YData.'] + RP .* ones(n, 2) + [heart_data(:, 2) heart_data(:, 1)];
        else
            RP_heart = [s.XData.' s.YData.'] + RP .* ones(n, 2) + 1.5 * [heart_data(:, 2) heart_data(:, 1)];
        end
    end
    RP_heart = RP_heart - L * RP_heart * h;
%     frame = getframe(gcf);
%     writeVideo(v, frame);
    drawnow
end

% Load butterfly formation coordinates
load('butterfly_image_coordinate.mat');

% Compute initial relative positions for butterfly formation
RP_butterfly = [s.XData.' s.YData.'] + RP .* ones(n, 2) + [butterfly_data(:, 2) butterfly_data(:, 1)];

% Simulation loop for butterfly formation
for i = 1:numel(t) - 1
    s.XData = s.XData.' - L * RP_butterfly(:, 1) * h;
    s.YData = s.YData.' - L * RP_butterfly(:, 2) * h;
    RP_butterfly = RP_butterfly - L * RP_butterfly * h;
%     frame = getframe(gcf);
%     writeVideo(v, frame);
    drawnow
end
% close(v);
