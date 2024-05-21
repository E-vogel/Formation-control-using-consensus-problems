clear
close all

% Number of agents
n = 200;

% Initial positions of agents
x0 = 900 * rand(n, 1) - 300;
y0 = 900 * rand(n, 1) - 300;

% Offset vector
RP = [100 100];

% Load image formation coordinates
load('image_coordinate.mat');

% Compute initial relative positions for image formation
RP_image = [x0 y0] + RP .* ones(n, 2) - image_data;

% Adjacency matrix
A = randi([0 1], n);

% Simulation parameters
fin = 0.5;
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
xlim([-inf inf])
ylim([-inf inf])
daspect([1 1 1])
box on
set(gca, 'TickLabelInterpreter', 'latex')
set(gca, 'LooseInset', get(gca, 'TightInset'));

% Simulation loop for image formation
for i = 1:numel(t) - 1
    s.XData = s.XData.' - L * RP_image(:, 1) * h;
    s.YData = s.YData.' - L * RP_image(:, 2) * h;
    RP_image = RP_image - L * RP_image * h;
%     frame = getframe(gcf);
%     writeVideo(v, frame);
    drawnow
end
% close(v);
